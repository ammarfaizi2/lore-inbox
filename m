Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUBTXIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUBTXIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:08:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:48299 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261432AbUBTXIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:08:13 -0500
Subject: Re: Double fb_console_init call during do_initcalls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Jonathan Brown <jbrown@emergence.uk.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402201907130.6798-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402201907130.6798-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077318157.9626.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 10:02:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I seen the report and begain to create a patch. The module_init fix is 
> easy. Just place module_init and module_exit under #ifdef MODULE. I 
> realize alot of fbdev drivers do this wrong. I will make patches by the 
> end of the day. As for the fbmem.c call on fb_console_init. Well that is 
> tricker to deal with. I will have to figure out a way.

You can also use the fb_registered_client static I added and rename
it to fbcon_initialized ;) Dunno if we actually _need_ the second call
to take_over_console at this point, so i left it called twice, but
I needed the static to protect against registering the notifier twice

(That was what was causing the notifier list to get corrupted and
mode changes to lockup in early implementations)

Ben.


