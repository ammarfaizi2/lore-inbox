Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318380AbSGYIuG>; Thu, 25 Jul 2002 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318382AbSGYIuG>; Thu, 25 Jul 2002 04:50:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:53694 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318380AbSGYIuF>;
	Thu, 25 Jul 2002 04:50:05 -0400
Date: Thu, 25 Jul 2002 10:52:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: martin@dalecki.de
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Samuel Thibault <samuel.thibault@fnac.net>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
Message-ID: <20020725105254.A21927@ucw.cz>
References: <Pine.LNX.4.44.0205260248160.17222-400000@youpi.residence.ens-lyon.fr> <Pine.LNX.4.10.10207250128110.4868-100000@bureau.famille.thibault.fr> <20020725093154.A21541@ucw.cz> <3D3FB5F6.3060000@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D3FB5F6.3060000@evision.ag>; from dalecki@evision.ag on Thu, Jul 25, 2002 at 10:25:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 10:25:26AM +0200, Marcin Dalecki wrote:
> Vojtech Pavlik wrote:
> > On Thu, Jul 25, 2002 at 01:45:00AM +0200, Samuel Thibault wrote:
> > 
> >>Hello,
> >>
> >>Here are patches for 2.4.19-pre3 & 2.5.28 which free them from using
> >>cli/sti in qd65xx stuff.
> > 
> > 
> > Cool.
> > 
> > 
> >>(also using ide's OUT_BYTE / IN_BYTE btw)
> > 
> > 
> > In my opinion this doesn't make sense. The qd65xx is a VESA Local Bus
> > only hardware and is very very unlikely to be used on anything else than
> > an x86, where these defines are needed. Also, the ports written to are
> > not a part of the IDE controller region, so the IN_BYTE/OUT_BYTE macros
> > might not work there if it was ever used on a non-x86 machine. Also, it
> > makes the code less readable.
> 
> Amen. BTW> I think proper fix is to simple *remove* the cli() cti()
> commands. They don't make much sense in first place.

Yes. Btw, it would be nice if the IDE core guaranteed that no two tuning
functions would be ever run at the same time. No performance hit, life a
lot easier.

-- 
Vojtech Pavlik
SuSE Labs
