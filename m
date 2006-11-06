Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752787AbWKFMD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbWKFMD5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbWKFMD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:03:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:42933 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752787AbWKFMD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:03:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GLyyFm887gs/MFriC6IPqTZ4+vKXFr+t/6cihsBDuf8+Dkh+moAguSK/zNEbJci7mjZIeuV98WLOF90fv7sc+tlmTtEbMyvQyCAlWuNbnw+xoYVzuREWydaow1ludZo2eYCi5lPAxV2b5XIGdPwSbbQAb0YJnoR0VZBNeu69eiw=
Message-ID: <6278d2220611060403j2b63cb9cl1d0707e7cf3d7899@mail.gmail.com>
Date: Mon, 6 Nov 2006 12:03:54 +0000
From: "Daniel J Blueman" <daniel.blueman@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: Poor NFSv4 first impressions
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>, nfsv4@linux-nfs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Being a big user of NFS at home, and a big fan of NFSv4, it was high
> time that I converted my home network from NFSv3 to NFSv4.
>
> Unfortunately applications started breaking left and right.  vim
> noticeably malfunctioned, trying repeatedly to create a swapfile (sorta
> like a lockfile).  Mozilla Thunderbird would crash reproducibly whenever
> it tried anything remotely major with a mailbox, such as compressing
> folders (removing deleted messages).
[snip]

This has all the symptoms to an open EACCES NFSv4 bug in 2.6.18/19.
This is fixed in:

http://www.citi.umich.edu/projects/nfsv4/linux/kernel-patches/2.6.19-rc3-2/linux-2.6.19-rc3-CITI_NFS4_ALL-2.diff
(see http://www.citi.umich.edu/projects/nfsv4/linux/).

With this patch, I can run just great with NFSv4 home dir (etc)
mounts; without, I get the symptom of many 0-byte temporary/lock files
being created and often the inability to create files (!). Be sure to
allow callback delegation connections in through your firewall for the
extra performance ;-) .

Maybe it's too late for these fixes 2.6.19, but they should certainly
make 2.6.19.1 IMHO.
-- 
Daniel J Blueman
