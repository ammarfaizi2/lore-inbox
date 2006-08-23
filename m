Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964974AbWHWPWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964974AbWHWPWK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWHWPWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:22:10 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:39911 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964974AbWHWPWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:22:08 -0400
Date: Wed, 23 Aug 2006 11:22:06 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: gerrit@erg.abdn.ac.uk
cc: davem@davemloft.net, alan@lxorguk.ukuu.org.uk, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, kaber@coreworks.de, yoshfuji@linux-ipv6.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/3] net/ipv4: UDP-Lite extensions
In-Reply-To: <200608231603.08240@strip-the-willow>
Message-ID: <Pine.LNX.4.64.0608231112530.3870@d.namei>
References: <200608231150.42039@strip-the-willow> <Pine.LNX.4.64.0608231019010.3198@d.namei>
 <200608231603.08240@strip-the-willow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006, gerrit@erg.abdn.ac.uk wrote:

> |  Other protocols & network components call panic() if they fail during boot 
> |  initialization.  Not sure if this is a great thing, but it raises the 
> |  issue of whether udp-lite should remain consistent here.
> 
> The behaviour is consistent (modulo loglevel) with inet_init()
> of net/ipv4/af_inet.c:

Some things will panic there, just deeper in the call chain.

> >From that I could not deduct a rule what would happen if UDP-Lite failed
> to register. If control had reached that above point, it means that all
> other protocols have already successfully registered -- if then UDP-Lite
> could not register and called a panic(), it would abort the remainder of the
> stack. 

Other functions can also panic on failure after this, e.g. tcp_init().

I think ideally it'd be best if components did not panic during 
initialization unless it _really_ meant that the kernel should not 
continue executing.  Although, it's not entirely clear how to determine 
this, e.g. perhaps the system should panic if netfilter initialization 
failed, as it might mean that the systems comes up without a firewall. But 
how do we know precisely which components are being used for security 
critical purposes?

It seems like a signifcant overhaul of existing code, so probably best 
just to leave yours as-is (which I suspect is the correct behavior 
anyway).



- James
-- 
James Morris
<jmorris@namei.org>
