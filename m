Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWFUAIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWFUAIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWFUAIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:08:40 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:15832 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750945AbWFUAIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:08:39 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner 	underruns, USB HDD hard resets)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, andi@lisas.de,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hal@lists.freedesktop.org
Reply-To: 7eggert@gmx.de
Date: Wed, 21 Jun 2006 02:07:56 +0200
References: <6pnj7-32Q-7@gated-at.bofh.it> <6pJWg-34g-5@gated-at.bofh.it> <6pKfL-3sx-29@gated-at.bofh.it> <6pKpl-3Sx-23@gated-at.bofh.it> <6pLll-5iq-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FsqGX-0001eu-AT@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Maw, 2006-06-20 am 11:05 +0200, ysgrifennodd Andreas Mohr:

>> But how would HAL safely determine whether a (IDE/USB) drive is busy?
>> As my test app demonstrates (without HAL running), the *very first* open()
>> happening during an ongoing burning operation will kill it instantly, in the
>> USB case.
>> Are there any options left for HAL at all? Still seems to strongly point
>> towards a kernel issue so far.
> 
> In the IDE space O_EXCL has the needed semantics. At least it does on
> Fedora and I don't think thats a Fedora patch, not sure if this is the
> case for the USB side of things.

This does not work, since O_EXCL does not work:
http://lkml.org/lkml/2006/2/5/137

Instead, I'd (try to) use mandatory locking and prevent open() etc. from
causing the bad commands to be sent.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
