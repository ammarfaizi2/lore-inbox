Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264631AbUDVSj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264631AbUDVSj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbUDVSj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:39:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48106 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264631AbUDVSj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:39:26 -0400
Date: Thu, 22 Apr 2004 11:28:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: root@chaos.analogic.com
Cc: pochini@shiny.it, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       cfriesen@nortelnetworks.com, joern@wohnheim.fh-wedel.de
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-Id: <20040422112801.2a1a4a57.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.53.0404220734330.8039@chaos>
References: <XFMail.20040422102359.pochini@shiny.it>
	<Pine.LNX.4.53.0404220734330.8039@chaos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004 07:35:54 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> Has anybody checked to see what Linux does if it receives a
> RST to the broadcast address? It would be a shame if all
> connections were dropped!

int tcp_v4_rcv(struct sk_buff *skb)
{
 ...
	if (skb->pkt_type != PACKET_HOST)
		goto discard_it;

Packets which are multicast or broadcast do not get marked
as "PACKET_HOST".
