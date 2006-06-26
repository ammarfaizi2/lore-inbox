Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWFZWzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWFZWzn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWFZWyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:54:47 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:10456 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751287AbWFZWym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:54:42 -0400
Date: Tue, 27 Jun 2006 00:54:40 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Ben Greear <greearb@candelatech.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
Message-ID: <20060626225440.GA7425@MAIL.13thfloor.at>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Lezcano <dlezcano@fr.ibm.com>,
	Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
	clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
	devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
	Alexey Kuznetsov <alexey@sw.ru>
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <m1hd27uaxw.fsf@ebiederm.dsl.xmission.com> <20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com> <44A05BFD.6030402@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A05BFD.6030402@candelatech.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 03:13:17PM -0700, Ben Greear wrote:
> Eric W. Biederman wrote:
> 
> >Basically it is just a matter of:
> >if (dest_mac == my_mac1) it is for device 1.
> >If (dest_mac == my_mac2) it is for device 2.
> >etc.
> >
> >At a small count of macs it is trivial to understand it will go
> >fast for a larger count of macs it only works with a good data
> >structure.  We don't hit any extra cache lines of the packet,
> >and the above test can be collapsed with other routing lookup tests.
> 
> I think you should do this at the layer-2 level, well before you get
> to routing. That will make the virtual mac-vlan work with arbitrary
> protocols and appear very much like a regular ethernet interface.
> This approach worked well with .1q vlans, and with my version of the
> mac-vlan module.

yes, that sounds good to me, any numbers how that
affects networking in general (performance wise and
memory wise, i.e. caches and hashes) ...

> Using the mac-vlan and source-based routing tables, I can give a
> unique 'interface' to each process and have each process able to bind
> to the same IP port, for instance. Using source-based routing (by
> binding to a local IP explicitly and adding a route table for that
> source IP), I can give unique default routes to each interface as
> well. Since we cannot have more than 256 routing tables, this approach
> is currently limitted to around 250 virtual interfaces, but that is
> still a substantial amount.

an typically that would be sufficient IMHO, but
of course, a more 'general' hash tag would be
better in the long run ...

> My mac-vlan patch, redirect-device patch, and other hackings are
> consolidated in this patch:
> 
> http://www.candelatech.com/oss/candela_2.6.16.patch

great! thanks!

best,
Herbert

> Thanks,
> Ben
> 
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
