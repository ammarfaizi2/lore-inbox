Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316309AbSFZCsQ>; Tue, 25 Jun 2002 22:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316322AbSFZCsP>; Tue, 25 Jun 2002 22:48:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:58128 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S316309AbSFZCsO>; Tue, 25 Jun 2002 22:48:14 -0400
Date: Tue, 25 Jun 2002 19:48:06 -0700
From: jw schultz <jw@pegasys.ws>
To: Austin Gonyou <austin@digitalroadkill.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Urgent, Please respond - Re: max_scsi_luns and 2.4.19-pre10.
Message-ID: <20020625194806.C26789@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Austin Gonyou <austin@digitalroadkill.net>,
	linux-kernel@vger.kernel.org
References: <1025052385.19462.5.camel@UberGeek> <1025056235.19779.4.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <1025056235.19779.4.camel@UberGeek>; from austin@digitalroadkill.net on Tue, Jun 25, 2002 at 08:50:35PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm no expert on this bit but look in
drivers/scsi/scsi_scan.c for CONFIG_SCSI_MULTI_LUN 

#ifdef CONFIG_SCSI_MULTI_LUN
static int max_scsi_luns = 8;
#else
static int max_scsi_luns = 1;
#endif

This is the variable you seem to want.

Note to SCSI maintainers.  a quick vi `grep -l CONFIG_SCSI_MULTI_LUN`
here reveals lots of hardcoded values of 8.  It seems to me
that perhaps a CONFIG_SCSI_MAX_LUN to replace
CONFIG_SCSI_MULTI_LUN would be in order.

I know Alan and others are planning to do major cleanup of
the scsi subsystem (hopefully after IDE stablizes?)



On Tue, Jun 25, 2002 at 08:50:35PM -0500, Austin Gonyou wrote:
> I'm really really sorry for asking such a seemingly stupid question, but
> I'm having a very severe issue here and I can't seem to figure out the
> fix. 
> 
> If someone could exchange emails with me for a few mins I'd be very
> grateful. I see that I have max_scsi_luns in my System.map, but I cannot
> see luns > 8(0-7) with 2.4.19-pre10. The same driver set works with the
> default RH installed kernel(2.4.9). So it leads me to believe that
> putting max_scsi_luns=128 (or even 16) in grub.conf isn't being
> effective. 
> 
> Please help.
> 
> On Tue, 2002-06-25 at 19:46, Austin Gonyou wrote:
> > This originally was asking for help regarding QLA2200's, but I've since
> > discovered it's a kernel param problem that I'm not sure how to solve.
> > 
> > Using a default RH kernel (from SGI XFS installer) and passing
> > max_scsi_luns=128 in grub, and for scsi_mod, it seems to work. 
> > 
> > But when I compile my own kernels, none of that stuff is modular, it's
> > all built in. I though that passing max_scsi_luns at boot time would
> > make the scsi subsystem just work with > 8 luns, but so far that doesn't
> > appear to be the case. 
> > 
> > 
> > Can someone please tell me where I've gone wrong? I'm so deep into this,
> > I can't tell which way is up. 
> > 
> > TIA
> > -- 
> > Austin Gonyou <austin@digitalroadkill.net>
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -- 
> Austin Gonyou <austin@digitalroadkill.net>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
