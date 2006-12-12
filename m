Return-Path: <linux-kernel-owner+w=401wt.eu-S1750934AbWLLCaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWLLCaN (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 21:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWLLCaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 21:30:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34293 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934AbWLLCaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 21:30:11 -0500
Date: Mon, 11 Dec 2006 18:23:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Al Viro <viro@ftp.linux.org.uk>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
In-Reply-To: <20061211180822.5f7814d5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612111816580.6452@woody.osdl.org>
References: <200612110330_MC3-1-D49B-BC0F@compuserve.com>
 <20061211005557.04643a75.akpm@osdl.org> <20061211011327.f9478117.akpm@osdl.org>
 <20061211092130.GB4587@ftp.linux.org.uk> <20061211012545.ed945cbd.akpm@osdl.org>
 <20061211093314.GC4587@ftp.linux.org.uk> <20061211014727.21c4ab25.akpm@osdl.org>
 <20061211100301.GD4587@ftp.linux.org.uk> <20061211021718.a6954106.akpm@osdl.org>
 <20061211022746.9ec80c03.akpm@osdl.org> <20061211104556.GF4587@ftp.linux.org.uk>
 <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org> <20061211180822.5f7814d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Andrew Morton wrote:
> 
> Looks like this might break pcmcia which for some reason does firmware
> requesting at fs_initcall level (drivers/pcmcia/ds.c).

Ok, that's just strange. 

I think it's fine to do init_pcmcia_bus early to make sure that the PCMCIA 
bus interface is there by the time the driver init stuff happens, but I 
really don't see the point of that firmware load to be there. And all that 
MATCH_FAKE_CIS stuff is about the _devices_, not the PCMCIA bus, so that 
whole thing looks pretty silly. It should be done by the device 
registration (which is obviously device_initcall), not by some bus layer.

Hopefully Dominik can fix whatever up (if it even needs it)

		Linus
