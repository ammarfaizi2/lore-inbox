Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUFBVr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUFBVr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUFBVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:47:29 -0400
Received: from cantor.suse.de ([195.135.220.2]:46822 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264226AbUFBVr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:47:28 -0400
Date: Wed, 2 Jun 2004 23:43:50 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       arjanv@redhat.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
Message-Id: <20040602234350.7332dd8e.ak@suse.de>
In-Reply-To: <20040602205025.GA21555@elte.hu>
References: <20040602205025.GA21555@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004 22:50:25 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> we'd like to announce the availability of the following kernel patch:
> 
>      http://redhat.com/~mingo/nx-patches/nx-2.6.7-rc2-bk2-AE

I think you still have the change_page_attr() bug that I so far
didn't manage to fix on x86-64 properly neither (I had one patch, but 
it caused mysterious other failures). Currently x86-64 has a nasty 
partly broken workaround for this only that can cause illegal aliases.

The bug is when change_page_attr() splits a kernel text page
and reverts it back then the NX bit gets set on the kernel
text page. This happens when AGP allocates a page that lies 
within 2MB of the kernel mapping.

-Andi
