Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWHSSEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWHSSEe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 14:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbWHSSEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 14:04:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:40749 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751766AbWHSSEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 14:04:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dQIjWCZH2JL/H6aQPS92wQv1ULImzuCUoXxSecvEc7ElB4IQwwb66xo2xCv/cu935VQ09Dvd00qIZ4UUGnrm/UvnonZGNmFU3Eax0irEOlgqqTnyXfFNr9w8ZERb2xeDmowQTc/3YV4ygbDp1W8M+g+getRs6HIn8oW3LtaTlK0=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Subject: Re: mplayer + heavy io: why ionice doesn't help?
Date: Sat, 19 Aug 2006 20:04:10 +0200
User-Agent: KMail/1.8.2
Cc: mplayer-users@mplayerhq.hu, linux-kernel@vger.kernel.org
References: <200608181937.25295.vda.linux@googlemail.com> <44E6006C.2030406@tremplin-utc.net>
In-Reply-To: <44E6006C.2030406@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608192004.10326.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 20:01, Eric Piel wrote:
> 08/18/2006 07:37 PM, Denis Vlasenko wrote/a écrit:
> > Hi,
> > 
> > I noticed that mplayer's video playback starts to skip
> > if I do some serious copying or grepping on the disk
> > with movie being played from.
> > 
> > nice helps, but does not eliminate the problem.
> > I guessed that this is a problem with mplayer
> > failing to read next portion of input data in time,
> > so I used Jens's ionice.c from
> > Documentation/block/ioprio.txt
> > 
> > I am using it this:
> > 
> > ionice -c1 -n0 -p<mplayer pid>
> > 
> > but so far I don't see any effect from using it.
> > mplayer still skips.
> > 
> > Does anybody have an experience in this?
> Hello
> 
> IOnice only works with CFQ, have you checked that you are using the CFQ 
> IO scheduler?
> # cat /sys/block/hda/queue/scheduler   #put the name of YOUR harddisk
> 
> In case it's not the default IO scheduler, you can change it with:
> # echo cfq > /sys/block/hda/queue/scheduler

Thanks!

It helps. mplayer skips much less, but still some skipping is present.
I experimented with forcing entire file to be present in the
pagecache, and in this case mplayer almost never skips.

Looks like mplayer have very little tolerance for reads
randomly taking more time to read input stream.

However, I then looked into the mplayer's source
(I wondered why it doesn't do read buffering itself)...

The code is, um, less than pretty.
--
vda
