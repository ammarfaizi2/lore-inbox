Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274919AbRIXTsC>; Mon, 24 Sep 2001 15:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274920AbRIXTrx>; Mon, 24 Sep 2001 15:47:53 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:35332 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S274919AbRIXTrj>;
	Mon, 24 Sep 2001 15:47:39 -0400
From: tpepper@vato.org
Date: Mon, 24 Sep 2001 12:48:04 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
Message-ID: <20010924124804.A30538@cb.vato.org>
In-Reply-To: <1001331342.4610.49.camel@plars.austin.ibm.com> <Pine.LNX.4.21.0109241212140.1593-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0109241212140.1593-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Mon, Sep 24, 2001 at 12:12:53PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to confirm I'm seeing this also.  I've a machine with 512mb ram and a
gig of swap.  Running a filesystem i/o stress test app causes the machine
to pretty much run out of memory.  The swap is hardly touched.  Then the
VM starts killing things...klogd, the file i/o app, the shell it was in...

I didn't see any significant change here with the patch.

Here's meminfo prior to and towards the end of things for what it's worth:

[root@foobox /root]# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
				Mem:  526299136 66060288 460238848        0   864256 21032960
				Swap: 1074765824  4374528 1070391296
				MemTotal:       513964 kB
				MemFree:        449452 kB
				MemShared:           0 kB
				Buffers:           844 kB
				Cached:          16268 kB
				SwapCached:       4272 kB
				Active:           5804 kB
				Inactive:        15580 kB
				HighTotal:           0 kB
				HighFree:            0 kB
				LowTotal:       513964 kB
				LowFree:        449452 kB
				SwapTotal:     1049576 kB
				SwapFree:      1045304 kB

[root@foobox /root]# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
				Mem:  526299136 522604544  3694592        0  1212416 435134464
				Swap: 1074765824  3366912 1071398912
				MemTotal:       513964 kB
				MemFree:          3608 kB
				MemShared:           0 kB
				Buffers:          1184 kB
				Cached:         424784 kB
				SwapCached:        152 kB
				Active:         356640 kB
				Inactive:        69480 kB
				HighTotal:           0 kB
				HighFree:            0 kB
				LowTotal:       513964 kB
				LowFree:          3608 kB
				SwapTotal:     1049576 kB
				SwapFree:      1046288 kB
