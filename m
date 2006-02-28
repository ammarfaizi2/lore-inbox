Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWB1MT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWB1MT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWB1MT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:19:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932207AbWB1MTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:19:25 -0500
Date: Tue, 28 Feb 2006 04:18:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: pavel@ucw.cz, randy_d_dunlap@linux.intel.com, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Message-Id: <20060228041817.6fc444d2.akpm@osdl.org>
In-Reply-To: <44043B4E.30907@pobox.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
	<20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
	<20060228114500.GA4057@elf.ucw.cz>
	<44043B4E.30907@pobox.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Fine-grained 
>  message selection allows one to turn on only the messages needed, and 
>  only for the controller desired.

Except

- There's (presently) no way of making all the messages go away for a
  non-debug build.

- The code is structured as

	if (ata_msg_foo(p))
		printk("something");

  So if we later do

	#define ata_msg_foo(p)	0

  We'll still get copies of "something" in the kernel image (may be fixed
  in later gcc, dunno).

- The new debug stuff isn't documented.  One has funble around in the
  source to work out how to even turn it on.  Can it be altered at runtime?
  Dunno - the changelogs are risible.  What effect do the various flags
  have?

  Having spent (and re-spent) time grovelling through the ALSA source
  working out how to enable their debug stuff during a maintainer snooze
  I'd prefer we didn't have to do that with libata as well.


