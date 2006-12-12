Return-Path: <linux-kernel-owner+w=401wt.eu-S932285AbWLLUPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWLLUPq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 15:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWLLUPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 15:15:45 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:55664 "EHLO
	liaag1ac.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582AbWLLUPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 15:15:45 -0500
Date: Tue, 12 Dec 2006 15:10:56 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-ID: <200612121513_MC3-1-D4D1-4A51@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20061205172512.GA5518@m.safari.iki.fi>

On Tue, 5 Dec 2006 19:25:13 +0200, Sami Farin wrote:

> BUG: unable to handle kernel paging request at virtual address fffb9dc0

> eax: fffb8000   ebx: fffb9000   ecx: 00000090   edx: 00000000
> esi: fffb9dc0   edi: fffb8dc0   ebp: f6f89f24   esp: f6f89ef0

  1f:   89 de                     mov    %ebx,%esi
  21:   b9 00 04 00 00            mov    $0x400,%ecx
  26:   89 45 cc                  mov    %eax,0xffffffcc(%ebp)
  29:   89 c7                     mov    %eax,%edi

   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====

Processor started to copy a page, then with 576 bytes left to copy
the source page got unmapped.  Nice.

This possibly happened during a device interrupt. What does
/proc/interrupts say?

-- 
MBTI: IXTP

