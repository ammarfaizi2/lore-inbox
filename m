Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUEDQMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUEDQMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264488AbUEDQMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:12:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:40600 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264492AbUEDQLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:11:50 -0400
Subject: Re: [PATCH] allow drivers to claim the lapic NMI watchdog HW
From: Albert Cahalan <albert@users.sf.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: John Levon <levon@movementarian.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       oprofile-list@lists.sourceforge.net, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <16535.48497.41972.583857@alkaid.it.uu.se>
References: <200405040233.i442X1GO025270@harpo.it.uu.se>
	 <20040504110200.GA9880@compsoc.man.ac.uk>
	 <16535.48497.41972.583857@alkaid.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1083678542.951.158.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 May 2004 09:49:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-04 at 11:57, Mikael Pettersson wrote:
> John Levon writes:
>  > On Tue, May 04, 2004 at 04:33:01AM +0200, Mikael Pettersson wrote:
>  > 
>  > > +/* lapic_nmi_owner:
>  > > + * +1: the lapic NMI hardware is assigned to the lapic NMI watchdog
>  > > + *  0: the lapic NMI hardware is unassigned
>  > 
>  > If we're going to have a mini state machine, can't we at least use some
>  > defines for each state...
>  > 
>  > > +		lapic_nmi_owner -= 2; /* +1 -> -1, 0 -> -2 */
>  > 
>  > ...and make this into some readable english via a little helper?
> 
> Thing is, using discrete states makes the code for the checks
> and state changes more verbose. However, I can easily hide the
> representation behind macros with understandable names.

It looked like 2 flag bits to me.

#define LAPIC_WATCHDOG_WANTS_NMI   0x00000001
#define LAPIC_OTHER_DRIVER_HAS_NMI 0x00000002


