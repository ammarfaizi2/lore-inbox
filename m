Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287532AbSBOHyP>; Fri, 15 Feb 2002 02:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287545AbSBOHyJ>; Fri, 15 Feb 2002 02:54:09 -0500
Received: from coruscant.franken.de ([193.174.159.226]:32188 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S287532AbSBOHxu>; Fri, 15 Feb 2002 02:53:50 -0500
Date: Fri, 15 Feb 2002 08:43:13 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Ulrich Mohr <ue2m@rz.uni-karlsruhe.de>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@redhat.com>,
        Netfilter Development Mailinglist 
	<netfilter-devel@lists.samba.org>,
        netdev@oss.sgi.com
Subject: Re: PROBLEM: Netfilter inconsistency?
Message-ID: <20020215084313.Y28092@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Ulrich Mohr <ue2m@rz.uni-karlsruhe.de>,
	linux-kernel@vger.kernel.org, David Miller <davem@redhat.com>,
	Netfilter Development Mailinglist <netfilter-devel@lists.samba.org>,
	netdev@oss.sgi.com
In-Reply-To: <Pine.HPX.4.44.0202150031110.27588-200000@rzstud1.rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.HPX.4.44.0202150031110.27588-200000@rzstud1.rz.uni-karlsruhe.de>; from ue2m@rz.uni-karlsruhe.de on Fri, Feb 15, 2002 at 01:01:49AM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Prickle-Prickle, the 44th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 01:01:49AM +0100, Ulrich Mohr wrote:

Hi!

> When the LOCAL_OUT hook is called via ip_build_and_send_packet or
> ip_build_xmit, then ip_select_ident is called prior to the call to
> the LOCAL_OUT hook and will not change after the call to the hook.
> 
> When the LOCAL_OUT hook is called via ip_queue_xmit, then the
> ip_select_ident is called after the call to the netfilter hook, and
> the value of the id field in the ip-header changes after a reinject.
> 
[...]

> I tried to make the call to ip_select_ident before the hooks are called,
> and I did not see any side effects (the if field was set directly after
> the hook was called anyway on all execution paths, and it did not depend
> on any information which was not present prior to the hook was called).
> http, scp, ftp & icmp are working fine with this modification.

>From a netfiler point of view I don't see any problems with your approach,
and in fact it seems cleaner to have a consistent behaviour with regard
to the id field.

But since the change is not inside the netfilter code, but in the core
networking, it's up to the core networking maintainers to decide if this
patch is acceptable or might break something.
> 
> I insert the patch I did to ip_output.c on Kernel v. 2.4.10.

Please always use unified diff - it's difficult to understand your patch
just from reading it since it doesn't contain context (diff -u)

> Thank you,
> 	Uli

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
