Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWH3TZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWH3TZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWH3TZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:25:42 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:3525 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751365AbWH3TZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:25:33 -0400
Subject: Re: [PATCH] aic94xx: Increase can_queue and cmds_per_lun
From: James Bottomley <James.Bottomley@SteelEye.com>
To: ltuikov@yahoo.com
Cc: "Darrick J. Wong" <djwong@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>,
       Konrad Rzeszutek <konrad@darnok.org>
In-Reply-To: <20060830190454.28371.qmail@web31807.mail.mud.yahoo.com>
References: <20060830190454.28371.qmail@web31807.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 15:25:20 -0400
Message-Id: <1156965920.7701.13.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 12:04 -0700, Luben Tuikov wrote:
> > --- a/drivers/scsi/aic94xx/aic94xx_init.c
> > +++ b/drivers/scsi/aic94xx/aic94xx_init.c
> > @@ -71,7 +72,7 @@ static struct scsi_host_template aic94xx
> >       .change_queue_type      = sas_change_queue_type,
> >       .bios_param             = sas_bios_param,
> >       .can_queue              = 1,
> > -     .cmd_per_lun            = 1,
> > +     .cmd_per_lun            = 2,
> 
> Why 2?  Why not 3?  If you can set this to 3, then why not 4?
> But if you can set it to 4, why not 5?
> 
> This value should also be dynamically set, it should depend on
> the type of LU and it shouldn't be present in the host template.
> (But that's an architectural argument which leads nowhere on lsml.)

actually, cmd_per_lun is pretty much a vestigial variable.  It's used
for the initial queue depth before the driver decides to turn on TCQ.
Thus, since the non-tagged depth should always only be 1, the only
useful value to set it to is 1.

James


