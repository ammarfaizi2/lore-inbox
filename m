Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUAWHPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUAWHPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:15:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:49114 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265268AbUAWHPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:15:18 -0500
Subject: Re: Help port swsusp to ppc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugang <hugang@soulinfo.com>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <20040122211746.3ec1018c@localhost>
References: <20040119105237.62a43f65@localhost>
	 <1074483354.10595.5.camel@gaston> <1074489645.2111.8.camel@laptop-linux>
	 <1074490463.10595.16.camel@gaston> <1074534964.2505.6.camel@laptop-linux>
	 <1074549790.10595.55.camel@gaston>  <20040122211746.3ec1018c@localhost>
Content-Type: text/plain
Message-Id: <1074841973.974.217.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 18:12:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Attached file is current version of port swsusp to ppc, STILL can not
> works, Benjamin, gave me some comments.
> 
> I has add one files swsusp2-asm.S. The save/restore processor state base
> on pmac_sleep.S. The copybackup is copy from gcc generate assmeble.
> 
> Now the suspend has no problem, resume can not works, strange.

There is at least one reason I think your code cannot work: When
resuming, you are basically blowing up the MMU hash table and kernel
page tables when copying the pages. I'm hacking on an implementation
of pmdisk at the moment that switches the MMU off during the page
copy to avoid that problem. This isn't the best way though.

I'll keep you informed of my progress

Ben.



