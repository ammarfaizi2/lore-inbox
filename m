Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUK1WoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUK1WoU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUK1WoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 17:44:19 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:12471 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261598AbUK1Wmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 17:42:55 -0500
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E1CXsB9-00022M-00@chiark.greenend.org.uk>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101298112.5805.330.camel@desktop.cunninghams>
	 <20041125233243.GB2909@elf.ucw.cz> <20041125233243.GB2909@elf.ucw.cz>
	 <1101427035.27250.161.camel@desktop.cunninghams>
	 <E1CXsB9-00022M-00@chiark.greenend.org.uk>
Content-Type: text/plain
Message-Id: <1101681564.4343.307.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 29 Nov 2004 09:39:25 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew.

On Sat, 2004-11-27 at 13:19, Matthew Garrett wrote:
> We have userspace to do this, surely? Make the standard method of
> triggering resume involve an initrd, and have a small application that
> does sanity checks before the resume. In case of failure, have it prompt
> the user. As long as it doesn't do bad things to the filesystem,
> there's no danger. There's no reason to do this in the kernel.

It was originally done in kernel space prior to us having initrd
support, as a small extension on what was already there. I don't see a
good reason to move it to working from an initrd because:

1) We're then assuming that everyone uses an initrd/initramfs, which is
not true
2) We need to provide a way for this userspace program to obtain from
the kernel the signature of the image and information about what we want
the signature to look like. It will also then need to be able to tell
the kernel to delete the image.
3) If you want the userspace program to actually read the signature
itself, the kernel still needs to tell the userspace program where to
find that signature (what device, block and blocksize). That device
can't be mounted/swapon'd to do this; it needs to be a raw read.
4) This whole method means there's even more code to maintain!

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

