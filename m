Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUCVQd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbUCVQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:33:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5017 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262085AbUCVQd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:33:26 -0500
Date: Mon, 22 Mar 2004 17:33:08 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: armin@melware.de
Subject: Re: [PATCH] ISDN Eicon driver: restructured capi list and lock handling
Message-ID: <20040322163307.GA22295@devserv.devel.redhat.com>
References: <200403211807.i2LI7e2O004808@hera.kernel.org> <1079971289.5296.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079971289.5296.10.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 22, 2004 at 05:32:42PM +0100, Arjan van de Ven wrote:
> On Sun, 2004-03-21 at 17:55, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1828, 2004/03/21 08:55:24-08:00, armin@melware.de
> > 
> > 	[PATCH] ISDN Eicon driver: restructured capi list and lock handling
> > 	
> > 	Restructered the CAPI code of list handling and lock.
> > 	
> > 	Removed obsolete code.
> 
> this patch is broken:
> Error: ./drivers/isdn/hardware/eicon/capifunc.o .altinstructions refers
> to 00000018 R_386_32          .exit.text
> Error: ./drivers/isdn/hardware/eicon/capifunc.o .init.text refers to
> 0000015d R_386_PC32        .exit.text
> 
> eg you call __exit functions from __init functions, which is
> incorrect....

and the fix:

--- linux-2.6.4/drivers/isdn/hardware/eicon/capifunc.c~	2004-03-22 17:12:30.868043408 +0100
+++ linux-2.6.4/drivers/isdn/hardware/eicon/capifunc.c	2004-03-22 17:12:30.868043408 +0100
@@ -455,7 +455,7 @@
 /*
  * remove cards
  */
-static void DIVA_EXIT_FUNCTION divacapi_remove_cards(void)
+static void divacapi_remove_cards(void)
 {
 	DESCRIPTOR d;
 	struct list_head *tmp;
