Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUH0LFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUH0LFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 07:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUH0LFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 07:05:25 -0400
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:31136 "EHLO
	ppsw-5.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262837AbUH0LFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 07:05:14 -0400
Subject: Re: data loss in 2.6.9-rc1-mm1
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Gergely Tamas <dice@mfa.kfki.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040827105543.GA10563@mfa.kfki.hu>
References: <20040827105543.GA10563@mfa.kfki.hu>
Content-Type: text/plain
Organization: University of Cambridge Computing Service, UK
Message-Id: <1093604706.5994.54.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 12:05:06 +0100
Content-Transfer-Encoding: 7bit
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 11:55, Gergely Tamas wrote:

> I've hit the following data loss problem under 2.6.9-rc1-mm1.
> 
> If I copy data from a file to another the target will be smaller then
> the source file.
[snip]
> $ uname -r
> 2.6.9-rc1-mm1
> 
> $ dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
> 10+0 records in
> 10+0 records out
> 10485760 bytes transferred in 0.028418 seconds (368981986 bytes/sec)
> 
> $ du -sb testfile
> 10485760        testfile
> 
> $ cat testfile > testfile.1
> 
> $ du -sb testfile.1
> 10481664        testfile.1

The difference is exactly 4096 bytes, i.e. 1 whole page.  Seems like an
off-by-one error somewhere in the file access or page cache code.

It would be interesting to know whether the read is truncated or whether
the write is truncated.  So could you tell us what is returned by:

cat testfile | wc -c

Also your .config would probably be helpful.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

