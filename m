Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbTCLAUA>; Tue, 11 Mar 2003 19:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262991AbTCLATn>; Tue, 11 Mar 2003 19:19:43 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54505 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262986AbTCLASL>;
	Tue, 11 Mar 2003 19:18:11 -0500
Date: Tue, 11 Mar 2003 16:28:31 -0800 (PST)
Message-Id: <20030311.162831.42576307.davem@redhat.com>
To: torvalds@transmeta.com
Cc: shemminger@osdl.org, rml@tech9.net, zwane@linuxpower.ca,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] (0/8) replace brlock with RCU
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303111622260.2709-100000@home.transmeta.com>
References: <1047428032.15874.87.camel@dell_ss3.pdx.osdl.net>
	<Pine.LNX.4.44.0303111622260.2709-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 11 Mar 2003 16:23:24 -0800 (PST)
   
   On 11 Mar 2003, Stephen Hemminger wrote:
   > 
   > The following sequence of patches replaces the remaining use of brlock
   > with RCU.  Most of this is fairly straightforward. The unregister functions
   > use synchronize_kernel(), perhaps there should be a special version to
   > indicate sychronizing with network BH. 
   >
   > Comments?
   
   I'm not going to take this directly, but if it passes muster with David, 
   I'm happy.  The fewer locking primitives we need, the better, and brlocks 
   have had enough problems that I wouldn't mind getting rid of them.

I'm fine with it, as long as I get shown how to get the equivalent
atomic sequence using the new primitives.  Ie. is there still a way
to go:

	stop_all_incoming_packets();
	do_something();
	resume_all_incoming_packets();

with the new stuff?
