Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWEJSnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWEJSnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWEJSno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:43:44 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:33214 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932464AbWEJSno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:43:44 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 10 May 2006 19:43:40 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Joshua Hudson <joshudson@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Not mounting NTFS rw, 2.6.16.1, but does so on 2.6.15
In-Reply-To: <bda6d13a0605100924u12270e3dh5f6b519ee0d0b14f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605101937170.32568@hermes-1.csi.cam.ac.uk>
References: <bda6d13a0605092320y5cca6e1co2228f52c9777c3b1@mail.gmail.com> 
 <Pine.LNX.4.64.0605100957040.28166@hermes-1.csi.cam.ac.uk>
 <bda6d13a0605100924u12270e3dh5f6b519ee0d0b14f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Joshua Hudson wrote:
> On 5/10/06, Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > On Tue, 9 May 2006, Joshua Hudson wrote:
> > > which means cannot re-run lilo on my laptop, so Not progressing beyond
> > > 2.6.15 until fixed.
> > > Downloading 2.6.16.15 to try that version now.
> > >
> > > 16kstacks patch was applied (I use ndiswrapper with broadcom drivers
> > loaded).
> > 
> > What are the error messages?  (Run dmesg to find out.)
> 
> Verified on 2.6.16.15. 16kstacks applied. ndiswrapper not loaded.
> 
> Dmesg:
> 
> [snip]
> EXT3 FS on hdc7, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> NTFS volume version 3.1.
> NTFS-fs warning (device hdc1): load_system_files(): Unsupported volume
> flags 0x4000 encountered.
> NTFS-fs error (device hdc1): load_system_files(): Volume has
> unsupported flags set.  Mounting read-only.  Run chkdsk and mount in
> Windows.

0x4000 is VOLUME_CHKDSK_UNDERWAY.  It means your volume is in the middle 
of having chkdsk run on it.  Do as the driver says: run chkdsk on it and 
mount in Windows and the error will go away and you will be able to mount 
in Linux read/write...

Here is the minimum you have to do:

- Boot windows and log in.
- Open command prompt and type: chkdsk c: /f /v /x
- Windows will ask you if you want to schedule the chkdsk for next reboot.  
Answer yes and reboot.
- Allow chkdsk to run to completion.  Windows will reboot again.
- Boot windows again and log in.
- Open command prompt and type: dir c:\
- Reboot.
The below may be required in some circumstances but may well not be 
necessary so you can try mounting in Linux r/w now and if it still does 
not work then do this:
- Boot into windows _again_ and log in.
- Open command prompt and type: dir c:\
- Reboot.

You should now definitely have cleaned up the volume for Linux to be able 
to mount r/w.

Should it still not work, please let me know but you would be the first 
one for whom the above sequence would not have fixed it...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
