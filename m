Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133056AbREEX1W>; Sat, 5 May 2001 19:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135590AbREEX1M>; Sat, 5 May 2001 19:27:12 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:22023 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S133056AbREEX07>;
	Sat, 5 May 2001 19:26:59 -0400
Date: Sat, 5 May 2001 19:27:31 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 design philosophy heads-up
Message-ID: <20010505192731.A2374@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've said before on these lists that one of the purposes of CML2's single-apex
tree design is to move the configuration dialog away from low-level platform-
specific questions towards higher-level questions about policy or intentions.

Or to put another way: away from hardware, towards capabilities.

As a concrete example, the CML2 rulesfile master for the m68k port
tree now has a section that looks like this:

# These were separate questions in CML1.  They enable on-board peripheral
# controllers in single-board computers.
derive MVME147_NET from MVME147 & NET_ETHERNET
derive MVME147_SCC from MVME147 & SERIAL
derive MVME147_SCSI from MVME147 & SCSI
derive MVME16x_NET from MVME16x & NET_ETHERNET
derive MVME16x_SCC from MVME16x & SERIAL
derive MVME16x_SCSI from MVME16x & SCSI
derive BVME6000_NET from BVME6000 & NET_ETHERNET
derive BVME6000_SCC from BVME6000 & SERIAL
derive BVME6000_SCSI from BVME6000 & SCSI

# These were separate questions in CML1
derive MAC_SCC from MAC & SERIAL
derive MAC_SCSI from MAC & SCSI
derive SUN3_SCSI from (SUN3 | SUN3X) & SCSI

If it isn't obvious, the intent is that if you specify (say) both 
MVME147 (a machine type) and SERIAL (a capability) you automatically 
get the specific driver support under MVME147_SCC.

This is different from the CML1 approach, which generally involved
explicitly specifying each driver with mutual dependencies described 
(if at all) in Configure.help.

I've created a number of derivations of this kind recently.  I'm not
going out of my way to do this, but what I am trying to do is reduce
the number of symbols undocumented in Configure.help to zero (I've got
it down to 243 from 547 when I started).  When I can eliminate the
need for a configuration question and associated help by writing this
kind of formula, I'm doing so.

This note is a heads-up.  If others with a stake in the configuration
system (port managers, etc.) have objections to moving further in this
direction, I need to hear about it, and about what you think we should
be doing instead.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never could an increase of comfort or security be a sufficient good to be
bought at the price of liberty.
	-- Hillaire Belloc
