Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262217AbUK3Rtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUK3Rtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUK3Rto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 12:49:44 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50069 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262217AbUK3RtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:49:23 -0500
Date: Tue, 30 Nov 2004 18:49:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: file as a directory
In-Reply-To: <04113011354200.08643@tabby>
Message-ID: <Pine.LNX.4.53.0411301844100.16712@yvahk01.tjqt.qr>
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
 <1101832103.2885.4.camel@zathras.emsl.pnl.gov> <Pine.LNX.4.53.0411301740430.1622@yvahk01.tjqt.qr>
 <04113011354200.08643@tabby>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> [quote]
>> >[and another one]
>>
>> Do you really want to put an XML parser and all the associated code
>> (read: McDonalds*) into the kernel?
>
>AND assume the XML file is correct...

AND use newer compilers that supposedly create bigger code.

(I do not say that they do, and I neither say that they do not, I just read
about the backwards compat on kerneltraffic.)

Clearly, this is either a userspace job (-> FUSE, hint, hint) or nothing at
all. What if this madness was applied to any file{,-type} in the FS? You could
open() something and always got a shot (i.e. open(...) = ESUCCESS).

Having something like /etc/passwd/daemon spitting out the GECOS for user
"daemon" would make systems more open for stack smash attacks. Instead of
trying to squash a lot of shellcode just to read <your favorite file>, you just
need to use <your favorite file>/<your favorite entry> and *poof*. Even worse
when it's done with O_RDWR / O_WRONLY.

Hell, I do not even want to imagine

	unlink("unlinkthisfile");
	if(stat("unlinkthisfile", &sb) == 0) {
		BUG(); <--
	}

"<--" coming true just because that's the logic of some extension module.


Jan Engelhardt
-- 
ENOSPC
