Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSFQIgt>; Mon, 17 Jun 2002 04:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSFQIgs>; Mon, 17 Jun 2002 04:36:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2579 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316848AbSFQIgp>;
	Mon, 17 Jun 2002 04:36:45 -0400
Message-ID: <3D0DA090.9F1B60BE@zip.com.au>
Date: Mon, 17 Jun 2002 01:40:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
References: <20020615120511.GA30803@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> >> Recently, 2.5.20-dj[34] completed all my tests, whereas
> >> 2.5.{19,20,21} haven't.   I realize breakage in the development series
> >> is expected and sometimes good.  Nonetheless, "two thumbs up" for -dj.
> 
> > That's interesting. What exactly was failing ? It'd be in everyones
> > interests to get those bits pushed to Linus sooner.
> 
> tiobench.pl --size 2048 --numruns 3 --threads 128  # 384 MB ram in machine
> 
> The ssh session running vmstat no longer updates.  Console won't
> give a new "login" prompt with <Enter>.  <sysrq T> prints a
> trace (which I haven't captured - it's really long with > 128 processes).
> 
> Does <sysrq T> need any post processing to convert addresses to
> something more useful?  I'll save it on 2.5.22 if it happens.

Well I dunno, Randy.  Works fine here, on aic7xxx SCSI and hpt366 IDE.

>From your trace it would seem that writeout completion has not
occurred against one or more pages.  Could be that the device
driver lost an interrupt, or it failed to deliver completion
for one or more BIO segments, or something screwed up at the
VFS level.

I am (of course ;)) disinclined to believe the latter, mainly
because of the amount of testing I do here.  Eight-hour Cerberus
runs on quad CPU, five IDE disks and six SCSI disks all chugging
along, no probs.

Is it reproducible?   Are you able to try it on a different machine?
On other disks in the same machine? 

-
