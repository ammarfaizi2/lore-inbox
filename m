Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTKBEeQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 23:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTKBEeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 23:34:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20419 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261433AbTKBEeE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 23:34:04 -0500
Date: Sun, 2 Nov 2003 04:34:02 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Noah J. Misch" <noah@caltech.edu>
Cc: Matthew Wilcox <willy@debian.org>, linux-ia64@linuxia64.org,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Message-ID: <20031102043402.GF3824@parcelfarce.linux.theplanet.co.uk>
References: <Pine.GSO.4.58.0310251706470.15711@inky> <20031102031644.GB3824@parcelfarce.linux.theplanet.co.uk> <Pine.GSO.4.58.0311011945190.18996@sue>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0311011945190.18996@sue>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 01, 2003 at 08:05:44PM -0800, Noah J. Misch wrote:
> I do not read linux-ia64 regularly, so I did not notice your work.  I
> apologize for not acknowledging it.

No problem ;-)

> Why not include drivers/Kconfig and scrap the individual subdirectory
> includes, as i386 does?

At that time, I hadn't done the work to create drivers/Kconfig ;-)
The main problem for ia64 is the simulator stuff.  Maybe something like:

if !IA64_HP_SIM
source "drivers/Kconfig"
endif

if IA64_HP_SIM
source "drivers/base/Kconfig"
source "drivers/scsi/Kconfig"
source "net/Kconfig"
source "drivers/block/Kconfig"
source "arch/ia64/hp/sim/Kconfig"
endif

(I guess Kconfig needs an "else" keyword).

(Also the duplication of drivers/block/Kconfig is no longer necessary).

> Also, it looks like your patch makes ACPI non-mandatory.  Is that intentional?

Hmmm... no ;-)  I agree the "select" should probably go in -- we seem
to be infected with ACPI for the foreseeable future ;-(

I imagine these kinds of patches can go into 2.6.1 -- the freeze should
let up a bit by then.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
