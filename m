Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWIKXOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWIKXOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWIKXOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:14:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:1205 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932154AbWIKXOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:14:47 -0400
Subject: Re: [PATCH] Prevent legacy io access on pmac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060911115354.GA23884@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:14:25 +1000
Message-Id: <1158016465.15465.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-11 at 13:53 +0200, Olaf Hering wrote:
> The ppc32 common config runs also on PReP/CHRP, which uses PC style IO
> devices.  The probing is bogus, it crashes or floods dmesg.
> 
> ppc can boot one single binary on prep, chrp and pmac boards.
> ppc64 can boot one single binary on pseries and G5 boards.
> pmac has no legacy io, probing for PC style legacy hardware leads to a
> hard crash:
> 
> * add check for parport_pc, exit on pmac.
> 32bit chrp has no ->check_legacy_ioport, the probe is always called.
> 64bit chrp has check_legacy_ioport, check for a "parallel" node
> 
> * add check for isapnp, only PReP boards may have real ISA slots.
> 32bit PReP will have no ->check_legacy_ioport, the probe is always called.
> 
> * update code in i8042_platform_init. Run ->check_legacy_ioport first, always
> call request_region. No functional change. Remove whitespace before i8042_reset init.
> 
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Looks good to me.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


