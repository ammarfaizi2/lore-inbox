Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbSJFDNP>; Sat, 5 Oct 2002 23:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263284AbSJFDNP>; Sat, 5 Oct 2002 23:13:15 -0400
Received: from adsl-66-136-198-157.dsl.austtx.swbell.net ([66.136.198.157]:63361
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S263264AbSJFDNO>; Sat, 5 Oct 2002 23:13:14 -0400
Subject: RE: QLogic Linux failover/Load Balancing ER0000000020860
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1033862965.27451.51.camel@UberGeek.coremetrics.com>
References: <41EBA11203419D4CA8EB4C6140D8B4017CD8EE@AVEXCH01.qlogic.org>
	 <1033862965.27451.51.camel@UberGeek.coremetrics.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033874298.4209.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 05 Oct 2002 22:18:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was hoping someone on this list might have some ideas about this.
Please respond to me at this address or the Coremetrics one.  I'm not
sure exactly what approach to take on this. Any hints would be helpful.


TIA.

On Sat, 2002-10-05 at 19:09, Austin Gonyou wrote:
> The latest driver does not load balance with STK D178 array either.
> 
> I've discovered why, but I'm not sure which direction to take with
> helping out to get better closure/resolution with this.
> 
> 
> The cause of the problem is that the QLogic driver doesn't to
> transparent LUN masking it seems. The reason this is a problem, is that
> when the LSI/StoragTEK controllers present their luns, AVT is enabled.
> This causes LUN "ghosting" down each path from the storage to the HBAs.
> This becomes a problem because when the Linux Driver is told to perform
> load balancing via static bindings, the LUNs are now out of order.
> (whether LUN ghosting is happening or not). 
> 
....
> Linux is not allowed to address LUNs out of sequence, so searching for
> further LUN numbers stops after 0, since 2 is the next one. 
> 
> Is there a way to resolve this, either at the driver level, IMHO the
> place it *should* happen. At the storage level, the place that it could
> also happen, or in the Kernel?
> 
> For the time being, I'm using a temporary load balanced setup for
> performance reasons since we just extended our two primary loops from 1
> tray each, to 3 and 4 trays. Please advise ASAP, as in this
> configuration, we cannot fail-over. 
> 
> TIA
> -- 
> Austin Gonyou <austin@coremetrics.com>
> Systems Architect
> Coremetrics, Inc.
> Cel: 512-698-7250
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
