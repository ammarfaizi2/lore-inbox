Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWDVTvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWDVTvt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWDVTvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:51:49 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:58051 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751093AbWDVTvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:51:48 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Andi Kleen <ak@suse.de>
Subject: Re: Linux 2.6.17-rc2
Date: Sat, 22 Apr 2006 14:21:07 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       meissner@suse.de
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <200604220153.44984.s0348365@sms.ed.ac.uk> <200604220307.17383.ak@suse.de>
In-Reply-To: <200604220307.17383.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221421.07613.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 April 2006 02:07, Andi Kleen wrote:
[snip]
> They probably forget to set PROT_EXEC in either mprotect or mmap somewhere.
> You can check in /proc/*/maps which mapping contains the address it is
> faulting on and then try to find where it is allocated or mprotect'ed.

Turned out this was exactly what the problem was. Wine attempts to match 
Windows as far as read/write/execute mappings go, and war3.exe tried to 
execute memory in a section with "MEM_EXECUTE" not set.

I'm surprised the program works on Windows with DEP/NX enabled, but apparently 
it does. There's a patch floating around on the Wine mailing list which adds 
a workaround for this problem:

http://www.winehq.org/pipermail/wine-devel/2006-April/046935.html

Many thanks to Marcus Meissner for debugging it.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
