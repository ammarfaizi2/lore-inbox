Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUBYKLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 05:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbUBYKLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 05:11:19 -0500
Received: from gprs147-32.eurotel.cz ([160.218.147.32]:24960 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261175AbUBYKLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 05:11:17 -0500
Date: Wed, 25 Feb 2004 11:11:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Stefan Seyfried <seife@suse.de>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] swsusp/s3: Assembly interactions need asmlinkage
Message-ID: <20040225101100.GA214@elf.ucw.cz>
References: <20040224130051.GA8964@elf.ucw.cz> <20040225083957.GE2869@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225083957.GE2869@poupinou.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > swsusp/s3 assembly parts, and parts called from assembly are not
> > properly marked asmlinkage; that leads to double fault on resume when
> > someone compiles kernel with regparm. Thanks go to Stefan Seyfried for
> > discovering this. Please apply,
> 
> Does acpi_enter_sleep_state_s4bios() have the same issue ?

Yes, it does; I missed that. Thanks. Here's the fix.
								Pavel

--- clean/drivers/acpi/hardware/hwsleep.c	2004-02-05 01:53:59.000000000 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-02-25 11:08:15.000000000 +0100
@@ -359,7 +359,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status asmlinkage
 acpi_enter_sleep_state_s4bios (
 	void)
 {


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
