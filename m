Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267910AbTBLWeq>; Wed, 12 Feb 2003 17:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267914AbTBLWeq>; Wed, 12 Feb 2003 17:34:46 -0500
Received: from host194.steeleye.com ([66.206.164.34]:43015 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267910AbTBLWeo>; Wed, 12 Feb 2003 17:34:44 -0500
Subject: Re: [PATCH] fix scsi/aha15*.c for 2.5.60
From: James Bottomley <James.Bottomley@steeleye.com>
To: rudmer@legolas.dynup.net
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>,
       Mike Anderson <andmike@us.ibm.com>, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Tommy.Thorn@irisa.fr
In-Reply-To: <200302122246.19225@gandalf>
References: <3E49DC38.52D278C4@verizon.net>  <200302122246.19225@gandalf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Feb 2003 17:44:24 -0500
Message-Id: <1045089866.1763.3.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 17:41, Rudmer van Dijk wrote:
> On Wednesday 12 February 2003 06:31, Randy.Dunlap wrote:
> > Hi,
> > 
> > Here are patches to aha152x.c and aha1542.c so that they will build
> > in 2.5.60.
> > 
> > Please review and apply or comment...
> 
> well it applies, compiles, but it gives a warning on depmod in make 
> modules_install:
> 
> <snip>
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.60; fi
> WARNING: /lib/modules/2.5.60/kernel/drivers/scsi/aha152x.ko needs unknown 
> symbol scsi_put_command
> WARNING: /lib/modules/2.5.60/kernel/drivers/scsi/aha152x.ko needs unknown 
> symbol scsi_get_command
> 
> this is the relevant part of my .config:
> CONFIG_SCSI=m
> CONFIG_SCSI_AHA152X=m
> 
> this gives these modules in /lib/modules/2.5.60/kernel/drivers/scsi/:
> aha152x.ko  scsi_mod.ko  sg.ko
> 
> what am i missing??

Nothing really, the symbols need to be exported from the SCSI core. 
I'll add them to the export list.

James


