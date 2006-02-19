Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWBSJVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWBSJVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 04:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWBSJVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 04:21:05 -0500
Received: from mail.gmx.de ([213.165.64.20]:60046 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932299AbWBSJVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 04:21:04 -0500
X-Authenticated: #428038
Date: Sun, 19 Feb 2006 10:20:59 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
       nix@esperi.org.uk, linux-kernel@vger.kernel.org, chris@gnome-de.org,
       axboe@suse.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060219092059.GA21626@merlin.emma.line.org>
Mail-Followup-To: "D. Hazelton" <dhazelton@enter.net>,
	Bill Davidsen <davidsen@tmr.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, mj@ucw.cz,
	nix@esperi.org.uk, linux-kernel@vger.kernel.org, chris@gnome-de.org,
	axboe@suse.de
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <43F0A319.nailKUSXT33MZ@burner> <43F7257D.80400@tmr.com> <200602182010.02468.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602182010.02468.dhazelton@enter.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006, D. Hazelton wrote:

> At this point I seem to have stumbled across a document that has what Joerg 
> might be looking for Linux to introduce. It's available at t10.org and is a 
> translation layer specification for OS's to use if they want to access ATA 
> devices like SCSI ones.

Is that something other than CAM? If so, please mention the exact
document name.

> Seems to me this wouldn't be a good or bad thing to add to the kernel. The 

Well, such an integration must avoid:

- breaking existing conformant applications, where conformant here would
  apply to existing interface documentation such as the SCSI General
  Programming HOWTO from torque.net.

  This means that int fd = open("/dev/foo", O_RDWR, 0);
                  int e = ioctl(fd, SG_IO, &cmd_block);
  needs to remain functional.

- duplicating code which would cause immediate bit-rot...

> problem is that introducing the layer and thereby unifying the SCSI and ATA 
> busses into one namespace is a big task.

...so it could really only be an interface layer on top of existing
interfaces to avoid that. (Any other opinions?)

And then that interface would only be sensible if it actually improves
the situation, for instance, if applications gain source-level
compatibility with NetBSD or FreeBSD.

I think libata's integration of parallel ATA is already going a way that
leads to unifiying all the layers. For disks, the sd driver is used with
libata. I'd be surprised if it wouldn't work for CD/DVD drives, too, at
least in the long run.

Part of the problem is Jörg's expecting a solution the day before yesterday.

-- 
Matthias Andree
