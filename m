Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUHWR0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUHWR0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUHWRYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:24:49 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19090 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266213AbUHWRYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:24:23 -0400
Subject: Re: Problems compiling kernel modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lei Yang <leiyang@nec-labs.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, root@chaos.analogic.com,
       Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412A10ED.3080809@nec-labs.com>
References: <20040821214402.GA7266@mars.ravnborg.org>
	 <4127A662.2090708@nec-labs.com> <20040821215055.GB7266@mars.ravnborg.org>
	 <4127B49A.6080305@nec-labs.com> <1093121824.854.167.camel@krustophenia.net>
	 <4129FAC8.3040502@nec-labs.com> <Pine.LNX.4.53.0408231018001.7732@chaos>
	 <412A01AC.5020108@nec-labs.com> <Pine.LNX.4.53.0408231046190.7816@chaos>
	 <412A077C.1080501@nec-labs.com> <20040823152540.GA8791@mars.ravnborg.org>
	 <412A10ED.3080809@nec-labs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093278099.29850.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 17:21:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 16:44, Lei Yang wrote:
> I was trying to build a compression/decompression utility with my 
> algorithm in kernel, and want to use it in some of the device drivers.
> And in that algorithm, we need floating-point.

In which case the best place to look (if it needs to be kernel side) is
probably drivers/md/ which shows how you can use the FPU state. There is
a cost to it as you have to save/restore the user FP state and on x86
that is expensive of course.

Historically we've always tried to keep compression algorithms in user
space. The video4linux layer for example pushes most of this to the user
and that allows the user program to make a more intelligent assessment
of the input format and desired target. This avoids things like kernel
drivers turning data from one format to another and user space libraries
turning it back again.

Alan

