Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVBSGx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVBSGx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVBSGx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:53:29 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:3504 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261641AbVBSGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:53:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: ncunningham@cyclades.com
Subject: Re: 2.6: drivers/input/power.c is never built
Date: Sat, 19 Feb 2005 01:53:11 -0500
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@suse.cz>, Vojtech Pavlik <vojtech@suse.cz>,
       Oliver Neukum <oliver@neukum.org>, Richard Purdie <rpurdie@rpsys.net>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Adrian Bunk <bunk@stusta.de>,
       Linux Input Devices <linux-input@atrey.karlin.mff.cuni.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <047401c515bb$437b5130$0f01a8c0@max> <200502182158.34910.dtor_core@ameritech.net> <1108794519.4098.24.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108794519.4098.24.camel@desktop.cunningham.myip.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502190153.12535.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

On Saturday 19 February 2005 01:28, Nigel Cunningham wrote:
> Hi.
> 
> On Sat, 2005-02-19 at 13:58, Dmitry Torokhov wrote: 
> > On Friday 18 February 2005 18:31, Pavel Machek wrote:
> > > I believe power and suspend keys should definitely go through
> > > input. I'm not that sure about battery... Lid is somewhere in
> > > between...
> > I think we need a generic way of delivering system status changes to
> > userspace. Something like acpid but bigger than that, something not
> > so heavily oriented on ACPI. I wonder if that kernel connector patch
> > should be looked at.
> 
> Absolutely. I've been thinking about this too, but haven't yet found the
> time to put it down on paper/email yet.
> 
> I think we need a very generic system by which changes in anything 
> remotely impacting on power management (kernelspace or userspace,
> including ACPI, UPS drivers, keyboard handlers, devices etc) can notify
> events to a userspace daemon. This daemon can act in accordance with
> user specified policies (changeable on the fly) to implement system
> level state changes (suspend to ram/disk, shutdown etc), run time power
> management

Yep.

> (shutdown a USB hub that just signalled the removal of its 
> last client), logging and so on.

This last example - I don't think the daemon should micro-manage, I think
USB bus should shutdown the hub automatically without involving userspace.

> In some cases, it might set policy but 
> not be actively informed of the details of the application of that
> policy (we don't feedback loops with a process leaving C3 to notify that
> it's entering C3!).
> 
> This implies, of course, not just a generic way of notifying changes,
> but a generic way of implementing policy.
> 
> Sound too ambitious, or am I thinking your thoughts after you?
> 

Well, at this moment I only care about delivering the data to userspace,
the rest (daemon, policies) is although interesting is out of scope for
me.

-- 
Dmitry
