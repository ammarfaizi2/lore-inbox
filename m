Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272226AbTGYRI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272228AbTGYRI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:08:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:64694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272226AbTGYRI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:08:57 -0400
Date: Fri, 25 Jul 2003 10:20:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, ecki-lkm@lina.inka.de,
       linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
Message-Id: <20030725102043.724f4a3b.rddunlap@osdl.org>
In-Reply-To: <200307251223.51849.jeffpc@optonline.net>
References: <E19fqMF-0007me-00@calista.inka.de>
	<200307250654.h6P6s9j05200@Port.imtp.ilyichevsk.odessa.ua>
	<200307251223.51849.jeffpc@optonline.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 12:23:37 -0400 Jeff Sipek <jeffpc@optonline.net> wrote:

| -----BEGIN PGP SIGNED MESSAGE-----
| Hash: SHA1
| 
| On Friday 25 July 2003 03:03, Denis Vlasenko wrote:
| > I sample the data every minute. Will need to do it much more often
| > on 10ge ifaces, when those will appear at my home ;)
| 
| Speed			Time for one overflow
| 
| 10Gbits/s	=> 3.436 seconds
| 1Gbit/s		=> 34.36 seconds
| 100Mbits/s	=> 343.6 seconds
| 
| > Or we will need 64bit counters then.
| 
| For anything up to (and including) 1GBit/s it is possible to do in easily in 
| userspace, but then were are getting into an area where a program would have 
| to check the files every 3 seconds (and a bit of load could delay it long 
| enough for an overflow to happen.)

Yes, a common solution for this is to use some SNMP agent that does
64-bit counter accumulation.

IETF expects that some high-speed interfaces will have 64-bit
counters.  From RFC 2233 (Interfaces Group MIB using SMIv2):

<quote>
For interfaces that operate at 20,000,000 (20 million) bits per
second or less, 32-bit byte and packet counters MUST be used.
For interfaces that operate faster than 20,000,000 bits/second,
and slower than 650,000,000 bits/second, 32-bit packet counters
MUST be used and 64-bit octet counters MUST be used. For
interfaces that operate at 650,000,000 bits/second or faster,
64-bit packet counters AND 64-bit octet counters MUST be used.
</quote>

However, this is a MIB spec.  It does not require a Linux
(/proc) interface to support 64-bit counters.

--
~Randy
