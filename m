Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVBCBXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVBCBXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVBCBXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:23:44 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:60561
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262747AbVBCBX2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:23:28 -0500
Date: Wed, 2 Feb 2005 17:17:01 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Einar =?ISO-8859-1?Q?L=FCck?= <lkml@einar-lueck.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 1/2] ipv4 routing: splitting of
 ip_route_[in|out]put_slow, 2.6.10-rc3
Message-Id: <20050202171701.18a81a6a.davem@davemloft.net>
In-Reply-To: <41C6B3D4.6060207@einar-lueck.de>
References: <41C6B3D4.6060207@einar-lueck.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 12:13:24 +0100
Einar Lück <lkml@einar-lueck.de> wrote:

> This patch splits up ip_route_[in|out]put_slow in inlined functions.
> Basic idea:
> * improve overall comprehensibility
> * allow for an easier application of patch for improved multipath 
>   support

Patch applied to my 2.6.12 pending tree.  Thanks a lot Einar.

One minor comment is that there are some minor cases where
excessing in_dev get/put can be eliminated.  For example,
in __mkroute_output() we really only need to do the
in_dev_get(dev_out) once, yet we do it twice due to how
the return path of this function always puts the reference
even in the non-error case.
