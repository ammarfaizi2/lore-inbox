Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262557AbVBCHQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262557AbVBCHQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 02:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbVBCHQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 02:16:18 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:49049 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262677AbVBCHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 02:16:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Date: Thu, 3 Feb 2005 02:16:05 -0500
User-Agent: KMail/1.7.2
Cc: Pete Zaitcev <zaitcev@redhat.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <20050123190109.3d082021@localhost.localdomain> <d120d50005020214066c1249a2@mail.gmail.com> <Pine.LNX.4.58.0502022309150.18389@telia.com>
In-Reply-To: <Pine.LNX.4.58.0502022309150.18389@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502030216.06179.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 February 2005 17:27, Peter Osterlund wrote:
> On Wed, 2 Feb 2005, Dmitry Torokhov wrote:
> 
> > On Wed, 02 Feb 2005 13:52:03 -0800 (PST), Peter Osterlund
> > <petero2@telia.com> wrote:
> > >
> > >        if (mousedev->touch) {
> > > +               size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
> > > +               if (size == 0) size = xres;
> >
> > Sorry, missed this piece first time around. Since we don't want to
> > rely on screen size anymore I think we should set size = 256 *
> > FRACTION_DENOM / 2 if device limits are not set up to just report raw
> > coords. What do you think?
> 
> I think that this case can't happen until we add support for some other
> touchpad that doesn't set the absmin/absmax variables. Both alps and
> synaptics currently set them.
> 
> However, the fallback value should definitely not depend on
> FRACTION_DENOM, since this constant doesn't affect the mouse speed at all.

Oh, yes, we divide by FRACTION_DENOM later. So having size = 256 * 2
should undo all scaling and report coordinates one for one which I think
is a reasonable solution if device did not set it's size.

-- 
Dmitry
