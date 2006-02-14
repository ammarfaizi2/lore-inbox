Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422686AbWBNRRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbWBNRRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWBNRRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:17:46 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:41749 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1422686AbWBNRRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:17:45 -0500
To: Matthew Wilcox <matthew@wil.cx>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
	<20060214165601.GM12822@parisc-linux.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Feb 2006 09:17:41 -0800
In-Reply-To: <20060214165601.GM12822@parisc-linux.org> (Matthew Wilcox's
 message of "Tue, 14 Feb 2006 09:56:01 -0700")
Message-ID: <adafymlvozu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 14 Feb 2006 17:17:42.0033 (UTC) FILETIME=[90268810:01C6318A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Going a bit overboard on the type safety.  Please, leave bus_flags as an
 > unsigned short so as not to bloat the pci_bus structure unnecessarily.

Hmm:

> +typedef unsigned short __bitwise pci_bus_flags_t;

and:

> -	unsigned short  pad2;
> +	pci_bus_flags_t bus_flags;	/* Inherited by child busses */

This does make pci_bus_flags_t a short -- it just lets sparse catch
misuses of the enum values.

It's debatable whether it's worth the source obfuscation to let sparse
check this, since it seems rather unlikely that someone will screw it
up.  But I don't see how it makes any difference in the generated
code; certainly there's no bloat (beyond the extra source code)

 - R.
