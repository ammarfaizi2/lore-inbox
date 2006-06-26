Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933084AbWFZWOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbWFZWOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbWFZWOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:14:03 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:12713 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S933084AbWFZWOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:14:01 -0400
Message-ID: <44A05BFD.6030402@candelatech.com>
Date: Mon, 26 Jun 2006 15:13:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Herbert Poetzl <herbert@13thfloor.at>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain>	<20060609210625.144158000@localhost.localdomain>	<20060626134711.A28729@castle.nmd.msu.ru>	<449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru>	<44A00215.2040608@fr.ibm.com>	<m1hd27uaxw.fsf@ebiederm.dsl.xmission.com>	<20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1u067r9qk.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> Basically it is just a matter of:
> if (dest_mac == my_mac1) it is for device 1.
> If (dest_mac == my_mac2) it is for device 2.
> etc.
> 
> At a small count of macs it is trivial to understand it will go
> fast for a larger count of macs it only works with a good data
> structure.  We don't hit any extra cache lines of the packet,
> and the above test can be collapsed with other routing lookup tests.

I think you should do this at the layer-2 level, well before you get
to routing.  That will make the virtual mac-vlan work with arbitrary
protocols and appear very much like a regular ethernet interface.  This
approach worked well with .1q vlans, and with my version of the mac-vlan
module.

Using the mac-vlan and source-based routing tables, I can give a unique
'interface' to each process and have each process able to bind to the
same IP port, for instance.  Using source-based routing (by binding to a local
IP explicitly and adding a route table for that source IP), I can give unique
default routes to each interface as well.  Since we cannot have more than 256
routing tables, this approach is currently limitted to around 250 virtual
interfaces, but that is still a substantial amount.

My mac-vlan patch, redirect-device patch, and other hackings are consolidated
in this patch:

http://www.candelatech.com/oss/candela_2.6.16.patch

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

