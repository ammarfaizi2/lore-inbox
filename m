Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWCPCUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWCPCUH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWCPCUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:20:07 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:63695 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751429AbWCPCUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:20:05 -0500
From: Con Kolivas <kernel@kolivas.org>
Subject: swsusp_suspend continues?
Date: Thu, 16 Mar 2006 13:20:35 +1100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313113631.GA1736@elf.ucw.cz> <20060315103711.GA31317@suse.de>
In-Reply-To: <20060315103711.GA31317@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: "Undisclosed.Recipients":;
Message-Id: <200603161320.36051.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel

I've been playing with hooking in the post resume swap prefetch code into 
swsusp_suspend and just started noting this on 2.6.16-rc6-mm1:
During the _suspend_ to disk cycle on this machine the swsusp_suspend function 
appears to continue beyond swsusp_arch_suspend as I get the same messages 
that I would normally get during a resume cycle such as this:

Suspending device platform
swsusp: Need to copy 14852 pages
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0
and...
eth1: Coming out of suspend...
and so on

but then it manages to write to disk and power down anyway. Is this correct? 

If I put post_resume_swap_prefetch at the end of swsusp_suspend it hits that 
function on both resume _and_ suspend cycles. Am I missing something?

Cheers,
Con
