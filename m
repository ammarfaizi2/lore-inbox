Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265746AbUFIMTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265746AbUFIMTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUFIMTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:19:54 -0400
Received: from [213.91.247.3] ([213.91.247.3]:35848 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S265742AbUFIMTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:19:50 -0400
Date: Wed, 9 Jun 2004 15:18:12 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@l
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: netdev@oss.sgi.com, <linux-net@vger.kernel.org>, <davem@redhat.com>,
       <yoshfuji@linux-ipv6.org>, <pekkas@netcore.fi>, <jmorris@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: UDP sockets bound to ANY send answers with wrong src ip address
In-Reply-To: <200406091425.39324.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0406091511350.6279-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Wed, 9 Jun 2004, Denis Vlasenko wrote:

> I observe that UDP sockets listening on ANY
> send response packets with ip addr derived from
> ip address of interface which is used to send 'em
> instead of using dst ip address of client's packet.
>
> I was bitten by this with DNS and NTP.

	The problem is in the apps. You have some options:

- use sockets listening on ANY and using sendmsg with IP_PKTINFO
and providing the desired src IP in ipi_spec_dst

- you can also create many listener sockets listening on
particular src IP and to reply using the socket where the
request is received, because the kernel does not know any
association between request and reply packets if the listener
is bound to ANY.

Regards

--
Julian Anastasov <ja@ssi.bg>

