Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSHBSLc>; Fri, 2 Aug 2002 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSHBSLc>; Fri, 2 Aug 2002 14:11:32 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.5.5]:12979 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S316545AbSHBSLb>; Fri, 2 Aug 2002 14:11:31 -0400
Date: Fri, 02 Aug 2002 10:45:29 -0400
From: Nick Orlov <nick.orlov@mail.ru>
Subject: Re: [PATCH] pdc20265 problem.
In-reply-to: <Pine.SOL.4.30.0208021557410.3612-100000@mion.elka.pw.edu.pl>
To: lkml <linux-kernel@vger.kernel.org>
Mail-followup-to: lkml <linux-kernel@vger.kernel.org>
Message-id: <20020802144529.GA5336@nikolas.hn.org>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20020802125204.GA4729@nikolas.hn.org>
 <Pine.SOL.4.30.0208021557410.3612-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2002 at 04:00:32PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> On Fri, 2 Aug 2002, Nick Orlov wrote:
> 
> > On Fri, Aug 02, 2002 at 01:27:25PM +0100, Alan Cox wrote:
> > > On Fri, 2002-08-02 at 02:47, Nick Orlov wrote:
> > > >
> > > > > <marcelo@plucky.distro.conectiva> (02/07/19 1.646)
> > > > > 	Fix wrong #ifdef in ide-pci.c: Was causing problems with FastTrak
> > > >
> > > > Because of this fix my Promise 20265 became ide0 instead of ide2.
> > > > Is there any reason to mark pdc20265 as ON_BOARD controller?
> > >
> > > How about because it can be and it should be checked. I don't know what
> > > is going on with the ifdef in your case to cause this but its not as
> > > simple as it seems
> >
> > Why pdc20265 is so special ? All other Promises marked as OFF_BOARD...
> >
> > And what determines how id will be assigned to controllers if both of
> > them are ON_BOARD ?
> 
> AFAIR problem is that some vendors included onboard 20265 as primary
> device (playing tricks for that) and to be consistent we have to treat it as
> onboard, we have right now no way to check if it is on or offboard.
> EDD support will probably help here.
> 

Just FYI,

before these "#ifdef" fixes it was treated as OFF_BOARD unless
CONFIG_PDC202XX_FORCE is set. (now it's inverted)

And my point is that it does not matter how physically this controller
installed - onboard or offboard. Idea is that we should have control
which controller should be treated as "primary" (ide0/1) and which as
"secondary" (ide2/3). I don't see/know how we can do it unless we mark
one of controllers ON_BOARD and another OFF_BOARD and play with
CONFIG_BLK_DEV_OFFBOARD.

And also I don't believe that this is good idea to treat one of Promises so
differently.

-- 
With best wishes,
	Nick Orlov.

