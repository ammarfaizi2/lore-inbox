Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTKWU5K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 15:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTKWU5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 15:57:10 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:37604 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263466AbTKWU5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 15:57:08 -0500
Date: Sun, 23 Nov 2003 15:56:35 -0500
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: modular IDE in 2.4.23
Message-ID: <20031123205635.GA20672@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0311231502530.1292-100000@logos.cnet> <200311232123.06635.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311232123.06635.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Uh. Oh. 2.4.23 IDE changes are obscure...  Modular IDE breakage is caused by
> Alan's hotplug changes and is not easy to fix properly.

The fixing is simply a matter of linkage ordering and function execution. 

Simple thought experiment

	Merge ide-probe into ide-core
	Export a symbol for the second initializer function if used modular
	Create a mini module that just invokes the exported function on init

You now have the same execution sequence but with the link problem removed.

> I would like to have these changes removed:
> (a) they break modular IDE
> (b) such changes should be first added to 2.6 and then backported to 2.4
>    (otherwise you are magically creating regression in 2.6)

Its not my fault the 2.6 code is lagging badly, and I wrote the code
because people using laptops, and people using ATA and SATA for business
expect basic functionality like hotplug to work. For most of them 2.6 doesn't
really matter and won't for another 6 months, but 2.4 matters right now.

The cmd640 stuff is the only hard to fix bit, and its unrelated to the
modular IDE stuff.

