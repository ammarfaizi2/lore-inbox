Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286305AbRLTRkz>; Thu, 20 Dec 2001 12:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286301AbRLTRkp>; Thu, 20 Dec 2001 12:40:45 -0500
Received: from holomorphy.com ([216.36.33.161]:38538 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S286305AbRLTRkd>;
	Thu, 20 Dec 2001 12:40:33 -0500
Date: Thu, 20 Dec 2001 09:40:25 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Poor performance during disk writes
Message-ID: <20011220094025.B2632@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011220132729Z286241-18285+3296@vger.kernel.org>; from Dieter.Nuetzel@hamburg.de on Thu, Dec 20, 2001 at 02:27:17PM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2001 at 02:27:17PM +0100, Dieter N?tzel wrote:
> Amen..
> Sorry, Helge sure you are right in theory but try dbench 32 (maybe 
> bonnie/bonnie++) and playing an MP3/Ogg-Vorbis in parallel...
> That's my first test on any "new" kernel version.
> 
> Even with an 1 GHz Athlon II, 640 MB, U160 DDYS 18 GB, 10k IBM disk (on an 
> AHA-2940UW) it stutters like mad. I am running all my kernel _with_ Robert 
> Love's preempt + lock-break patches and it doesn't solve the problem.
> CPU load is (very) low but it do not work like it should.

I tried this on my 600MHz Athlon with 768MB of RAM and U160 DDYS 36GB
10Krpm IBM disk on a Adaptect 39160 I managed to get it not to stutter
at all. I was also using preempt + lockbreak and a few others. The
crucial patch appeared to be from Andrew Morton and it involved tuning
the elevator to avoid read starvation. A significantly helpful hardware
suggestion regarding the sound card and drivers came from Linus himself,
though.

Linus and others pointed out that applications are able to cause some
drivers to generate a large number of interrupts by using small buffers
and unfriendly ioctl's, especially esd. My workaround was to change out
sound hardware and disable esd. If this is happening to you, /proc/profile
should show handle_IRQ_event() and schedule() very high up. On the other
hand, this shows up as a steady drain on system resources and excessive
system time, not stuttering or skipping.

Andrew, I don't have the URL for that still floating around. Can you
point Dieter to it?

Cheers,
Bill
