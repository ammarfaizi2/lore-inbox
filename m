Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136145AbRD0RnM>; Fri, 27 Apr 2001 13:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136139AbRD0RnC>; Fri, 27 Apr 2001 13:43:02 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:34558 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S136145AbRD0Rmz>; Fri, 27 Apr 2001 13:42:55 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200104271742.TAA17691@sunrise.pg.gda.pl>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Fri, 27 Apr 2001 19:42:42 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel mailing list)
In-Reply-To: <20010427115548.A16249@emma1.emma.line.org> from "Matthias Andree" at Apr 27, 2001 11:55:48 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Matthias Andree wrote:"
> On Fri, 27 Apr 2001, David S. Miller wrote:
> > Your configuration seems impossible, somehow the config system allowed
> > you to set CONFIG_IP_NF_COMPAT_IPCHAINS without setting
> > CONFIG_IP_NF_CONNTRACK.

Just quick look at net/ipv4/netfilter/Config.in explains everything:

: if [ "$CONFIG_IP_NF_CONNTRACK" != "y" ]; then
:   if [ "$CONFIG_IP_NF_IPTABLES" != "y" ]; then
:     tristate 'ipchains (2.2-style) support' CONFIG_IP_NF_COMPAT_IPCHAINS

CONFIG_IP_NF_COMPAT_IPCHAINS depends on CONFIG_IP_NF_CONNTRACK being
disabled. And it seems to be intentional...

> Now, if I set "connection tracking" to "y", the ipchains option
> disappears (make menuconfig). Are things supposed to behave this way?
> I'd like to stick to ipchains for a while, rather than switch to
> iptables. (Administrator laziness, of course.)

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
