Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVBBTvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVBBTvW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVBBTrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 14:47:19 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:28220 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262334AbVBBTjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:39:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ErUaSPWpCBkg5IO3s1PiKnCS2uofwrzh47EB7e6/KYmH4OwMN054vEtTClG49vEYBtUFkNDVgPLevTTUgzHAMmLR6pPBN7xkm5Oi0lYfXq4maVzqDNLw0srqyb/Vy8etVJOhb1H0LstRQWJdU4f1fNxZF3LpHTAAGNIuhcwtTVg=
Message-ID: <d120d500050202113954912c34@mail.gmail.com>
Date: Wed, 2 Feb 2005 14:39:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050202095851.27321bcf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050123190109.3d082021@localhost.localdomain>
	 <m3acqr895h.fsf@telia.com>
	 <20050201234148.4d5eac55@localhost.localdomain>
	 <20050202102033.GA2420@ucw.cz>
	 <20050202085628.49f809a0@localhost.localdomain>
	 <20050202170727.GA2731@ucw.cz>
	 <20050202095851.27321bcf@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 09:58:51 -0800, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Wed, 2 Feb 2005 18:07:27 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > On Wed, Feb 02, 2005 at 08:56:28AM -0800, Pete Zaitcev wrote:
> > > On Wed, 2 Feb 2005 11:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > >
> > > > Well, you removed the scaling to the touchpad resolution, which will
> > > > cause ALPS touchpad to be significantly slower than Synaptics touchpads.
> > > > Similarly, the screen size used to be taken into account, but probably
> > > > that was a mistake, since the value is usually left at default and
> > > > doesn't correspond to the real screen size.
> > >
> > > Exactly. And it works much better now.
> >
> > With a Synaptics I suppose? You wouldn't like it with an ALPS.
> 
> No, it's a Dualpoint, and so ALPS. But never mind that, I think I see
> your point.
> 
> However, while I see a possibility of serious regressions with the other
> variety, but isn't it striking that result is so radical? With all the
> arithmetics still in place I can move my finger all across the pad without
> causing any motions. We are not talking about ballistics or any fine tuning,
> simply the calculations are wrong.
> 

It works fine for my Synaptics with default resolution, I don't have
ALPS to try but I think Peter tried to make it behave similarly.
Still, I agree that relying on the screen coordinates is a bad idea.

> If Synaptics delivers much bigger deltas for small motions, it's up to the
> Synapics mode of alps.c to make them reasonable, if that. There's no need
> to penalize ALPS. But I seriously doubt that Synaptics can be so broken.

Why is that having 5x better resolution is considered broken? And how
synaptics should "make them reasonable"? Driver emits pretty much raw
coordinate values and it is up to the consumer to make sense of them.

> I wish Peter tested the removal of scaling with his Synaptics. If he
> (and Dmitry) insist on running a special code in X, that's fine.

Yes, because there are other things we can do in that special code. Do
you like default tochpad sensitivity? What if someone does not? Do you
like verical and horisontal scrolling? Circular scrolling?
multi-finger tappng (synaptics only)? Corner tapping? What about
rebooting every time you change an option?

>  But honestly, I expect that things will go well for them.

Well, your code will make my touchpad (Synaptics) go ballistic. It
really has resolution of about 4000 points across.

-- 
Dmitry
