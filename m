Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTLCFDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 00:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbTLCFDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 00:03:53 -0500
Received: from rth.ninka.net ([216.101.162.244]:11904 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264499AbTLCFDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 00:03:53 -0500
Date: Tue, 2 Dec 2003 21:03:37 -0800
From: "David S. Miller" <davem@redhat.com>
To: Stephen Lee <mukansai@emailplus.org>
Cc: laforge@netfilter.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: Extremely slow network with e1000 & ip_conntrack
Message-Id: <20031202210337.5dda502f.davem@redhat.com>
In-Reply-To: <20031202204404.9ADD.MUKANSAI@emailplus.org>
References: <20031130074532.0105.MUKANSAI@emailplus.org>
	<20031130155236.GJ26749@obroa-skai.de.gnumonks.org>
	<20031202204404.9ADD.MUKANSAI@emailplus.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Dec 2003 20:44:06 +0900
Stephen Lee <mukansai@emailplus.org> wrote:

> After lots of trial-and-error, I can make the problem disappear by
> backing these 4 files out from 2.5.44 to their 2.5.43 versions.
> 
> net/ipv4/icmp.c
> net/ipv4/ip_output.c
> net/ipv4/raw.c
> net/ipv4/udp.c

Interesting, but not very.  This essentially backs out the whole
ipv4 packet sending engine rewrite we did to support IPSEC and
UDP sendfile support.

Ie. it's a lot of large interrelated changes.  We know now what
introduced the problem, but this hasn't really narrowed it down
much.
