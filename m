Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUHEECu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUHEECu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUHEECu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:02:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267336AbUHEECM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:02:12 -0400
Date: Wed, 4 Aug 2004 20:58:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: ak@muc.de, jgarzik@pobox.com, axboe@suse.de, linux-kernel@vger.kernel.org,
       yoshfuji@linux-ipv6.org
Subject: Re: block layer sg, bsg
Message-Id: <20040804205837.6fda9a50.davem@redhat.com>
In-Reply-To: <20040804.165113.06226042.yoshfuji@linux-ipv6.org>
References: <20040804191850.GA19224@havoc.gtf.org>
	<20040804122254.3d52c2d4.davem@redhat.com>
	<20040804232116.GA30152@muc.de>
	<20040804.165113.06226042.yoshfuji@linux-ipv6.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2004 16:51:13 -0700 (PDT)
YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org> wrote:

> > Well, 32bit ipsec on x86-64/ia64 is a NOP because of that.
> 
> Hmm, I don't get the point.
> What part (or which structore) is broken?

On x86-64 and ia64 they have a large issue because the ia32
emulation layer has to handle the fact that "long long" types
do not require 8-byte alignment, whereas 64-bit natively
they do.

So all things going over netlink that use u64 or similar have
potential structure layout issues due to this difference.
