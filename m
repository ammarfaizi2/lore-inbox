Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbTCTAxL>; Wed, 19 Mar 2003 19:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbTCTAxL>; Wed, 19 Mar 2003 19:53:11 -0500
Received: from holomorphy.com ([66.224.33.161]:53637 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261281AbTCTAxJ>;
	Wed, 19 Mar 2003 19:53:09 -0500
Date: Wed, 19 Mar 2003 17:03:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, philippe.gramoulle@mmania.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hard freeze with 2.5.65-mm1
Message-ID: <20030320010319.GB1240@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	philippe.gramoulle@mmania.com, linux-kernel@vger.kernel.org
References: <20030319104927.77b9ccf9.philippe.gramoulle@mmania.com> <8765qfacaz.fsf@lapper.ihatent.com> <20030319182442.4a9fa86c.philippe.gramoulle@mmania.com> <877kav5ikv.fsf@lapper.ihatent.com> <20030319121909.74f957af.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319121909.74f957af.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>> I've had I/O stall a few times while watching movies, but only the
>> mplayer process hung, and I could break it off and restart and it
>> woudl fun again for a few minutes.

On Wed, Mar 19, 2003 at 12:19:09PM -0800, Andrew Morton wrote:
> This is a bug in the new nanosleep code.  mplayer asks the kernel for a 50
> millisecond sleep and the kernel gives it a two month sleep instead.
> Please set INITIAL_JIFFIES to zero and retest.
> With what compiler are you building your kernels?

Just hit it with xmms:

$ less /proc/1284/wchan
sys_rt_sigsuspend
$ less /proc/1285/wchan
schedule_timeout
$ less /proc/1286/wchan
schedule_timeout
$ less /proc/16656/wchan
do_clock_nanosleep
$ less /proc/16657/wchan
do_clock_nanosleep

kill -STOP `pidof xmms` ; kill -CONT `pidof xmms` gets it unstuck so
it's not lethal, but still...


-- wli
