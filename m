Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314143AbSDLVRZ>; Fri, 12 Apr 2002 17:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314144AbSDLVRY>; Fri, 12 Apr 2002 17:17:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:63159 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S314143AbSDLVRX>;
	Fri, 12 Apr 2002 17:17:23 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 12 Apr 2002 21:17:19 GMT
Message-Id: <UTC200204122117.VAA619304.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, mark.post@eds.com
Subject: RE: PROBLEM: kernel mount of initrd fails unless mke2fs uses 1024 byt e blocks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        The kernel does set_blocksize() to change the blocksize of your
        device. This set_blocksize() throws away all buffers with the
        now incorrect size. But your device is a ramdisk, and throwing
        out these buffers kills all your data.

    Andries,

    Thanks for the update.  So, what do I do now?
    Wait for a fix for 2.2?  Send my problem report to someone else?

First you check whether my analysis is correct:
check that after the failed mount attempt the ramdisk
does not hold any data anymore. (Say with od or so.)

Now we have a known problem. You can avoid meeting it
by only using blocksize 1024. On the kernel side this
of course will have to be fixed some time.
I think Adam Richter once submitted a patch to fix this,
but apparently it was not taken.
For 2.5 I think the aim must be to get rid of set_blocksize()
entirely. I don't know whether 2.2 and 2.4 will be fixed.

Andries
