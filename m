Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJNSDI>; Mon, 14 Oct 2002 14:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262081AbSJNSDI>; Mon, 14 Oct 2002 14:03:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61595 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262067AbSJNSDH>;
	Mon, 14 Oct 2002 14:03:07 -0400
Date: Mon, 14 Oct 2002 11:01:59 -0700 (PDT)
Message-Id: <20021014.110159.15420052.davem@redhat.com>
To: bart.de.schuymer@pandora.be
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org
Subject: Re: [RFC] bridge-nf -- map IPv4 hooks onto bridge hooks, vs 2.5.42
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210142005.06292.bart.de.schuymer@pandora.be>
References: <20020911.153132.63843642.davem@redhat.com>
	<200209120836.52062.bart.de.schuymer@pandora.be>
	<200210142005.06292.bart.de.schuymer@pandora.be>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These changes cannot go in:

1) There is no reason the 'okfn' you use cannot be the
   function doing the MAC header copy.

   This is how this is supposed to work.

   I explained in that long thread a few weeks ago how
   this copy may not be placed in the generic IP code.
   This is final, you must find a way to make this copy
   without touching ipv4/*.c

2) The netfilter changes need to be approved by the netfilter
   team.

   I suspect, like myself, they will barf at the phys{in,out}dev
   additions to sk_buff.  We already have enough junk sitting
   in sk_buff making it larger than it needs to be.

   Perhaps you can hang this off the nf_conntrack pointer and
   specify a destructor.

3) The bridging layer changes need to be approved by Lennert.
   But I'd suggest working out #1 and #2 first.

Thanks.
