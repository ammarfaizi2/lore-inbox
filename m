Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317047AbSFQVrx>; Mon, 17 Jun 2002 17:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317045AbSFQVrw>; Mon, 17 Jun 2002 17:47:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51889 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317040AbSFQVru>;
	Mon, 17 Jun 2002 17:47:50 -0400
Date: Mon, 17 Jun 2002 14:47:38 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020617144738.A14245@eng2.beaverton.ibm.com>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617133534.A10174@eng2.beaverton.ibm.com> <20020617205750.GC1313@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020617205750.GC1313@gum01m.etpnet.phys.tue.nl>; from garloff@suse.de on Mon, Jun 17, 2002 at 10:57:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt -

On Mon, Jun 17, 2002 at 10:57:50PM +0200, Kurt Garloff wrote:
> Hi Patrick,
> 
> > I prefer we refer to the tuple as host, channel, id, lun (H, C, I, L), so
> > as to more closely match /proc/scsi/scsi, /proc/scsi/sg, and attached
> > messages:
> 
> You are refering to the naming of this 4-tuple, right: HCIL vs. CBTU?

Yes.

> I chose for CBTU, because that on's used in devfs. Actually, as you can see
> from scsidev, I like HCIL more. But that's a detail the kernel should not
> care about. The header line should be removed anyway as Albert remarked.
> And helping those people who think that 200 bytes is unacceptable bloat.
> 
> [...]
> > > 3,0,12,00       0x00    1       sg12    c:15:0c sdf     b:08:50
> > 
> > Why not treat each upper layer driver the same? Type is already
> > in /proc/scsi/scsi, or implied by the upper level drivers attached.
> > Online should really be part of /proc/scsi/scsi.
> 
> I'm not sure I know what you mean. The fact that I decided to put
> the sg device name first independently of the (potentially) random
> order in which high-level drivers are assigned?

Yes, I don't know why I took that to mean that sg was displayed differently.

> Just I decided to report shg first. This has a very pratical reason:
> I you want to use userspace tools to collect more advanced (and maybe type
> dependant information), you will always want to use the sg device, which 
> you can use to send SCSI commands and which you can open, even if there is
> no medium or if the device is in use.

No matter the column position sg can be found if each column includes
the upper level name (sg, sd etc.). Then you do not need to know or
check the scsi_type of the template, or explicitly locate the sg
template in scsi_proc_map().

And then without the header scsi_proc_map() gets really simple.

> Regards,
> -- 
> Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
> GPG key: See mail header, key servers         Linux kernel development
> SuSE Linux AG, Nuernberg, DE                            SCSI, Security

-- Patrick Mansfield
