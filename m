Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269812AbTGOWND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 18:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269814AbTGOWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 18:13:01 -0400
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:32780 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S269812AbTGOWM3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 18:12:29 -0400
Date: Tue, 15 Jul 2003 17:27:19 -0500 (CDT)
From: derek@signalmarketing.com
X-X-Sender: manmower@uberdeity.signalmarketing.com
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: IDE performance problems on 2.6.0-pre1
In-Reply-To: <1058306624.584.5.camel@teapot.felipe-alfaro.com>
Message-ID: <Pine.LNX.4.56.0307151705190.2911@uberdeity.signalmarketing.com>
References: <Pine.LNX.4.56.0307151617430.2932@uberdeity.signalmarketing.com>
 <1058306624.584.5.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Jul 2003, Felipe Alfaro Solana wrote:

> On Tue, 2003-07-15 at 23:49, derek@signalmarketing.com wrote:
> > Hello,
> > 
> > My ide performance seems to have dropped noticably from 2.4.x to 
> > 2.6.0-pre1...
> 
> What does "hdparm /dev/hde" tell us?

hdparm /dev/hde  from 2.6.0-pre1

/dev/hde:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 50765/16/63, sectors = 117231408, start = 0

---

hdparm /dev/hde from 2.4

/dev/hde:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 116301/16/63, sectors = 117231408, start = 0


I hadn't noticed the change in readahead previously, so I tried setting it 
to 8 in 2.6.0-pre1 with hdparm -a 8 /dev/hde

hdparm -t /dev/hde

/dev/hde:
 Timing buffered disk reads:   32 MB in  3.01 seconds =  10.64 MB/sec

hdparm -a 512 on the other hand...

 Timing buffered disk reads:  140 MB in  3.03 seconds =  46.18 MB/sec

and I get my previous numbers back.

I guess the meaning of the parameter has changed dramatically?  (what was 
once sectors is now bytes?)
