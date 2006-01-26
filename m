Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWAZK4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWAZK4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAZK4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:56:44 -0500
Received: from nsm.pl ([62.111.143.37]:60697 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932079AbWAZK4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:56:44 -0500
Date: Thu, 26 Jan 2006 11:56:40 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126105640.GA5608@irc.pl>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	rlrevell@joe-job.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de, axboe@suse.de,
	acahalan@gmail.com
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125190013.GA6135@irc.pl> <43D8A3AD.nailDTH8Y1A3Z@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D8A3AD.nailDTH8Y1A3Z@burner>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:25:49AM +0100, Joerg Schilling wrote:
> Tomasz Torcz <zdzichu@irc.pl> wrote:
> 
> > > > need to use /dev/hda, but /dev/cdrecorder or whatever. A real user would
> > > > likely be using k3b or something graphical though, and just click on his
> > > > Hitachi/Plextor/whatever burner. Perhaps some fancy udev rules could
> > > > help do this dynamically even.
> > > 
> > > Guess why cdrecord -scanbus is needed.
> > > 
> > > It serves the need of GUI programs for cdrercord and allows them to retrieve 
> > > and list possible drives of interest in a platform independent way.
> >
> >   GUI programs tend to retrieve this kind of info form HAL
> > (http://freedesktop.org/wiki/Software_2fhal)
> 
> I am not sure what you like to tell with this.
> 
> Programs that depend on specific Linux behavior tend to be non-portable (see 
> e.g. nautilus on GNOME). Nautilus tries to get e.g. the drive write speeds
> by reading /prov/scsi/******. Besides the fact that this is not available 
> elsewhere, it gives incorrect results because there are a lot of DVD writers 
> with broken firmware.

  This is a fallback if HAL isn't available.  Normally this is done by:

drive->max_speed_write = libhal_device_get_property_int
                                (ctx, device_names [i],
                                 "storage.cdrom.write_speed",
                                 NULL)
                                / CD_ROM_SPEED;

 (natilus-burn-drive.c:1368 from version 2.12.0).

> Cdrecord implements workarounds for this kind of problems and for this reason, 
> the most portable solution for a GUI is to use cdrecord to retrieve the 
> information.

  Yeah, sure.
                  /* FIXME we don't have any way to guess the real device
                   * from the info we get from CDRecord */

 (the only FIXME in above mentioned file).

-- 
Tomasz Torcz                                                       72->|   80->|
zdzichu@irc.-nie.spam-.pl                                          72->|   80->|

