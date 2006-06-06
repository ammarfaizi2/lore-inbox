Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWFFVAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWFFVAi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWFFVAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:00:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:42709 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751098AbWFFVAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:00:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TJWeY4iNhUKk4bHOwZpEB+xYXDevKwND4qv5glVmGr6LxZcvYG0KJKzpMDdnchbdXlP84NFv0x3ZqUFXVrz1Uxxh3TWxhMe9enzlBRw05swXg+c1r4W7aTjpL6AFBQZk59V2cW38Ygx1PgyHazpqOMPZU+0+DBzGh/8wOrj3AxE=
Message-ID: <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
Date: Tue, 6 Jun 2006 17:00:36 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <4485DB6C.704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44856223.9010606@gmail.com>
	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
	 <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
	 <4485DB6C.704@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/6/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> > Overall, this feature is a great help for developers working in the
> >> > framebuffer or console layer.  There is not need to continually
> >> reboot the
> >> > kernel for every small change. It is also useful for regular users
> >> who wants
> >> > to choose between a graphical console or a text console without
> >> having to
> >> > reboot.
> >>
> >> Instead of the sysfs attribute, what about creating a new escape
> >> sequence that you send to the console system to detach? Doing it that
> >> way would make more sense from a stacking order. It just seems
> >> backwards to me that you ask a lower layer to detach from the layer
> >> above it. The escape sequence would also work for any console
> >> implementation, not just fbcon.
> >>
> >> If console detached this way and there was nothing to fallback to
> >> (systems without VGAcon), it would know not to try and print anything
> >> until something reattaches to it.
> >
> > Another thought, controlling whether console is attached or not is an
> > attribute of console, not of fbcon.
>
> If the console attached fbcon, then I agree that console should decide
> when to detach fbcon.  But that's not what happens, it's fbcon that
> attaches itself.
>
> It's not that you're wrong, it's just how the current vt/console layer
> works.  If someone do decide to add this feature to the vt/console layer,
> then I'm more than willing to have fbcon support that as well.

This is just kind of twisted since console increments the fbcon ref
count. Is /dev/console a real device, it that where the sysfs
attribute should go?

How is the stack maintained of what was previously bound to console?
What if I unbind fbcon on a system that doesn't have VGAcon for a backup?

-- 
Jon Smirl
jonsmirl@gmail.com
