Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263812AbTE0P1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTE0P0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:26:25 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:29958 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263867AbTE0PZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:25:40 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527152113.GA21744@gtf.org>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
	<1054047595.1975.64.camel@mulgrave>  <20030527152113.GA21744@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 11:38:50 -0400
Message-Id: <1054049931.1975.129.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 11:21, Jeff Garzik wrote:
> ATA defines WWN too...  I'm curious what the format is?  uuid-ish?

Heh, you'll regret asking that one.  There are currently seven possible
identifier formats for the WWN (which is basically the SCSI Device
Identification VPD page).

The extremely gory details are in the SPC-3 spec (section 7.6.4 of r12).

However, really, as far as Linux is concerned we don't need to care.  It
just needs to be reducible to an ASCII representation and dumped into
the sysfs name or embedded into bus_id.  The reduction to ASCII can be
subsystem (or even device driver) specific.

However, note that I'm not thinking of forcing the WWN here.  I'm
thinking of using whatever makes most sense to the device, so SPI
devices will continue to use simple target/lun numbers here.  FC devices
will probably want to use their variant of WWN/PortID.  The rationale is
to get rid of the unnecessary internal mappings some drivers use to get
to the physical address they send on the wire.

Thus, if you never address ATA devices by the WWN, you probably never
want to make it part of the addressing scheme.

Exporting a unique ID for userspace to use is a different (and probably
orthogonal) issue.

James


