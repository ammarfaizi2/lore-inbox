Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbUKEBPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUKEBPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUKEBLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:11:52 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:62429
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262555AbUKEBKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:10:14 -0500
Date: Thu, 4 Nov 2004 16:58:47 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: kaber@trash.net, matthias.andree@gmx.de,
       netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that
 breaks amanda dumps
Message-Id: <20041104165847.2f178d81.davem@davemloft.net>
In-Reply-To: <20041105010427.GA2770@merlin.emma.line.org>
References: <20041104121522.GA16547@merlin.emma.line.org>
	<418A7B0B.7040803@trash.net>
	<20041104231734.GA30029@merlin.emma.line.org>
	<418AC0F2.7020508@trash.net>
	<20041104160655.1c66b7ef.davem@davemloft.net>
	<20041105010427.GA2770@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Nov 2004 02:04:27 +0100
Matthias Andree <matthias.andree@gmx.de> wrote:

> On Thu, 04 Nov 2004, David S. Miller wrote:
> 
> > His patch isn't correct, even making a temporary change to
> > a shared SKB is illegal.
> 
> So the original ip_conntrack_amanda was already illegal. If only such
> nonsense caused heavy kernel logging (let it oops or GPF or whatver),
> that's a much quicker way to pinpoint the bug than run amanda with a
> special devnull configuration some dozen times.

The original ip_conntrack_amanda was correct before
my skb_header_pointer() changes.  Patrick's patch, which
I'll of course apply, simply reverted those changes back
to the original code which uses the amanda_buffer for
the UDP control stream always.
