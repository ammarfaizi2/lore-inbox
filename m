Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbVJSLKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbVJSLKP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJSLKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:10:15 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:49799 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964792AbVJSLKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:10:13 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Warning: Serious NTFS data corruption bug! + Fix! - Was: Re: ntfs
	CFT - was: Re: 2.6.14-rc4-mm1
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Alberto Patino <pato.lukaz@gmail.com>
Cc: ntfs-dev <linux-ntfs-dev@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4489a22a0510181048n60ec5952i33d52c1b3527f906@mail.gmail.com>
References: <20051016154108.25735ee3.akpm@osdl.org>
	 <1129542967.26285.30.camel@imp.csi.cam.ac.uk>
	 <4489a22a0510172209v322e9d9eqe90c489c66b5c83b@mail.gmail.com>
	 <Pine.LNX.4.64.0510180859580.7514@hermes-1.csi.cam.ac.uk>
	 <4489a22a0510181026v577f9b0ev535cf0acc74661f@mail.gmail.com>
	 <4489a22a0510181048n60ec5952i33d52c1b3527f906@mail.gmail.com>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Wed, 19 Oct 2005 12:10:03 +0100
Message-Id: <1129720203.26939.21.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To all: There is serious data corruption issue with ntfs in
2.6.14-rc4-mm1 (and ntfs 2.1.25 release in general, not just -mm).  Fix
is below.  Hopefully this is the only bug!

On Tue, 2005-10-18 at 12:48 -0500, Alberto Patino wrote:
> On 10/18/05, Alberto Patino <pato.lukaz@gmail.com> wrote:
> > Hi Anton, not too lucky doing modifications with soffice to  word documents.
> > Saving files is ok but when I reopen the files, the format is lost...
> > I'll try to recover them from Word.exe
> Anton:
> I'm afraid I have bad news, I couldn't boot W2K, I got this message
> translated fom spanish:
> 
> STOP: C0000221 { checksum image test incorrect }
> 
> Something weird, I edited txt file A with vim, then I edited Word File
> B with soffice, I close it, then I reopened. I lost format so the file
> is not legible but I can see  paragraphs from file A in file B!!!!!

I am really sorry about this.  )-:  You should be able to hopefully fix
windows by booting with the installation CD and going into recovery
console and running chkdsk on the partition.  You can also try running
ntfsfix from ntfsprogs and then booting into windows.  This may be
sufficient to allow it to do a chkdsk on the partition before it
crashes.

I found a bug that caused corruption of the openoffice document as you
described.  The fix is below.

diff -urNp /usr/src/ntfs-2.6-devel/fs/ntfs/file.c ntfs26dev/file.c
--- /usr/src/ntfs-2.6-devel/fs/ntfs/file.c	2005-10-11 15:00:00.000000000 +0100
+++ ntfs26dev/file.c	2005-10-19 11:50:54.859558000 +0100
@@ -787,6 +787,7 @@ retry_remap:
 				vcn_len = rl[1].vcn - vcn;
 				lcn_block = lcn << (vol->cluster_size_bits -
 						blocksize_bits);
+				cdelta = 0;
 				/*
 				 * If the number of remaining clusters in the
 				 * @pages is smaller or equal to the number of

Thank you very much for testing and I am really sorry it caused the
corruption to your partition.  In the future I will make sure to say
"Please only test on test partitions."...

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

