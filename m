Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268989AbUIMV53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268989AbUIMV53 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 17:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268992AbUIMV53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 17:57:29 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:39449 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268989AbUIMV5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 17:57:22 -0400
Message-ID: <a728f9f9040913145764a82a02@mail.gmail.com>
Date: Mon, 13 Sep 2004 17:57:13 -0400
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: David Bronaugh <dbronaugh@linuxboxen.org>
Subject: Re: radeon-pre-2
Cc: Jon Smirl <jonsmirl@gmail.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4146062B.8040603@linuxboxen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
	 <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>
	 <Pine.LNX.4.58.0409130803340.2378@ppc970.osdl.org>
	 <a728f9f9040913122160dd0134@mail.gmail.com>
	 <4146062B.8040603@linuxboxen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004 13:42:19 -0700, David Bronaugh
<dbronaugh@linuxboxen.org> wrote:
> Alex Deucher wrote:
> 
> >How would any of these plans handle power management and ACPI events?
> >I'd like to be able to suspect my laptop with the DRI enabled, or have
> >the DDX (or whatever) handle acpi lid and button events or put the
> >chip into various power modes.
> >
> >Alex
> >
> >
> Since I've been doing a little bit of ACPI hacking (and gained a bit of
> understanding of it), I think I should probably speak on this one.
> 
> With the current ACPI infrastructure, you don't have the DDX or whatever
> catching ACPI events -- acpid catches ACPI events, and does appropriate
> things via scripts. So lid and button events can do things, but -- X
> doesn't handle them. Scripts called by acpid do.
> 
> As to putting chips into various power modes -- wouldn't this be better
> off in kernel, not in X? My impression is that this wouldn't be a large
> amount of code. It could also abstract away some details of chip power
> management -- it could (potentially) not matter if it's done via ACPI or
> via a custom bit of code for a chip. And it could expose a file in sysfs
> to adjust power settings for the graphics chip. Then the system that
> exists for handling ACPI events can happily keep being how it is.
> 
> Yu, Luming has been doing a lot of work in the area of a generic ACPI
> "video features" driver -- such a driver could do such things as change
> which heads are enabled, set backlight power, and generally muck with
> graphics state. I suspect some possible nasty interaction could happen,
> since ACPI could affect graphics state in some pretty hairy ways. It
> might be a good idea to get in contact with him before the user emails
> show up...

It seems to be that this kind of necessitates some sort of kernel mode
driver to handle everything (albeit perhaps with lots of userspace
libs).  I can't see how a generic video acpi driver would play nice
with a userspace X, fbdev, and whever else my be using the hardware. 
It's not that I don't like the idea of letting everyone play I just
want to use my hardware to its fully functionality wihtout a million
kludges everywhere.  OTOH, maybe it'll all just work.  I'm not too
familiar with the ins and outs of ACPI and what's need on the chip
side vs. generic vs. machine specific.  Stuff like enabling outputs
and changine power states is chip specific though and it would need to
play nice.

Alex

> 
> David Bronaugh
> 
> ps: I kinda trimmed the CC: list on this
>
