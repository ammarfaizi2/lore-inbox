Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265140AbTLFMgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 07:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTLFMgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 07:36:32 -0500
Received: from holomorphy.com ([199.26.172.102]:29910 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265140AbTLFMg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 07:36:29 -0500
Date: Sat, 6 Dec 2003 04:36:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Numaq in 2.4 and 2.6
Message-ID: <20031206123622.GQ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	linux-kernel@vger.kernel.org
References: <3FD1A54F.101@kolumbus.fi> <20031206112348.GP8039@holomorphy.com> <3FD1C94C.1020104@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD1C94C.1020104@kolumbus.fi>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 02:19:24PM +0200, Mika Penttil? wrote:
> Ok...the only thing that still confuses is the apicid to actually used 
> to start the cpu. In NUMA-Q case we don't program the LDRs in either 2.4 
> or 2.6, the bios does this. So the NMI IPI must have the same 
> destinations in both 2.4 and 2.6 in order to lauch the same cpus.

On Sat, Dec 06, 2003 at 02:19:24PM +0200, Mika Penttil? wrote:
> In 2.4, the mpc_apicids are used as such as NMI IPI destinations. In 
> 2.6, the mangled ones (by generate_logical_apicid()) are used as NMI IPI 
> destinations. If the mpc_apicid is already in sort of (cluster, cpu) 
> format (and used in 2.4 NMI IPI), it can't be the same after mangling?

The mangled physical APIC ID used as an index into phys_cpu_present_map
happens to determine the clustered hierarchical logical APIC ID, and so
wakeup_secondary_cpu() (switched via #ifdef) gets the right number.
There is a correspondence between (node, physical APIC ID) pairs and
logical APIC ID's that's part of the BIOS's bootstrap protocol. The
calculations you're looking at are based on that, and the logical APIC
ID's are encoded in that paired format by the BIOS, and in the mangled
format as indices into phys_cpu_present_map.

Both 2.4 and 2.6 use cpu_present_to_apicid() to do that translation on
the fly given an index into phys_cpu_present_map().


-- wli
