Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVCYOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVCYOwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVCYOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:52:31 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:9939 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261654AbVCYOw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:52:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Es3jZ+xAWMWmYsApJqDDmXNNKMGHYwCGAgyBI0lumz6gk49yy0dRKdVUrmAZpQ3q/AZHrPOB9N3cdugYY/Xg68KP3SxCyczr1CHnY6lEhxpBsjfp64okwmW+8JEvICP36GJnULMdMTkqaCmw6D+nOpPdL09dOkChJFz/l2M+Cx4=
Message-ID: <d120d50005032506526f6b9304@mail.gmail.com>
Date: Fri, 25 Mar 2005 09:52:27 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>, Andy Isaacson <adi@hexapodia.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <20050325142414.GF23602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
	 <20050324235439.GA27902@hexapodia.org> <4243D854.2010506@suse.de>
	 <20050325101344.GA1297@elf.ucw.cz>
	 <d120d500050325061963fb13db@mail.gmail.com>
	 <20050325142414.GF23602@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 15:24:15 +0100, Pavel Machek <pavel@suse.cz> wrote:
> Hi!
> 
> > > > > OK, anything else I should try?
> > > >
> > > > not really, i just wait for Vojtech and Pavel :-)
> > >
> > > Try commenting out "call_usermodehelper". If that helps, Stefan's
> > > theory is confirmed, and this waits for Vojtech to fix it.
> > >
> >
> > This is more of a general swsusp problem I believe - the second phase
> > when it blindly resumes entire system. Resume of a device can fail
> > (any reason whatsoever) and it will attempt to clean up after itself,
> > but userspace is dead and hotplug never completes. While I am
> > interested to know why ALPS does not want to resume on ANdy's laptop
> > the issue will never be completely resolved from within the input
> > system.
> 
> When device fails to resume, what should I do? I think I could
> 
>        if (error)
>                panic("Device resume failed\n");
> 
> , but... that does not look like what you want.

Oh, always panic-happy Pavel ;). It really depends on what kind of
device has faled to resume. If the device is really needed for writing
image then panic is the only recourse, but if it some other device you
resuming just ignore it, who cares...

Btw, I dont think that doing selective resume (as opposed to selective
suspend and Nigel's partial device trees) would be so much
complicated. You'd always resume sysdevs and then, when iterating over
"normal" devices, just skip ones not in resume path. It can all be
contained in driver core I believe (sorry but no patch, for now at
least).

> 
> > Pavel, is it possible for swsusp to disable hotplug (probably just do
> > hotplug_path[0] = 0) before resuming in suspend phase?
> 
> It feels like a hack, but yes, I probably could do that. (Do you have
> patch to try?)
>

Not really, I won't be able to write any code anything till next week I think.

-- 
Dmitry
