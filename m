Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTIDQxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 12:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbTIDQxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 12:53:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57519 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265279AbTIDQxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 12:53:10 -0400
Date: Thu, 4 Sep 2003 09:43:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: geert@linux-m68k.org, paulus@samba.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-Id: <20030904094328.59961739.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
References: <Pine.GSO.4.21.0309041420460.8244-100000@waterleaf.sonytel.be>
	<Pine.LNX.4.44.0309040935040.1665-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003 09:41:37 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> No, I don't agree. The "iomem_resource" is there for all IO-mapped ranges, 
> and it could easily be a mixture of PCI and other buses. In fact, it 
> already is on bog-standard hardware: it contains the AGP windows etc.

Sure, but this model falls apart for things like I/O ports
and any other device access entity where one needs to use
special accessors to access stuff.

> So clearly ioremap() has to work for other buses too.

What if they are like I/O ports on x86 and require special
instructions to access?

> I think that in the 2.7.x timeframe, the right thing to do is definitely:
>  - move towards using "struct resource" and "ioremap_resource()"
>  - make resource sizes potentially be larger (ie use "u64" instead of 
>    "unsigned long")

Agreed.
