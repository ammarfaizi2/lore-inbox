Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTAGJV2>; Tue, 7 Jan 2003 04:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbTAGJV1>; Tue, 7 Jan 2003 04:21:27 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19422 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267346AbTAGJV0>;
	Tue, 7 Jan 2003 04:21:26 -0500
Date: Tue, 07 Jan 2003 01:21:39 -0800 (PST)
Message-Id: <20030107.012139.34126482.davem@redhat.com>
To: maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0212252340090.1270-100000@champ.qualcomm.com>
References: <Pine.LNX.4.33.0212252340090.1270-100000@champ.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change is buggy, there are many places that sk_alloc() but don't use
sock_init_data().  net/ipv4/tcp_minisocks.c is one of many such
places.

So your patch will get the refcounting wrong in this common case.
