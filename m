Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUAFUVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 15:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbUAFUVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 15:21:35 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:39102 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S265062AbUAFUVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 15:21:33 -0500
From: Duncan Sands <baldrick@free.fr>
To: "Guldo K" <guldo@tiscali.it>
Subject: Re: speedtouch for 2.6.0
Date: Tue, 6 Jan 2004 21:21:18 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <16366.61517.501828.389749@gargle.gargle.HOWL> <200312301702.26973.baldrick@free.fr> <16378.65140.114558.996798@gargle.gargle.HOWL>
In-Reply-To: <16378.65140.114558.996798@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401062121.18531.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guldo,

> I compiled 2.4.22, and tried to install speedbundle;
> but it looks like I still have the very same error
> messages... I'd try and understand what kernel headers
> *are* (sorry), but in the meantime I switched back to
> the user driver.

Looks like your libc has 2.6 kernel headers.  I refer you to my
previous answer:

You are compiling against 2.6 kernel headers.
(Most people have 2.4 kernel headers in
/usr/include/linux, even if they are running a
2.6 kernel).  You will need to update the
firmware_loader directory.  Do the following:

        cvs -d:pserver:anonymous@cvs.speedtouch.sourceforge.net:/cvsroot/speedtouch login

(just hit return if asked for a password).  Then do

        cvs -z 9 -d:pserver:anonymous@cvs.speedtouch.sourceforge.net:/cvsroot/speedtouch co speedtouch

This creates a directory called speedtouch.  Replace the contents of the
firmware_loader directory with the contents of this new speedtouch
directory.  Now rebuild: in the top level of the speedbundle do

        make clean
        make
(become root)
        make install


> One more thing to ask you: I discarded all the config
> made for the kernel driver (I think so...), but as I plug
> my modem in, the speedtch module is loaded.
> I have to unload it in order to get modem_run to work
> properly with the user driver.
> Why is it so? How can I make speedtch not to be loaded
> automatically, if I can?
> (without recompiling the kernel)

Remove the speedtch.o file in
/lib/modules/(kernelversion)/kernel/drivers/usb

Ciao,

Duncan.
