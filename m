Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261511AbVC2VlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVC2VlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVC2VlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:41:21 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:15410 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261502AbVC2Vjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:39:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jnOl+I1G1R23KWEuRdWwWtSMSY27FkD7hUPmnlASxD7UVwH6iuGi7Vcwy8GQtvG8FCkg5aUJKFntrNHneNxw/o2ATLyv0rN7pEN0Cu7JvOjrZ8/mOOyNcZkjtva2DwIhXL86qcbJ7zUrAf1FpDiMw5wY4+9e8xbVj6fICEYEAzI=
Message-ID: <d120d500050329133838b0ebb6@mail.gmail.com>
Date: Tue, 29 Mar 2005 16:38:35 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Pavel Machek <pavel@suse.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4242CE43.1020806@suse.de> <20050324235439.GA27902@hexapodia.org>
	 <4243D854.2010506@suse.de> <d120d50005032908183b2f622e@mail.gmail.com>
	 <20050329181831.GB8125@elf.ucw.cz>
	 <d120d50005032911114fd2ea32@mail.gmail.com>
	 <20050329192339.GE8125@elf.ucw.cz>
	 <d120d50005032912051fee6e91@mail.gmail.com>
	 <20050329205225.GF8125@elf.ucw.cz>
	 <Pine.LNX.4.50.0503291321490.29474-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Mar 2005 13:23:35 -0800 (PST), Patrick Mochel
<mochel@digitalimplant.org> wrote:
> 
> On Tue, 29 Mar 2005, Pavel Machek wrote:
> 
> > I don't really want us to try execve during resume... Could we simply
> > artifically fail that execve with something if (in_suspend()) return
> > -EINVAL; [except that in_suspend() just is not there, but there were
> > some proposals to add it].
> >
> > Or just avoid calling hotplug at all in resume case? And then do
> > coldplug-like scan when userspace is ready...
> 
> I thought that cold-plugging only worked for devices, not all objects.
> 

It really depens on the script - nothing stops it from traversing
entire /sys tree and if an object it not exported in the tree I'd say
userspace should not care about such object anyway.

> Can we just queue up hotplug events? That way we wouldn't lose any across
> the transition, and could be used to send resume events to userspace for
> various devices that need help..
>

The point is that at this point any changes to the system state will
be discarded - we already did the image and about to write it. When we
resume for real all those events will be regenerated once again.
 
-- 
Dmitry
