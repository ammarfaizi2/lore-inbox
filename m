Return-Path: <linux-kernel-owner+w=401wt.eu-S932444AbXARPXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbXARPXg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbXARPXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:23:36 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4400 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbXARPXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:23:35 -0500
Date: Thu, 18 Jan 2007 15:23:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tomas Carnecky <tom@dbservice.com>
Cc: Bernhard Walle <bwalle@suse.de>, linux-kernel@vger.kernel.org,
       Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [patch 03/26] Dynamic kernel command-line - arm
Message-ID: <20070118152326.GC31418@flint.arm.linux.org.uk>
Mail-Followup-To: Tomas Carnecky <tom@dbservice.com>,
	Bernhard Walle <bwalle@suse.de>, linux-kernel@vger.kernel.org,
	Alon Bar-Lev <alon.barlev@gmail.com>
References: <20070118125849.441998000@strauss.suse.de> <20070118130028.719472000@strauss.suse.de> <20070118141359.GB31418@flint.arm.linux.org.uk> <45AF92E7.50901@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AF92E7.50901@dbservice.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2007 at 04:31:51PM +0100, Tomas Carnecky wrote:
> Russell King wrote:
> > On Thu, Jan 18, 2007 at 01:58:52PM +0100, Bernhard Walle wrote: 
> >> -static char command_line[COMMAND_LINE_SIZE];
> >> +static char __initdata command_line[COMMAND_LINE_SIZE];
> > 
> > Uninitialised data is placed in the BSS.  Adding __initdata to BSS
> > data causes grief.
> > 
> 
> Static variables are implicitly initialized to zero. Does that also
> count as initialization?

No.  As I say, they're placed in the BSS.  The BSS is zeroed as part of
the C runtime initialisation.

If you want to place a variable in a specific section, it must be
explicitly initialised.  Eg,

static char __initdata command_line[COMMAND_LINE_SIZE] = "";

However, there is a bigger question here: that is the tradeoff between
making this variable part of the on-disk kernel image, but throw away
the memory at runtime, or to leave it in the BSS where it will not be
part of the on-disk kernel image, but will not be thrown away at
runtime.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
