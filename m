Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWFMOBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWFMOBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 10:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWFMOBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 10:01:05 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:22532 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S1751130AbWFMOBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 10:01:04 -0400
Message-ID: <448EC51B.6040404@argo.co.il>
Date: Tue, 13 Jun 2006 17:00:59 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC]  Slimming down struct inode
References: <20060613143230.A867599@wobbly.melbourne.sgi.com>
In-Reply-To: <20060613143230.A867599@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2006 14:01:01.0840 (UTC) FILETIME=[CDD83900:01C68EF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
>
> Such a change would would indeed break XFS, in exactly the way you
> suggest Jan - the realtime subvolume does typically use a different
> blocksize from the data subvolume (the realtime extent size is used,
> and this can be set per-inode too), and there would now be no way to
> distinguish this preferred IO size difference.
>

It can be made into an inode operation:

    if (inode->i_ops->getblksize)
         return inode->i_ops->getblksize(inode);
    else
         return inode->i_sb->s_blksize;

Trading some efficiency for space.

-- 
error compiling committee.c: too many arguments to function

