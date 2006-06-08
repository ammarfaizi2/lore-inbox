Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWFHOdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWFHOdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWFHOdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:33:16 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16058 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932173AbWFHOdP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:33:15 -0400
Subject: Re: [PATCH  2.6.17-rc6-mm1 ]  net: RFC 3828-compliant UDP-Lite
	support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Cc: davem@davemloft.net, kuznet@ms2.inr.ac.ru, pekkas@netcore.fi,
       jmorris@namei.org, yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <200606081150.34018@this-message-has-been-logged>
References: <200606081150.34018@this-message-has-been-logged>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jun 2006 15:47:52 +0100
Message-Id: <1149778072.22124.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-08 am 11:50 +0100, ysgrifennodd Gerrit Renker:
> +  UDP-Lite introduces a new socket type, the SOCK_LDGRAM (note the L) for
> +  lightweight, connection-less services. These are the socket options:

This is not the intended use of the socket API when distinguishing
between services. The socket() call has a protocol field that is usually
unused and it exists precisely to disambiguate multiple protocols with
the same generic behaviour but different properties.

	s = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDPLITE);

is probably the right way to do this, keeping 0 "default" as before
meaning IPPROTO_UDP

