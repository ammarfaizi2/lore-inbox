Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbTEPXDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTEPXDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:03:20 -0400
Received: from gw.enyo.de ([212.9.189.178]:39441 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261383AbTEPXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:03:19 -0400
To: Simon Kirby <sim@netnation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Route cache performance under stress
References: <8765pshpd4.fsf@deneb.enyo.de>
	<20030516222436.GA6620@netnation.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Simon Kirby <sim@netnation.org>,
 linux-kernel@vger.kernel.org
Date: Sat, 17 May 2003 01:16:08 +0200
In-Reply-To: <20030516222436.GA6620@netnation.com> (Simon Kirby's message of
 "Fri, 16 May 2003 15:24:36 -0700")
Message-ID: <8765oaxz2f.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@netnation.org> writes:

> I hate the way this works in iptables), particularly with the MSSQL
> worm that burst out to the 'net that one Friday night several few
> months ago.  Adding a single match udp port, DROP rule to PREROUTING
> chain made the load go back down to normal levels.  The same rule in
> the INPUT/FORWARD chain had no affect on the CPU utilization (still
> saturated).

Yes, that's exactly the phenomenon, but operators traditionally
attributed it to other things running on the router (such as
accounting).

> Under normal operation, it looks like most load we are seeing is in fact
> normal route lookups.  We run BGP peering, and so there is a lot of
> routes in the table.

You should aggregate the routes before you load them into the kernel.
Hardly anybody seems to do this, but usually, you have much fewer
interfaces than prefixes 8-), so this could result in a huge win.

Anyway, using data structures tailored to the current Internet routing
table, it's certainly possible to do destination-only routing using
half a dozen memory lookups or so (or a few indirect calls, I'm not
sure which option is cheaper).

> I will try playing more with this code and look at your patch and paper.

Well, I didn't write the paper, I found it after discovering the
problem in the kernel.  This complexity attack has been resolved, but
this won't help people like you who have to run Linux on an
uncooperative network.

The patch I posted won't help you as it increases the load
considerably unless most of your flows consist of one packet.  (And
there's no need for patching, you can go ahead and just change the
value via /proc.)
