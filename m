Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSIGOjO>; Sat, 7 Sep 2002 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318246AbSIGOjO>; Sat, 7 Sep 2002 10:39:14 -0400
Received: from science.horizon.com ([192.35.100.1]:7241 "HELO
	science.horizon.com") by vger.kernel.org with SMTP
	id <S316768AbSIGOjN>; Sat, 7 Sep 2002 10:39:13 -0400
Date: 7 Sep 2002 14:43:48 -0000
Message-ID: <20020907144348.28130.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Sep 2002, Linus Torvalds wrote:
> Note that the delay for motor on/off is _much_ larger than the actual 
> delay for seeking.
> 
> The seek itself is on the order of a few ms, with the head settle time 
> being in the tens (possibly even a few hundred) ms per track. So assuming 
> you end up reading 4 tracks or so due to readahead, that's still in the 
> range of about one second.
> 
> In contrast, the motor on/off time is something like 5 seconds if I
> remember correctly. Of course, you can certainly eject the floppy while
> the motor is still running, but I'd suggest against it.

You're forgetting the transfer rate.  A 1440K floppy has 160
tracks (80 cylinders * 2 heads), or 9K per track.

It spins at 300 RPM, so it takes at least 200 ms to read that track.
45K/sec.

A 64K read spans 7.11 tracks, which will take 1422 ms to read.
Add 100 ms for initial rotational latency, and assume that subsequent
tracks are optimally arranged for continuous reads.

That's 1.5 secods just to transfer the data.

*Then* you can add all of the seek and motor spin-up/down times
mentioned above.

(Of course, if the floppy *isn't* formatted optimally, add an
extra 100 ms per seek, or 700 ms total, of rotatinal latency.)
