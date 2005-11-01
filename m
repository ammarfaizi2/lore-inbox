Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVKAQXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVKAQXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVKAQXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:23:30 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:23485 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750925AbVKAQXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:23:30 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 1 Nov 2005 16:22:52 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] [2.6-GIT] NTFS: Release 2.1.25.
In-Reply-To: <1130857307.12767.15.camel@pc299.sam-solutions.net>
Message-ID: <Pine.LNX.4.64.0511011610350.17031@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.64.0510311408160.27357@hermes-1.csi.cam.ac.uk> 
 <1130790267.2276.8.camel@localhost>  <Pine.LNX.4.64.0510312040010.10190@hermes-1.csi.cam.ac.uk>
  <1130793939.2104.19.camel@localhost>  <Pine.LNX.4.64.0510312136500.10190@hermes-1.csi.cam.ac.uk>
  <1130856488.12766.14.camel@pc299.sam-solutions.net> 
 <1130856987.7361.1.camel@imp.csi.cam.ac.uk> <1130857307.12767.15.camel@pc299.sam-solutions.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yura,

The bug is now fixed.  (-:  I copied you on the email with the patch...  
It turns out it was nothing to do with multiple extents.  It only happened 
if you started out writing on a cold cache which I had never done before 
as I always wrote after having read so it always worked for me.  I will 
remember in future to try cold cache cases, too.  And the bug is a really 
stupid thing where I am not sure how I managed to get that if so badly 
wrong, even as far as repeating the same condition twice!  )-:

The multiple extents case which I now tried also, now works to the extent 
that the truncate is aborted and reverted and the cp then proceeds on the 
non-truncated file, i.e. you see no errors from cp (you do see error in 
dmesg of course) and the target file now contains the source file, 
followed by the remaining old contents if the source file was shorter than 
the destination file.  That is a bit surprising to the user but at least 
there is no data loss...  It is the best I can/want to do at the moment.  
After all, once truncate is supported more fully, this "feature" will go 
away and this will not be too much work to complete but I want to sort 
out mmap()-ed writes first before I go back to truncate and to 
attribute list attribute support in general...

Thanks a lot for reporting the bug!  (-:

On Tue, 1 Nov 2005, Yura Pakhuchiy wrote:
> On Tue, 2005-11-01 at 14:56 +0000, Anton Altaparmakov wrote:
> > I guess I just assume that anyone using -mm kernels know where the
> > patches are (in case you did not know -mm is not in git, it is simple
> > pathes, one for the whole -mm and then there are broken out patches, so
> > there is an ntfs patch).
> 
> Yes, I had not knew that. Thanks.

Ah, ok.  If you go to a kernel.org mirror and look at:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/

And then at the kernel you are interested in, e.g. lets take the latest 
-mm, then you will find the full -mm patch and the broken out bits in the 
following URLs respectively:

full mm:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/

broken out:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/broken-out/

And thusly, the ntfs patch from the developmental ntfs git repository 
would be:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/broken-out/git-ntfs.patch

It is also worth looking in the broken out directory for other patches 
with ntfs in the name, as Andrew may have other ntfs patches.  In the 
above -mm, there is for example:
http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/broken-out/ntfs-printk-warning-fixes.patch

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
