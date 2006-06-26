Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWFZPQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWFZPQJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWFZPQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:16:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:3786 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932468AbWFZPQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:16:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bs2R0AqHeknauC178K5SBrgcT9pTfPJl0KLyt2wAZ0lAZ+GV1qeggEe/3K5/mH7FyZIMa7NIyZQ+awqAV0vnTXcUP11He4DiW9BUfl+U8/cw37tSt3NHB70efM3DixdLrmYaYXaUb05b42wFh+N9U+upZzPo6H+2Rwv5klQEiWU=
Message-ID: <d120d5000606260816g68def55btb52cbb1255f3d200@mail.gmail.com>
Date: Mon, 26 Jun 2006 11:16:04 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: [PATCH] atkbd: restore autorepeat rate after resume
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrew Morton" <akpm@osdl.org>,
       "Kernel development list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060626150139.GA24550@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0606261017340.9467-100000@iolanthe.rowland.org>
	 <d120d5000606260735v6e1762d7mc278f315c3a994fb@mail.gmail.com>
	 <20060626145332.GB24275@suse.cz>
	 <d120d5000606260758m2ee97482m517d432f88975d87@mail.gmail.com>
	 <20060626150139.GA24550@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Mon, Jun 26, 2006 at 10:58:46AM -0400, Dmitry Torokhov wrote:
> > On 6/26/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > >On Mon, Jun 26, 2006 at 10:35:44AM -0400, Dmitry Torokhov wrote:
> > >> On 6/26/06, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >> >From: Linus Torvalds <torvalds@osdl.org>
> > >> >
> > >> >This patch (as728) makes the AT keyboard driver store the current
> > >> >autorepeat rate so that it can be restored properly following a
> > >> >suspend/resume cycle.
> > >> >
> > >>
> > >> Alan,
> > >>
> > >> I think it should be a per-device, not global parameter. Anyway, I'll
> > >> adjust adn apply, thank you.
> > >
> > >You can't make it per-device when there is no device when the keyboard
> > >isn't plugged in. ;)
> >
> > It there is no keyboard then you could not change repeat rate before
> > suspending and we don't have anyhting to restore ;)
>
> What the patch is trying to achieve is that you have the keyboard, set
> the rate, unplug the keyboard, replug the keyboard, get the original
> setting.
>
> In the middle of the process, you have no device to attach the
> information to. That's why the patch uses a global variable.
>

The original complaint was that we don't keep repeat rate after
suspend/resume cycle. I think pulling the cord and then plugging it
back in is completely different scenario, but even then it will also
work because we do not destroy keyboard device when cord is pulled
(there is no notification that device is gone). So input_dev is still
there and we can use dev->rep[] to restore the former settings.

-- 
Dmitry
