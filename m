Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313677AbSDHPpZ>; Mon, 8 Apr 2002 11:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313679AbSDHPpY>; Mon, 8 Apr 2002 11:45:24 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:3310 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313677AbSDHPpX>; Mon, 8 Apr 2002 11:45:23 -0400
Date: Mon, 8 Apr 2002 18:47:33 +0300
From: Anssi Saari <as@sci.fi>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020408154732.GA10271@sci.fi>
In-Reply-To: <20020408122603.GA7877@sci.fi> <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 10:54:29AM -0400, Bill Davidsen wrote:
> On Mon, 8 Apr 2002, Anssi Saari wrote:
> 
> > [1.] One line summary of the problem:    
> > CD burning at 16x uses excessive CPU, although DMA is enabled
> 
>   That's a hint things are not working as you expect...
>  
> > [2.] Full description of the problem/report:
> > My system seems to use a lot of CPU time when writing CDs at 16x. The
> > system is unable to feed the burning software's buffer fast enough when
> > burning software (cdrecord 1.11a20, cdrdao 1.1.5) is run as normal user.
> > If run as root, system is almost unresponsive during the burn.
> 
>   With all the information you provided, you have totally not quatified
> how much CPU you find "excessive."

I didn't really know how to put it. Maybe system load would be better. But
the actual problem is, I effectively can't burn audio and other types
at 16x in Linux, while there is no problem in some other operating systems
with the same hardware and applications.

Here're some time figures from cdrdao:

cdrdao simulate -n --speed 8 foo.cue  2.62s user 3.37s system 1% cpu 6:41.86 total
cdrdao simulate -n --speed 12 foo.cue  2.78s user 29.91s system 12% cpu 4:31.71 total
cdrdao simulate -n --speed 16 foo.cue  2.67s user 128.77s system 52% cpu 4:10.68 total

So yes, system time goes up quite steeply.

But even though 50% is quite high, CPU load is not the problem as such,
the problem is getting data to the writer fast enough. And it's not
happening. Even a single audio track that is completely cached so that
there is no HD access has problems. It's like somehow accessing the CD
writer hogs the system for such long periods that there is insufficient
time to fill the writing program's buffer.

One thing I noticed just now. If I turn off unmaskirq for the CD writer
with hdparm -u 0 /dev/hdc, it helps a little, but not enough. Time
reports now:

cdrdao simulate -n --speed 16 foo.cue  2.75s user 75.18s system 58% cpu
2:13.22 total
