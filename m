Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293183AbSBQQoc>; Sun, 17 Feb 2002 11:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293184AbSBQQoW>; Sun, 17 Feb 2002 11:44:22 -0500
Received: from coruscant.franken.de ([193.174.159.226]:38634 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S293183AbSBQQoN>; Sun, 17 Feb 2002 11:44:13 -0500
Date: Sun, 17 Feb 2002 17:34:43 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Kilobug <kilobug@freesurf.fr>
Cc: netfilter@lists.samba.org, netfilter-devel@lists.samba.org,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.18-pre9-mjc2 breaks some netfilter modules
Message-ID: <20020217173443.H28092@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Kilobug <kilobug@freesurf.fr>, netfilter@lists.samba.org,
	netfilter-devel@lists.samba.org, lkm <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6F946F.6030207@freesurf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3C6F946F.6030207@freesurf.fr>; from kilobug@freesurf.fr on Sun, Feb 17, 2002 at 12:30:55PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Prickle-Prickle, the 44th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2002 at 12:30:55PM +0100, Kilobug wrote:
> Hello,
> 	I've upgraded from 2.4.18-pre3-mjc3 to 2.4.18-pre9-mjc2 and the following 
> netfilter modules are now broken:
> 
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18-pre9-mjc2-kb1/kernel/net/ipv4/netfilter/ipt_owner.o
> depmod:         pidhash_bits
> depmod:         pidhash_size

I don't know what happend with regard to this.  The owner match module
compiles on my system without any problems on all kernels up to 2.4.18-rc1.

I assume that the 'mjc2' patches change something with regard to the pid 
hash, thus breaking the netfilter module.  Whoever makes this change should
take care of modifying the ipt_owner module.

Since the change is not in the unpatched mainstream kernel, I'm not 
concerned about this.

> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.18-pre9-mjc2-kb1/kernel/net/ipv4/netfilter/ipt_time.o
> depmod:         get_fast_time
> make: *** [_modinst_post] Erreur 1

This is a recent change in the 2.4.18 kernel, removing get_fast_time and
using do_gettimeofday instead.

The time match from iptables-1.2.5 still used the old get_fast_time() function
and needs to be updated.  the time match is a contributed patch from 
Fabrice MARIE <fabrice@celestix.com>, so please ask him to update his patch
to work with recent kernel versions.

> Hoping this can help you,

Thanks for reporting this to us.

> ** Gael Le Mignot "Kilobug", Ing3 EPITA - http://kilobug.free.fr **

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
