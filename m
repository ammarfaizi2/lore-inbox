Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279976AbRKDIJO>; Sun, 4 Nov 2001 03:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279977AbRKDIJE>; Sun, 4 Nov 2001 03:09:04 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:20149 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S279976AbRKDIIt> convert rfc822-to-8bit; Sun, 4 Nov 2001 03:08:49 -0500
Date: Sun, 4 Nov 2001 06:23:47 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec vs Symbios performance 
In-Reply-To: <200111040547.fA45ldY64666@aslan.scsiguy.com>
Message-ID: <20011104060334.Y706-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Nov 2001, Justin T. Gibbs wrote:

[...]

> >I can see _both_ comparing aic with symbios.
>
> I'm not sure that you would see much of a difference if you set the
> symbios driver to use 253 commands per-device.  I haven't looked at

This is discouraged. :)
Better, IMO, to compare behaviours with realistic queue depths. As you
know, more than 64 for hard disks does not make sense (yet).
Personnaly, I use 64 under FreeBSD and 16 under Linux. Guess why ? :-)

> the sym driver for some time, but last I remember it does not use
> a bottom half handler and handles queue throttling internally.  It

There is no BH in the driver. The stock sym53c8xx even uses scsi_obsolete
that requires more load in interrupt context for command completion.
SYM-2 that comes back from FreeBSD uses the EH threaded stuff that just
queues to a BH on completion. Stephan may want to give SYM-2 a try, IMO.

> may perform less work at interrupt time than the aic7xxx driver if
> locally queued I/O is compiled into a format suitable for controller
> consumption rather than queue the ScsiCmnd structure provided by
> the mid-layer.  The aic7xxx driver has to convert a ScsiCmnd into a
> controller data structure to service an internal queue and this can
> take a bit of time.

The sym* drivers also uses an internal data structure to handle I/Os. The
SCSI script does not know about any O/S specific data structure.

> I would be interresting if there is a disparity in the TPS numbers
> and tag depths in your comparisons.  Higher tag depth usually means
> higher TPS which may also mean less interactive response from the
> system.  All things being equal, I would expect the sym and aic7xxx
> drivers to perform about the same.

Agreed.

  Gérard.

