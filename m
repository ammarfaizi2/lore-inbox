Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262146AbSJFTlr>; Sun, 6 Oct 2002 15:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262165AbSJFTlr>; Sun, 6 Oct 2002 15:41:47 -0400
Received: from adsl-66-136-198-157.dsl.austtx.swbell.net ([66.136.198.157]:4996
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S262146AbSJFTlU>; Sun, 6 Oct 2002 15:41:20 -0400
Subject: RE: QLogic Linux failover/Load Balancing ER0000000020860
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Austin Gonyou <austin@coremetrics.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200210061546.g96FjxN11522@localhost.localdomain>
References: <200210061546.g96FjxN11522@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1033933613.2436.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 06 Oct 2002 14:46:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 10:45, James Bottomley wrote:
> > The reason this is a problem, is that when the LSI/StoragTEK
> > controllers present their luns, AVT is enabled.
> 
> Others have answered the kernel questions, but just a note that you really 
> don't want to do load balancing in this environment.

Hard-coding it to get load-balancing isn't terrible, and when the qlogic
driver works, the way I've got my controllers setup right now, it will
work just like powerpath, etc. There are no *ghosted* luns ATM, just the
*other luns*. Only when a failure occurrs, do I want them to be able to
be addressed down the alternate path. Since Target Reset is on, and the
driver is aware of all LUNs, it should allow the failover to occur. I'm
going to do some testing right now and see anyway, after adding
sparselun for the STK array. 

> the way AVT works is that a LUN is locked to a specific controller (although 
> it has a ghost on the alternate controller).  If you send an I/O packet to the 
> alternate controller, the controllers will immediately negotiate to transfer 
> the LUN across (AVT is Auto Volume Transfer).  It takes quite a while (in I/O 
> terms) for the LUN to transfer, so if you load balance to this array you'll 
> end up killing performance because most of the time will be spent oscillating 
> the LUN.
> 
> The way the setup was intended to work was for simple failover, where you only 
> use an alternate path if the primary fails.

Currently things are more hard-coded than I'd like, but we're redundant
in many ways anyway. I'm going to see if the sparseluns bits at least
lets it keep working, but then I'll see if it actually does keep the
luns in more AVT time, than in operational time. 

> In general, arrays that can gain performance from controller load balancing 
> tend to be extremely expensive (EMC being the one that springs immediately to 
> mind).
> 
> James
> 

