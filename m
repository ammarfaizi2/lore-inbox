Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSFZOev>; Wed, 26 Jun 2002 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSFZOeu>; Wed, 26 Jun 2002 10:34:50 -0400
Received: from adsl-66-136-202-174.dsl.austtx.swbell.net ([66.136.202.174]:27273
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316605AbSFZOet>; Wed, 26 Jun 2002 10:34:49 -0400
Subject: Re: max_scsi_luns and 2.4.19-pre10.
From: Austin Gonyou <austin@digitalroadkill.net>
To: Kurt Garloff <garloff@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <20020626123337.GC1217@gum01m.etpnet.phys.tue.nl>
References: <1025052385.19462.5.camel@UberGeek>
	  <20020626123337.GC1217@gum01m.etpnet.phys.tue.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 26 Jun 2002 09:32:27 -0500
Message-Id: <1025101947.19700.15.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 07:33, Kurt Garloff wrote:
> Hi Austin,
> 
> enough guesses have been there not answering your questions ...
> 
> On Tue, Jun 25, 2002 at 07:46:25PM -0500, Austin Gonyou wrote:
> > This originally was asking for help regarding QLA2200's, but I've since
> > discovered it's a kernel param problem that I'm not sure how to solve.
> > 
> > Using a default RH kernel (from SGI XFS installer) and passing
> > max_scsi_luns=128 in grub, and for scsi_mod, it seems to work. 
> 
> In 2.4.19pre1 a patch was merged into mainline which introduced a flag
> BLIST_LARGELUN and set it for EMC Symmetrix devices. Some distributors
> (incl. RH and SuSE) did ship kernels with this patch included.
> http://van-dijk.net/linuxkernel/200206/0347.html
> (An older patch for 2.4.16 exists as well.)

Ahh...I see now. I looked for DELL in the scsi_scan.c and saw the
symmetrix there right above it. I should be able to add LARGELUN, since
it's #defined above and go for it. I'll see what this does, it's
starting to make sense now. TIA.



> The flag does allow a device to use more than 8 LUNs despite it reporting
> as SCSI Version 2 devices (which can not support more than 8 LUNs normally
> ...) 
> The flag also needs to be set for some more devices, look for DGC, DELL, CMD
> and CNSi/CNSI devices that already have the BLIST_SPARSELUN flag.
> 
> But as you did not post the output of /proc/scsi/scsi nor the syslog
> meesages from your SCSI subsystem nobody knows what devices you're using or
> what actually happens. Just speculations ...
> 
> PS: The better list for such questions is linux-scsi@vger.kernel.org
> 
> Regards,
> -- 
> Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
> GPG key: See mail header, key servers         Linux kernel development
> SuSE Linux AG, Nuernberg, DE                            SCSI, Security
-- 
Austin Gonyou <austin@digitalroadkill.net>
