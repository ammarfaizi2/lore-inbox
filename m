Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314146AbSDLV3A>; Fri, 12 Apr 2002 17:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314147AbSDLV27>; Fri, 12 Apr 2002 17:28:59 -0400
Received: from ahmler1.mail.eds.com ([192.85.154.71]:46560 "EHLO
	ahmler1.mail.eds.com") by vger.kernel.org with ESMTP
	id <S314146AbSDLV26>; Fri, 12 Apr 2002 17:28:58 -0400
Message-ID: <564DE4477544D411AD2C00508BDF0B6A0C9DD15F@usahm018.exmi01.exch.eds.com>
From: "Post, Mark K" <mark.post@eds.com>
To: "'Andries.Brouwer@cwi.nl'" <Andries.Brouwer@cwi.nl>,
        linux-kernel@vger.kernel.org
Subject: RE: PROBLEM: kernel mount of initrd fails unless mke2fs uses 1024
	 byte blocks
Date: Fri, 12 Apr 2002 17:28:48 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.51)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries,

That won't be possible.  Since this initrd is my root file system, when the
kernel fails to mount it, it goes into a panic and I'm dead.  Any other
suggestions?

Mark

-----Original Message-----
From: Andries.Brouwer@cwi.nl [mailto:Andries.Brouwer@cwi.nl]
Sent: Friday, April 12, 2002 5:17 PM
To: Andries.Brouwer@cwi.nl; linux-kernel@vger.kernel.org;
mark.post@eds.com
Subject: RE: PROBLEM: kernel mount of initrd fails unless mke2fs uses
1024 byt e blocks


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
