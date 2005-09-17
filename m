Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVIQMSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVIQMSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVIQMSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:18:37 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32654 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751087AbVIQMSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:18:36 -0400
Date: Sat, 17 Sep 2005 14:18:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Harald Welte <laforge@netfilter.org>
cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Netdev List <netdev@vger.kernel.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [HELP] netfilter Kconfig dependency nightmare
In-Reply-To: <20050917112949.GZ8413@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.61.0509171407460.3743@scrub.home>
References: <20050916021451.3012196c.akpm@osdl.org>
 <20050916191959.GN8413@sunbeam.de.gnumonks.org> <39e6f6c705091617514457eded@mail.gmail.com>
 <20050917012315.GA29841@mandriva.com> <20050917080714.GV8413@sunbeam.de.gnumonks.org>
 <Pine.LNX.4.61.0509171306290.3743@scrub.home> <20050917112949.GZ8413@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 17 Sep 2005, Harald Welte wrote:

> If CONFIG_IP_NF_CONNTRACK_NETLINK is selected (M or Y), then
> CONFIG_IP_NF_CONNTRACK conditionally adds some code that references
> symbols from nfnetlink.ko (CONFIG_NETFILTER_NETLINK)
> 
> So basically, enabling CONFIG_IP_NF_CONNTRACK_NETLINK creates a dependency
> from CONFIG_IP_NF_CONNTRACK to CONFIG_NETFILTER_NETLINK.  AFAIK, the syntax
> doesn't allow somthing like 
> 
> tristate IP_NF_CONNTRACK
> 	depends on NETFILTER_NETLINK if IP_NF_CONNTRACK_NETLINK!=n

Since IP_NF_CONNTRACK_NETLINK is the one creating the dependency, 
something like this should work:

config IP_NF_CONNTRACK_NETLINK
	depends on IP_NF_CONNTRACK && NETFILTER_NETLINK
	depends on IP_NF_CONNTRACK!=y || NETFILTER_NETLINK!=m

IOW ct_nl depends on (ct && nl) unless (ct=y && nl=m).

bye, Roman

