Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268222AbTGIMk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 08:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268224AbTGIMk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 08:40:27 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49062 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268222AbTGIMk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 08:40:26 -0400
Date: Wed, 9 Jul 2003 14:55:04 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: Redundant memset in AIO read_events
In-Reply-To: <41F331DBE1178346A6F30D7CF124B24B2A4889@fmsmsx409.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0307091447410.19820-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, here is another one.  In the top level read_events() function in
> fs/aio.c, a struct io_event is instantiated on the stack (variable ent).
> It calls aio_read_evt() function which will fill the entire io_event
> structure into variable ent.  What's the point of zeroing when copy
> covers the same memory area?  Possible a debug code left around?

Read the comment before that memset. The structure might contain some
padding (bytes not belonging to any of its entries), these bytes are
random and if you do not zero them, you copy random data into userspace.

Mikulas


