Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290213AbSBKTR7>; Mon, 11 Feb 2002 14:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290211AbSBKTRt>; Mon, 11 Feb 2002 14:17:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:54022 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S290213AbSBKTRi>; Mon, 11 Feb 2002 14:17:38 -0500
Date: Mon, 11 Feb 2002 14:15:59 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz,
        andre@linuxdiskcert.org
Subject: Re: ide cleanup
In-Reply-To: <20020209193500.A18944@suse.cz>
Message-ID: <Pine.LNX.3.96.1020211140942.642C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Vojtech Pavlik wrote:

> On Sat, Feb 09, 2002 at 01:19:58PM -0500, Bill Davidsen wrote:
> > On Wed, 6 Feb 2002, Pavel Machek wrote:
> > 
> > > -#ifdef CONFIG_BLK_DEV_PDC4030
> > >  	if (IS_PDC4030_DRIVE) {
> > >  		extern ide_startstop_t promise_rw_disk(ide_drive_t *, struct request *, unsigned long);
> > >  		return promise_rw_disk(drive, rq, block);
> > >  	}
> > > -#endif /* CONFIG_BLK_DEV_PDC4030 */
> > 
> > Am I reading this totally wrong, or do you really think it's a good idea
> > to test for a drive even if the user didn't configure such hardware?
> 
> Well, since IS_PDC4030_DRIVE will always be 0 in that case, the test
> will be optimized out ...

That's currently true, but since there are other places in the kernel
which use the ifdef, it's unobvious to read because you have to know that
the drive type test macro definition has side effects, it depends on a
behaviour of gcc which may not always be true, and it saves nothing, just
moves the code from the preprocessor to the optimizer, I don't see
removing it in general. 

Just my opinion, code should be written to be EASILY read rather than as
if to be entered in an obfuscated C contest. This is not that bad, but the
test always being false is not obvious without a study of the entire use
of the macro, the ifdef is.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

