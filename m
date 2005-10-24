Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbVJXEmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVJXEmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 00:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVJXEmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 00:42:19 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:58209 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1750983AbVJXEmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 00:42:18 -0400
X-IronPort-AV: i="3.97,243,1125896400"; 
   d="scan'208"; a="312167702:sNHT29015880"
Date: Sun, 23 Oct 2005 23:42:17 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Corey Minyard <minyard@acm.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 1/9] ipmi: use refcount in message handler
Message-ID: <20051024044217.GA32199@lists.us.dell.com>
References: <20051021144909.GA19532@i2.minyard.local> <20051024021931.GA9696@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024021931.GA9696@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2005 at 07:19:32PM -0700, Paul E. McKenney wrote:
> My guess is that this read-side critical section can be invoked from and
> SMI, and that SMIs can occur even if interrupts are disabled.  If my guess
> is wrong, please enlighten me.  And feel free to ignore the next few
> paragraphs in that case, along with a number of my suggested changes,
> since they all depend critically on my guess being correct.

Paul, it took me a bit to figure this out too, but Corey uses the TLA
"SMI" to mean "Systems Management Interface", not "Systems Management
Interrupt".   From Documentation/IPMI.txt:

ipmi_msghandler - This is the central piece of software for the IPMI
system.  It handles all messages, message timing, and responses.  The
IPMI users tie into this, and the IPMI physical interfaces (called
System Management Interfaces, or SMIs) also tie in here.


There are at least 4 basic types of physical hardware interfaces (BT,
SMIC, KCS, and I2C), which may (or more often, may not) have their own
hardware interrupt lines, but these are normal interrupts, not
CPU-magic "systems management interrupts".  So I think this isn't a
problem.

Thanks,
Matt


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
