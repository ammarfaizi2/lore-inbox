Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWCWOCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWCWOCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 09:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWCWOCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 09:02:09 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:62924 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932130AbWCWOCI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 09:02:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lPuhXi9N/xfvyVvwL4MOpqQBhFg9TmSxioJHnXUsVRJc4YbKFQiqUiLHXx2csnWbdNJcwz3VAuVuZHaHz8AoYpTzvsrFWJYQ5JYotb3gyW1/1eis/yEOFcGvKaonD1bzMJdV6TZpEgzVy0dzM6vB01Gurs88O+S7cVtgG0Kha3Q=
Message-ID: <5a4c581d0603230602s1a868a4apbfd79ec2bc568011@mail.gmail.com>
Date: Thu, 23 Mar 2006 15:02:05 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [2.6.16-gitX] heavy performance regression in ipw2200 wireless driver
Cc: linux-kernel@vger.kernel.org, "Zhu, Yi" <yi.zhu@intel.com>,
       "James Ketrenos" <jketreno@linux.intel.com>, netdev@vger.kernel.org
In-Reply-To: <20060322191057.304962a4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0603221724m391f5466l8a2af3ae7f0aacae@mail.gmail.com>
	 <20060322191057.304962a4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Andrew Morton <akpm@osdl.org> wrote:
> "Alessandro Suardi" <alessandro.suardi@gmail.com> wrote:
> >
>
> Pleeeeze try to cc the right people.

Sorry about that - should probably defer bug reporting to times
 when I'm actually supposed to be awake (2:20am doesn't fit
 the bill obviously :| )

> > Driver - or firmware ? Don't know - since the new git snapshots run
> >  1.1.1 which requires newer firmware from http://ipw2200.sourceforge.net.
> >
> > Symptom -> my new FC5 partition with 2.6.16-git kernels connects via
> >  VNC viewer to my bittorrent box over wireless (ipw2200 to a D-Link
> >  G604T router/AP); Dell D610 runs FC5, BT box is a K7-800 running
> >  FC3 with a 2.6.16-rc5-git8 kernel (15+ days uptime...).
> >
> > I also run Firefox on the bittorrent box; noticed today (2.6.16-git5) that
> >  the screen refresh of pages with images was from time to time very
> >  slow (close to unusable).
> >
> > Rebooted into my FC4 partition with a 2.6.16 kernel, everything much
> >  snappier. So I ran a scp test from my BT server to the laptop, three
> >  times in a row the same file - a 38MB .flac with the laptop in the same
> >  physical position (ie, no signal variation). Results...
> >
> > FC5 - 2.6.16-git3:
> >
> > [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> > Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> > asuardi@192.168.1.8's password:
> > KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB 971.3KB/s   00:40
> > [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> > Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> > asuardi@192.168.1.8's password:
> > KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.3MB/s   00:29
> > [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> > Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> > asuardi@192.168.1.8's password:
> > KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB 626.7KB/s   01:02
> >
> >
> > FC4 - 2.6.16:
> >
> > [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> > Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> > asuardi@192.168.1.8's password:
> > KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.5MB/s   00:25
> > [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> > Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> > asuardi@192.168.1.8's password:
> > KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.7MB/s   00:23
> > [asuardi@donkey melua_2004-09-23_Berlin]$ scp KM_9-23-04_17_The\
> > Closest\ Thing\ to\ Crazy.flac 192.168.1.8:/tmp
> > asuardi@192.168.1.8's password:
> > KM_9-23-04_17_The Closest Thing to Crazy.flac 100%   38MB   1.7MB/s   00:22
> >
> > Bottom line - old driver has better performance than the new one,
> >  but most noticeably delivers consistent performance.
> >
> > I will be available for testing starting Thursday 30th as I'll be on
> >  the road since then. Of course if the problem is identified and
> >  fixed earlier, I won't cry ;)
>
> Well.  It's not a huge regression.  It's a 50%ish regression.  We've done
> worse ;)

That scp test shows 50%ish - but that was a quickie. The VNC
 client even reported a 719Kbps throughput down from the more
 usual 11500Kbps it starts off with. The first scp I tried when the
 sluggishness was intolerable was going at 200KB/s - which
 shows the problem can easily get in the neighborhood of an
 order of magnitude.

Thanks,

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
