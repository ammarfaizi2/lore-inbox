Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVBBWgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVBBWgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVBBWcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 17:32:31 -0500
Received: from av3-1-sn4.m-sp.skanova.net ([81.228.10.114]:3813 "EHLO
	av3-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262591AbVBBW1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 17:27:38 -0500
Date: Wed, 2 Feb 2005 23:27:28 +0100 (CET)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: dtor_core@ameritech.net
Cc: Pete Zaitcev <zaitcev@redhat.com>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with 2.6.11-rc2
In-Reply-To: <d120d50005020214066c1249a2@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0502022309150.18389@telia.com>
References: <20050123190109.3d082021@localhost.localdomain>  <m3acqr895h.fsf@telia.com>
  <20050201234148.4d5eac55@localhost.localdomain>  <m3lla64r3w.fsf@telia.com>
 <d120d50005020213176eab546a@mail.gmail.com>  <m31xby3a81.fsf@telia.com>
 <d120d50005020214066c1249a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Dmitry Torokhov wrote:

> On Wed, 02 Feb 2005 13:52:03 -0800 (PST), Peter Osterlund
> <petero2@telia.com> wrote:
> >
> >        if (mousedev->touch) {
> > +               size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
> > +               if (size == 0) size = xres;
>
> Sorry, missed this piece first time around. Since we don't want to
> rely on screen size anymore I think we should set size = 256 *
> FRACTION_DENOM / 2 if device limits are not set up to just report raw
> coords. What do you think?

I think that this case can't happen until we add support for some other
touchpad that doesn't set the absmin/absmax variables. Both alps and
synaptics currently set them.

However, the fallback value should definitely not depend on
FRACTION_DENOM, since this constant doesn't affect the mouse speed at all.
It only affects how accurately we store the fractional part of dx and dy.
Ideally FRACTION_DENOM should be as large as possible without causing
arithmetic overflow. In practice, 128 seemed to be plenty enough.

So, the fallback value should be set to the estimated absmax-absmin value
for the hypothetical future touchpad driver that also hypothetically
doesn't set this value itself. I have no idea how to estimate this value
though, which is why I just used xres. ;)

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
