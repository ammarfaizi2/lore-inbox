Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272958AbTG3QfQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 12:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272959AbTG3QfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 12:35:15 -0400
Received: from fmr04.intel.com ([143.183.121.6]:37623 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S272958AbTG3QfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 12:35:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Wed, 30 Jul 2003 09:34:51 -0700
Message-ID: <DD755978BA8283409FB0087C39132BD101B0100B@fmsmsx404.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Lse-tech] Re: [patch] scheduler fix for 1cpu/node case
Thread-Index: AcNWtfEFukBxtaNhTzaoyDHOtoU7SgAAbLXw
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andrew Theurer" <habanero@us.ibm.com>,
       "Erich Focht" <efocht@hpce.nec.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "LSE" <lse-tech@lists.sourceforge.net>
Cc: "Andi Kleen" <ak@muc.de>, <torvalds@osdl.org>
X-OriginalArrivalTime: 30 Jul 2003 16:34:51.0742 (UTC) FILETIME=[7FF7BFE0:01C356B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As for idle balances, we may be able to go a step further: 
> follow the range rules, but do a more aggressive/frequent search.

Be cautious about how much work you do here ... while you can burn
as much cpu time as you like on an idle cpu without affecting anything,
you need to be sure that your activities don't burn too much bus
bandwidth, or cause cache lines to ping-pong around the machine. The
classic case of this has been seen while one cpu is trying to boot,
and the other 31 idle cpus beat the bus to death looking to see
whether they can "help".

-Tony
