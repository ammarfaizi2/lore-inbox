Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261664AbSJFPkf>; Sun, 6 Oct 2002 11:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbSJFPke>; Sun, 6 Oct 2002 11:40:34 -0400
Received: from host194.steeleye.com ([66.206.164.34]:38409 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261664AbSJFPka>; Sun, 6 Oct 2002 11:40:30 -0400
Message-Id: <200210061546.g96FjxN11522@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Austin Gonyou <austin@coremetrics.com>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: RE: QLogic Linux failover/Load Balancing ER0000000020860
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 Oct 2002 11:45:59 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The reason this is a problem, is that when the LSI/StoragTEK
> controllers present their luns, AVT is enabled.

Others have answered the kernel questions, but just a note that you really 
don't want to do load balancing in this environment.

the way AVT works is that a LUN is locked to a specific controller (although 
it has a ghost on the alternate controller).  If you send an I/O packet to the 
alternate controller, the controllers will immediately negotiate to transfer 
the LUN across (AVT is Auto Volume Transfer).  It takes quite a while (in I/O 
terms) for the LUN to transfer, so if you load balance to this array you'll 
end up killing performance because most of the time will be spent oscillating 
the LUN.

The way the setup was intended to work was for simple failover, where you only 
use an alternate path if the primary fails.

In general, arrays that can gain performance from controller load balancing 
tend to be extremely expensive (EMC being the one that springs immediately to 
mind).

James


