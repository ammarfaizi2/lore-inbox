Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbUBXKXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 05:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbUBXKXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 05:23:32 -0500
Received: from ns.suse.cz ([82.208.2.84]:32014 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id S262177AbUBXKXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 05:23:30 -0500
Message-ID: <403B261D.90000@suse.cz>
Date: Tue, 24 Feb 2004 11:23:25 +0100
From: Michal Ludvig <mludvig@suse.cz>
Organization: SuSE CR, s.r.o.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: cs, cz, en
MIME-Version: 1.0
To: "Samofatov, Nickolay" <Nickolay@BroadViewSoftware.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 issues (IPSec+NAT, RFC2684 bridge)
References: <66187D861C1747499BE1365B74E036917B5F82@mdant.atkin.com>
In-Reply-To: <66187D861C1747499BE1365B74E036917B5F82@mdant.atkin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-x-mailer.co.uk-Metrics: chimera 1192; Body=3 Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samofatov, Nickolay told me that:
> Here is a list of minor issues I encountered when migrated my AMD64
> machine to 2.6.2 kernel (64-bit).
> 
> 1) Attempts to combine IPSec and NAT result in various kinds of
> failures. The easiest to reproduce is reliable hard system lock-up when
> IKE session needs to be initiated because of request from masqueraded
> machine.
> (workaround is to run cron job keeping IPSec connection active)

You probably hit the same bug as I did. When a SPD policy expires the 
notification to userspace fails. Please try the patch from here and let 
me know if it helps:
http://marc.theaimsgroup.com/?l=linux-netdev&m=107761652405761&w=2

> 2) I had to add following line to my routing rules to get IPSec working
> locally:
> --
> route add -m 172.20.0.0 netmask 255.255.0.0 gw 172.21.113.1
> --
> 172.20.0.0 here is VPN subnet I'm interested in. 172.21.113.1 is the
> address assigned to eth0 interface which is also IP address of this
> machine in VPN.
> Before I added this rule TCP connections from localhost failed with no
> route to host. The result works for most applications, but not all. For
> example, SSH fails.
> (my workaround is to use SOCKS5 proxy running locally for local SSH
> connections over IPSec tunnels)

Try to specify source address as well:
ip route add 172.20.0.0/16 via 172.21.113.1 src 172.21.x.x

> If there is interest, I may provide as much information as required to
> resolve the problems.

If the IPsec issues still remain, send me more information so that I 
could reproduce it here.

Michal Ludvig
-- 
SUSE Labs                    mludvig@suse.cz | Cray is the only computer
(+420) 296.545.373        http://www.suse.cz | that runs an endless loop
Personal homepage http://www.logix.cz/michal | in just four hours.
