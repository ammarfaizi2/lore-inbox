Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbTCLADl>; Tue, 11 Mar 2003 19:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbTCLADl>; Tue, 11 Mar 2003 19:03:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261671AbTCLADj>;
	Tue, 11 Mar 2003 19:03:39 -0500
Subject: [PATCH] (0/8) replace brlock with RCU
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>, David Miller <davem@redhat.com>
Cc: Robert Love <rml@tech9.net>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303091831560.2129-100000@home.transmeta.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1047428032.15874.87.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Mar 2003 16:13:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> estionable).
> 
> It's entirely possible that the current user could be replaced by RCU 
> and/or seqlocks, and we could get rid of brlocks entirely.
> 
> 		Linus

The following sequence of patches replaces the remaining use of brlock
with RCU.  Most of this is fairly straightforward. The unregister functions
use synchronize_kernel(), perhaps there should be a special version to
indicate sychronizing with network BH. 

Tested the normal network path and IPV4. 
For the others all the pieces compile. But don't have the test setup to 
give VLAN, SNAP, IPV6, and all the netfilter code a real test.

Comments?


