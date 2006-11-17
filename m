Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933716AbWKQQbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933716AbWKQQbd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWKQQbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:31:33 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:7872 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932941AbWKQQbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:31:32 -0500
Date: Fri, 17 Nov 2006 16:31:28 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <linux-acpi@vger.kernel.org>
Subject: Re: acpiphp makes noise on every lid close/open
Message-ID: <20061117163128.GA2068@srcf.ucam.org>
References: <20061102175403.279df320.kristen.c.accardi@intel.com> <20061105232944.GA23256@vasa.acc.umu.se> <20061106092117.GB2175@elf.ucw.cz> <20061107204409.GA37488@vasa.acc.umu.se> <20061107134439.1d54dc66.kristen.c.accardi@intel.com> <20061117102237.GS14886@vasa.acc.umu.se> <20061117151341.GA1162@srcf.ucam.org> <20061117153717.GU14886@vasa.acc.umu.se> <20061117154627.GA1544@srcf.ucam.org> <20061117160810.GW14886@vasa.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117160810.GW14886@vasa.acc.umu.se>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 05:08:10PM +0100, David Weinehall wrote:

> Good question.  Personally I'd say we refuse to suspend when we have
> devices we *know* to be dock-devices etc mounted.

Kernel-level or userspace? IBM certainly used to sell bay-mounted hard 
drives, and while it's possible for a user to pull one out while the 
machine is suspended, I suspect that the general use case is probably 
for it to carry on being used.

Possibly what's needed is something like Apple's nullfs - force unmount 
the drive on suspend, and put a nullfs there instead. On resume, if the 
drive is still there, remount it. If not, userspace applications get 
upset about the missing drive but no data is lost. The downside to this 
approach would be trying to figure out how to get the drive remounted 
before the rest of userspace starts trying to scribble over it again...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
