Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268225AbUIFQO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268225AbUIFQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUIFQO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 12:14:59 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64459 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268225AbUIFQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 12:14:56 -0400
Date: Mon, 6 Sep 2004 12:19:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
In-Reply-To: <20040906072859.GB31343@wotan.suse.de>
Message-ID: <Pine.LNX.4.53.0409061211440.14053@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com>
 <20040904111605.GA12165@wotan.suse.de> <Pine.LNX.4.58.0409041420590.11262@montezuma.fsmlabs.com>
 <20040906072859.GB31343@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, 6 Sep 2004, Andi Kleen wrote:

> That is with frame pointers enabled. Indeed with frame pointers
> on it is not true you still have to special case that.

Yes that was with frame pointers enabled, but the following was compiled 
without frame pointers, i'm still not sure it's safe to use *esp.

00000070 <_spin_lock>:
  70:   83 ec 04                sub    $0x4,%esp
  73:   89 c2                   mov    %eax,%edx
  75:   b8 00 e0 ff ff          mov    $0xffffe000,%eax
  7a:   21 e0                   and    %esp,%eax
  7c:   ff 40 14                incl   0x14(%eax)
  7f:   31 c0                   xor    %eax,%eax
  81:   86 02                   xchg   %al,(%edx)
  83:   84 c0                   test   %al,%al
  85:   7e 02                   jle    89 <_spin_lock+0x19>
  87:   58                      pop    %eax
  88:   c3                      ret
  89:   89 14 24                mov    %edx,(%esp)
  8c:   e8 fc ff ff ff          call   8d <_spin_lock+0x1d>
  91:   eb f4                   jmp    87 <_spin_lock+0x17>
  93:   8d b6 00 00 00 00       lea    0x0(%esi),%esi
  99:   8d bc 27 00 00 00 00    lea    0x0(%edi),%edi

Thanks,
	Zwane

