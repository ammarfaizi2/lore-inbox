Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbSBMPTG>; Wed, 13 Feb 2002 10:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286521AbSBMPS5>; Wed, 13 Feb 2002 10:18:57 -0500
Received: from [195.157.147.30] ([195.157.147.30]:29194 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S286311AbSBMPSn>; Wed, 13 Feb 2002 10:18:43 -0500
Date: Wed, 13 Feb 2002 15:08:50 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Ken Brownfield <brownfld@irridia.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
        "Proescholdt, timo" <Timo.Proescholdt@brk-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: randomness - compaq smart array driver
Message-ID: <20020213150850.H26054@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Ken Brownfield <brownfld@irridia.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	"Proescholdt, timo" <Timo.Proescholdt@brk-muenchen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <410B51F29EA8D3118EE400508B44AE2B3C6FB3@RZ_NT_MAIL> <Pine.LNX.4.33.0202111754560.5685-100000@gans.physik3.uni-rostock.de> <20020213071445.A20717@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020213071445.A20717@asooo.flowerfire.com>; from brownfld@irridia.com on Wed, Feb 13, 2002 at 07:14:45AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 07:14:45AM -0600, Ken Brownfield wrote:
> Yes, I've been using the netdev patches for months.  Aside from the
> unrelated entropy exhaustion bug, his patches are stable (and optional)
> and help on diskless or low-I/O machines.  2.4 or 2.5 anyone? :)

Randomness from network packet timings can be gathered entirely in userspace by
using a packet socket.  I am busy writing an "additional entropy daemon" to
gather entropy from this and other sources[1], clean it up, test its fitness,
estimate its information content, and feed it into the random pool.  This job
is (IMO) better done in userspace because there we can run fitness tests on the
stream more easily because we have floating point etc.

I personally don't think that network packet timings should be added to the
entropy pool by the kernel because they could be controlled to a lesser or
greater extent by an attacker.  I'm hoping that the fitness tests in my
userspace thingy would detect this.

Sean

[1] Including clock jitter and soundcard noise (I got the idea
    from Schneier 1996).
