Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272829AbRIPVIh>; Sun, 16 Sep 2001 17:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272824AbRIPVI2>; Sun, 16 Sep 2001 17:08:28 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29686 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S272818AbRIPVIK>; Sun, 16 Sep 2001 17:08:10 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sun, 16 Sep 2001 15:08:06 -0600
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] multipath RAID personality, 2.4.10-pre9
Message-ID: <20010916150806.E1541@turbolinux.com>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109141144260.2577-300000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109141144260.2577-300000@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 14, 2001  12:01 +0200, Ingo Molnar wrote:
> the attached patches implement multipath IO for Linux in form of a sw-RAID
> personality. Multipath-IO is the ability of certain devices to address the
> same physical disk over multiple 'IO paths'.

> /*
>  * This routine returns the disk from which the requested read should
>  * be done. It bookkeeps the last read position for every disk
>  * in array and when new read requests come, the disk which last
>  * position is nearest to the request, is chosen.

I'm not sure I understand why this is here?  If we are talking about a
multipath situation, there IS only a single disk, so which path is chosen
is mostly irrelevant.  Also, it is my understanding that with some multipath
hardware, if you read from the "backup" path it will kill access to the
primary path (this can be used when more than one system access shared disk
for failover).  As a result, we should always read from the "primary" path
for each disk unless there is an error.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

