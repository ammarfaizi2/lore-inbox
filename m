Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVCREmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVCREmP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 23:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCREmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 23:42:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:46794 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261463AbVCREmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 23:42:10 -0500
Subject: Re: [PATCH 2/2] Thinkpad Suspend Powersave: Add D2 power saving
	code for Thinkpads with Radeon video chipsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, "Brown, Len" <len.brown@intel.com>,
       Volker Braun <volker.braun@physik.hu-berlin.de>
In-Reply-To: <20050318033928.GD4851@thunk.org>
References: <3.518178082@mit.edu> <1111015144.15510.47.camel@gaston>
	 <20050318033928.GD4851@thunk.org>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 15:41:06 +1100
Message-Id: <1111120866.25180.154.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 22:39 -0500, Theodore Ts'o wrote:
> On Thu, Mar 17, 2005 at 10:19:04AM +1100, Benjamin Herrenschmidt wrote:
> > You probably want to remove the bit that does
> > 
> > 	OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
> > 
> > Or you'll lose TV output :)
> 
> I'm not using TV output, and the original patch stated:
> 
> > > +		/* Power down TV DAC, that saves a significant amount of power,
> > > +		 * we'll have something better once we actually have some TVOut
> > > +		 * support
> > > +		 */

Yup, I know, I wrote this bit :)

> I suppose I should renable the TV DAC and see how much power it
> actually consumes if I enable it.  It would seem to me that we should
> have a way that we can power down whatever parts of the video chipset
> that we're not using.  (For example if I don't have anything connected
> to the VGA output, it would be good if we could power that down too...)

We can power down the internal DAC too, yes, and the TMDS transmitter
when no DVI is plugged, etc.. and we can also lower the chip clock :) I
do intend to do these things. The problem right now is
that the above will break some users who have a BIOS that can set
TV-Out. Maybe some sysfs attribute ? At least until I can properly
probe all ports including the TV Out (I'm working on that). Ultimately,
the driver should be able to properly detect everything that is
connected.

Ben.

