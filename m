Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUBNWsi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbUBNWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 17:48:38 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15780 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263513AbUBNWsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 17:48:36 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: wrlk@riede.org, Patrick Mansfield <patmans@us.ibm.com>
Subject: Re: [PATCH] Selective attach for ide-scsi
Date: Sat, 14 Feb 2004 23:54:41 +0100
User-Agent: KMail/1.5.3
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <20040208224248.GA28026@serve.riede.org> <20040211121120.A24289@beaverton.ibm.com> <20040214220647.GE4957@serve.riede.org>
In-Reply-To: <20040214220647.GE4957@serve.riede.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402142354.41169.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 of February 2004 23:06, Willem Riede wrote:
> On 2004.02.11 15:11, Patrick Mansfield wrote:
> > On Mon, Feb 09, 2004 at 07:02:05PM -0500, Willem Riede wrote:
> > > On 2004.02.09 03:24, Mikael Pettersson wrote:
> > > > Willem Riede writes:
> > > >
> > > > The patch I posted, which you apparently didn't like, doesn't
> > > > require the use of boot-only options: it instead adds a module_param
> > > > to ide-scsi which allows for greater flexibility.
> > > >
> > > > Personally I never liked that butt-ugly hdX=ide-scsi hack.
> > >
> > > I hear you. There are certainly advantages to use a module parameter
> > > rather than a boot argument.
> >
> > But module_param allows module arguments when built as a module, and boot
> > arguments when built into the kernel.
> >
> > > However, there should not be two mechanisms to achieve the same goal.
> > > For better or for worse, the hdX=<driver> construction exists, and
> > > people are using it. Its use is not limited to ide-scsi.
> >
> > So does module_param not work because the usage is across modules? That
> > seems odd.
>
> I wasn't making myself clear, it seems.
>
> The hdX= construct applies to the entire ide subsystem, which for the vast
> majority of people means it has to be specified at boot time, as ide is
> compiled in.
>
> If we were to have an ide-scsi module option to tell it which hdX units to
> attach to, that would be more flexible than having to tell ide, since I can
> then rmmod/insmod ide-scsi if I want to change my mind, whereas I must
> reboot if I need to change what I tell ide.
>
> The advantage of the hdX ide parameter is that it applies to the entire ide
> subsystem, and therefor influences ide-cd, ide-scsi, ide-tape.
>
> The main reason I see for sticking with the hdX= construct is that I think
> that introducing competing mechanisms that achieve much the same objective
> is a bad thing.

$ echo ide-scsi>/proc/ide/hdX/driver
or
$ echo "ide-scsi:1">/proc/ide/hdX/settings
or
use HDIO_SET_IDE_SCSI ioctl

and you can change driver from ide-{cd,floppy,tape} to ide-scsi in-fly.
You can also use it in reverse direction (ie. from ide-scsi to ide-cd).

What more crap do you need?  There is already one /proc setting too much.

Cheers,
--bart

