Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbUBNWGz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 17:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263787AbUBNWGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 17:06:55 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:165 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263760AbUBNWGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 17:06:51 -0500
Date: Sat, 14 Feb 2004 17:06:47 -0500
From: Willem Riede <wrlk@riede.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Selective attach for ide-scsi
Message-ID: <20040214220647.GE4957@serve.riede.org>
Reply-To: wrlk@riede.org
References: <20040208224248.GA28026@serve.riede.org> <16423.17315.777835.128816@alkaid.it.uu.se> <20040210000205.GG28026@serve.riede.org> <20040211121120.A24289@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040211121120.A24289@beaverton.ibm.com> (from patmans@us.ibm.com on Wed, Feb 11, 2004 at 15:11:20 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.11 15:11, Patrick Mansfield wrote:
> On Mon, Feb 09, 2004 at 07:02:05PM -0500, Willem Riede wrote:
> > On 2004.02.09 03:24, Mikael Pettersson wrote:
> > > Willem Riede writes:
> 
> > > The patch I posted, which you apparently didn't like, doesn't
> > > require the use of boot-only options: it instead adds a module_param
> > > to ide-scsi which allows for greater flexibility.
> > > 
> > > Personally I never liked that butt-ugly hdX=ide-scsi hack.
> > 
> > I hear you. There are certainly advantages to use a module parameter rather
> > than a boot argument.
> 
> But module_param allows module arguments when built as a module, and boot
> arguments when built into the kernel.
> 
> > However, there should not be two mechanisms to achieve the same goal. For
> > better or for worse, the hdX=<driver> construction exists, and people are
> > using it. Its use is not limited to ide-scsi.
> 
> So does module_param not work because the usage is across modules? That
> seems odd.

I wasn't making myself clear, it seems.

The hdX= construct applies to the entire ide subsystem, which for the vast
majority of people means it has to be specified at boot time, as ide is
compiled in.

If we were to have an ide-scsi module option to tell it which hdX units to
attach to, that would be more flexible than having to tell ide, since I can
then rmmod/insmod ide-scsi if I want to change my mind, whereas I must reboot
if I need to change what I tell ide.

The advantage of the hdX ide parameter is that it applies to the entire ide 
subsystem, and therefor influences ide-cd, ide-scsi, ide-tape.

The main reason I see for sticking with the hdX= construct is that I think
that introducing competing mechanisms that achieve much the same objective
is a bad thing.

Regards, Willem Riede.
