Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVCHRZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVCHRZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 12:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVCHRZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 12:25:23 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:59274 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261421AbVCHRZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 12:25:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DEJeXmEx/KQfPwEFbY6Ds6VaCPNsn+QibfKj24rNFtoiqDPKUkSwOCePdUPYWdqCHAkozmNFpBqFeDGE6ezn0bPoLQiTZZ/8eLt4tLTf4TuWFb2dvy11UEbLOs7LMoSi6WaPCNRweyzCJeaZ7RBd591nQpXNbDgRH75IK7nON50=
Message-ID: <d120d500050308092554b49728@mail.gmail.com>
Date: Tue, 8 Mar 2005 12:25:09 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Hans-Christian Egtvedt <hc@mivu.no>
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <1110297660.3198.15.camel@server.customer.mivu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
	 <200503041403.37137.adobriyan@mail.ru>
	 <d120d50005030406525896b6cb@mail.gmail.com>
	 <1109953224.3069.39.camel@charlie.itk.ntnu.no>
	 <d120d50005030408544462c9ea@mail.gmail.com>
	 <1110297660.3198.15.camel@server.customer.mivu.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Mar 2005 17:01:00 +0100, Hans-Christian Egtvedt <hc@mivu.no> wrote:
> On Fri, 2005-03-04 at 11:54 -0500, Dmitry Torokhov wrote:
> > On Fri, 04 Mar 2005 17:20:24 +0100, Hans-Christian Egtvedt <hc@mivu.no> wrote:
> > > On Fri, 2005-03-04 at 09:52 -0500, Dmitry Torokhov wrote:
> > > > On Fri, 4 Mar 2005 14:03:37 +0200, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> > > > > On Friday 04 March 2005 12:30, Hans-Christian Egtvedt wrote:
> > > > As far as the driver goes:
> > > >
> > > > - yes, it does need input_sync;
> > >
> > > One problem with input_sync is that the panel get's too fast, and double
> > > click is experienced quite often, maybe some threshold is needed for low
> > > values in Z-direction?
> > >
> > > I'm probably doing something wrong here since I experience easy
> > > doubleclicks when I just lightly touch the screen.
> >
> > Yes, I think you need to use some threshold when reporting BTN_TOUCH
> > event. Still, always report ABS_PRESSURE as is. This way the
> > touchscreen is useable via legacy interfaces (mousedev. tsdev) and if
> > a specialized userspace driver is written it still can get pretty much
> > unmangled data from /dev/input/eventX. This will also allow such
> > driver adjust touchpad sensitivity, if needed.
> 
> Do you have any pointers to where I should go to implement this
> threshold? Is there an easy or smart way doing it?
>

I am not sure... that BTN_TOUCH - look slike it works off a single
flag reported by hardware. You porobably do not need to change it.

Try loading mousedev module (after adding input_sync back to your
driver) - it provides cooked PS/2 protocol to userspace - it should
bind to your driver. Then you can use GPM or X (read from
/dev/input/mice) to test the touchscreen and see if you have issue
with double clicks.

-- 
Dmitry
