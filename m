Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315829AbSEEHhA>; Sun, 5 May 2002 03:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315830AbSEEHg7>; Sun, 5 May 2002 03:36:59 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:49404
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315829AbSEEHg7>; Sun, 5 May 2002 03:36:59 -0400
Date: Sun, 5 May 2002 00:36:56 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Neil Conway <nconway_kernel@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH, IDE corruption, 2.4.18
Message-ID: <20020505073656.GD2392@matchmail.com>
Mail-Followup-To: Neil Conway <nconway_kernel@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020505002212.GA2392@matchmail.com> <20020505015417.76681.qmail@web21510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2002 at 02:54:17AM +0100, Neil Conway wrote:
> Hi...
> 
>  --- Mike Fedyk <mfedyk@matchmail.com> wrote: > On Sat, May 04, 2002 at
> 01:15:20PM +0100, Neil Conway wrote:
> > > -	byte stat;
> > > +	byte stat,unit;
> > 
> > [snip]
> > 
> > >  #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
> > > -	byte unit = (drive->select.b.unit & 0x01);
> > > +	unit = (drive->select.b.unit & 0x01);
> > 
> > Why are you moving the init of "unit" out of that ifdef?
> 
> Basically to make it compile.  I'm only moving the declaration, and
> that's only because I need to abort the routine BEFORE the second line
> of the ifdef switches off DMA on that unit.  I did compile a version
> with the ifdef split into two bits but I decided that was a little
> messy. (It won't compile if my check goes in before the first line of
> the ifdef as originally written as it declares a variable and C won't
> let declarations follow plain code.)
>

Right.  Duh on my part, sorry.

> > Can you see if this problem is still in 2.5 also? 
> 
> I haven't got a 2.5.13 tree but I found 2.5.7 on a source browser
> online and verified that, back then at least, ide-features.c was still
> basically the same.  Of course, the routines in between
> ide_register_subdriver and ide_config_drive_speed might have been
> different.  If someone can look at the code-path between these two
> routines in 2.5.13 to see if there is any check on whether or not the
> hwgroup is busy (or simply whether or not DMA is in progress) that
> would clear it up.  I'll probably download 2.5.13 sometime soon anyway.
> 

Andre cleaims that the situation is worse on 2.5.13 or so.  I wouldn't hurt
to test-run the code though.
