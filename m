Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbULIBND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbULIBND (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 20:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbULIBND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 20:13:03 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:53148 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261419AbULIBMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 20:12:52 -0500
Subject: RE: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       Matt Domsch <Matt_Domsch@Dell.com>, brking@us.ibm.com,
       linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 14:01:21 -0600
Message-Id: <1102536081.4218.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 13:42 -0500, Salyzyn, Mark wrote:
> James Bottomley writes:
> >The real way I'd like to handle this is via hotplug.  The hotplug event
> >would transmit the HCTL in the environment.  Whether the drive actually
> >gets incorporated into the system and where is user policy, so it's
> >appropriate that it should be in userland.
> 
> The problem is the aac based cards generate events (AIFs) that are
> picked up by the driver. To go all the way to userland to interpret
> these events and back to the driver is a waste and a source of failures.
> Only the Firmware knows when an array zeroing has completed in order to
> bring the device online.

Hotplug is the standard way of handling configuration changes (whether
requested or forced).  There's value to handling things in a standard
manner.  If the current implementation needs improving, then you're free
to do it (and it would benefit far more than just SCSI...).

So the firmware calls the SCSI API which triggers the hotplug event and
adds the device ... there's no problem.

> >This same infrastructure could be used by fibre channel login, scsi
> >enclosure events etc.
> 
> I would need to emulate an SES to propagate array changes?

No.  Merely that the hotplug API would also be usable by SES (and other
things).

James


