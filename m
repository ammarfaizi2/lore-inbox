Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWE3U4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWE3U4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWE3U4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:56:05 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:33117 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932413AbWE3U4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:56:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oini9GuGmZ83wset+laCyhR5DuzxVmgPpxUOq8iKrAGS/77qHHy721rgBvpDc9gLnIWQhtjsltIpcsrhtviDmsvzIlZm7beGo9Xia4Re6lL6hbtViyYQklXLptBy+pm7GF9eUWJ7dlWoWcHV/EX7meBt3nIjEQQ0BuE19Ddr4wQ=
Message-ID: <9e4733910605301356k64dcd75fo38e45e1b7572817f@mail.gmail.com>
Date: Tue, 30 May 2006 16:56:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Dave Airlie" <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060530202401.GC16106@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
	 <20060529102339.GA746@elf.ucw.cz>
	 <21d7e9970605290336m1f80b08nebbd2a995be959cb@mail.gmail.com>
	 <20060529124840.GD746@elf.ucw.cz>
	 <21d7e9970605291623k3636f7hcc12028cad5e962b@mail.gmail.com>
	 <20060530202401.GC16106@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > >No, to the contrary. suspend/resume can't ever work properly with
> > >vgacon and vesafb. It works okay with radeonfb tooday, and in fact
> > >radeonfb is neccessary today for saving power over S3.
> >
> > But the things is today for many users suspend/resume to RAM works for
> > people running X drivers, I know on my laptop that my radeon
> > suspends/resumes fine when running vgacon/DRM/accelerated X, it
> > doesn't suspend/resume at all well when running vgacon on its own of
> > course. or with radeonfb for that matter. so I still believe the
> > suspend/resume code for a card can live in userspace if necessary but
> > it just shouldn't be part of X... it needs to be part of another
> > graphics controller process.
>
> So we are mostly in agreement. I'd prefer to have suspend/resume code
> in kernel in cases it is simple... but separate userspace process is
> better than having it in X.

Don't draw any conclusions from saying that suspend/resume works in X
and doesn't work on xx_fb. What matters is that a set of code that can
perform suspend/resumes exists at all. Once a coherent driver model is
designed the relevant code can be moved to the correct place.

Another reason for moving things like this out of X is to allow the
implementation of alternative graphics systems. It makes no sense that
every new graphics system has to develop their own video and keyboard
drivers. ALSA is a good model for this, it is shared by everyone.
Imagine what things would be like if X built in drivers for every
sound card,.

-- 
Jon Smirl
jonsmirl@gmail.com
