Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265986AbUG0OSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265986AbUG0OSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbUG0OSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:18:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:43230 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265986AbUG0OQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:16:31 -0400
Date: Tue, 27 Jul 2004 16:16:28 +0200
From: Andi Kleen <ak@suse.de>
To: colpatch@us.ibm.com
Cc: jbarnes@sgi.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       lse-tech@lists.sourceforge.net
Subject: Re: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Message-Id: <20040727161628.56a03aec.ak@suse.de>
In-Reply-To: <1090887007.16676.18.camel@arrakis>
References: <1090887007.16676.18.camel@arrakis>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004 17:10:08 -0700
Matthew Dobson <colpatch@us.ibm.com> wrote:

> So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
> a more generally useful function than pcibus_to_cpumask().  If anyone
> disagrees with that, now would be a good time to let us know.

Not sure that is a good idea. Sometimes this information is not available.
With pcibus_to_cpumask() the fallback is obvious, but it isn't with
pcibus_to_node(). Returning a random node is wrong.


> This is just a preliminary patch.  It needs review for x86_64, as I
> don't know how to properly populate the mp_bus_to_node (which used to be
> mp_bus_to_cpumask) array.

It's impossible currently - I need an ACPI 3.0 BIOS to get this information.
Even then there will be machines who don't supply it.

I tried some time ago to get it from the hardware, but the hardware registers
were arcane enough that I didn't find it easy enough. Relying on firmware
for this thing is probably a better idea anyways.

-Andi

