Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284321AbRLRRWU>; Tue, 18 Dec 2001 12:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284314AbRLRRWP>; Tue, 18 Dec 2001 12:22:15 -0500
Received: from ns0.cobite.com ([208.222.80.10]:58373 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S284302AbRLRRWB>;
	Tue, 18 Dec 2001 12:22:01 -0500
Date: Tue, 18 Dec 2001 12:21:54 -0500 (EST)
From: David Mansfield <david@cobite.com>
X-X-Sender: <david@admin>
To: Linus Torvalds <torvalds@transmeta.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112181216341.1237-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 	audio_devs[devc->dev]->min_fragment = 5;
> 

Generally speaking, you want to be able to specify about a 1ms fragment,
speaking as a realtime audio programmer (no offense Victor...).  However,
1ms is 128 bytes at 16bit stereo, but only 32 bytes at 8bit mono.  Nobody
does 8bit mono, but that's probably why it's there.  A lot of drivers seem 
to have 128 byte as minimum fragment size.  Even the high end stuff like 
the RME hammerfall only go down to 64 byte fragment PER CHANNEL, which is 
the same as 128 bytes for stereo in the SB 16.

> Raising that min_fragment thing from 5 to 10 would make the minimum DMA
> buffer go from 32 bytes to 1kB, which is a _lot_ more reasonable (what,
> at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer empties
> in less than 1/100th of a second, but at least it should be < 200 irqs/sec
> rather than >400).

Note that the ALSA drivers allow the app to set watermarks for wakeup, 
while allowing flexibility in fragment size and number.  You can 
essentially say, wake me up when there are at least n fragments empty, and 
put me to sleep if m fragments are full.

David

-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

