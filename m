Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbVIYXj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbVIYXj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbVIYXj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 19:39:58 -0400
Received: from fep19-0.kolumbus.fi ([193.229.0.45]:25253 "EHLO
	fep19-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1750797AbVIYXj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 19:39:58 -0400
Date: Mon, 26 Sep 2005 02:39:00 +0300 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@dhcppc0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: Linux NTFS Vista compatibility (was: Re: [2.6-GIT] NTFS: Release
 2.1.24.)
In-Reply-To: <200509252335.37780.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0509260216570.14235@dhcppc0>
References: <Pine.LNX.4.21.0509252047090.21817-100000@mlf.linux.rulez.org>
 <200509252335.37780.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Sep 2005, Alistair John Strachan wrote:

> I have limited access to the beta, as it expires every 30 days and forces 
> me to reinstall it. I promise to get back to all of you after 2.6.14 is 
> released with the LogFile changes.

Thanks. Also, if you don't want to patch or compile yourself now then you 
could just download and unpack this latest CVS ntfsclone binary (used by us 
to collect NTFS metadata images for investigation):

     http://linux-ntfs.sf.net/snapshots/ntfsclone-static-1.11.3-WIP2.tgz

and run e.g.

     ntfsclone --metadata --output vista-ntfs.img <partition>

If it gives an error then rerun with the --debug option and the end of the 
output will tell what's the reason for the failure.

> To clarify, I did not leave the Vista NTFS volume in an inconsistent 
> state. I even forced a chkdsk, rebooted, let it run through, then 
> attempted again to mount it with the NTFS code in 2.6.13. This 
> categorically fails.

Currently this is the expected behavior if you "interrupt" the chkdsk 
procedure. If you schedule chkdsk then you must boot Windows twice, not 
only once. Otherwise you get the below error message

   NTFS error: ntfs_check_logfile(): Did not find any restart pages in
   $LogFile and it was not empty.

which means that the log was used by chkdsk which will be handled by the 
next Windows boot. At present the Linux NTFS code can't cope with this 
scenario so you must boot Windows again and then Linux. If you did so, then 
well, the above command could tell the reason.

BTW, this is not Vista only feature.

 	Szaka
