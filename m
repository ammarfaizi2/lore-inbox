Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271449AbVBFFMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271449AbVBFFMT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 00:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271531AbVBFFMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 00:12:18 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53171
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S263815AbVBFFMI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 00:12:08 -0500
Date: Sat, 5 Feb 2005 21:04:11 -0800
From: "David S. Miller" <davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: herbert@gondor.apana.org.au, mirko.parthey@informatik.tu-chemnitz.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shemminger@osdl.org,
       yoshfuji@linux-ipv6.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-Id: <20050205210411.7e18b8e6.davem@davemloft.net>
In-Reply-To: <20050206.133723.124822665.yoshfuji@linux-ipv6.org>
References: <20050204221344.247548cb.davem@davemloft.net>
	<20050205064643.GA29758@gondor.apana.org.au>
	<20050205201044.1b95f4e8.davem@davemloft.net>
	<20050206.133723.124822665.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Feb 2005 13:37:23 +0900 (JST)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> How about making dst->ops->dev_check() like this:
> 
> static int inline dst_dev_check(struct dst_entry *dst, struct net_device *dev)
> {
> 	if (dst->ops->dev_check)
> 		return dst->ops->dev_check(dst, dev)
> 	else
> 		return dst->dev == dev;
> }

Oh I see.  That would work, and it seems the simplest, and
lowest risk fix for this problem.

Herbert, what do you think?
