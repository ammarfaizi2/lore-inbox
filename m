Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268027AbTAIUhN>; Thu, 9 Jan 2003 15:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTAIUhM>; Thu, 9 Jan 2003 15:37:12 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:4481 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S268027AbTAIUhK>; Thu, 9 Jan 2003 15:37:10 -0500
Message-Id: <5.1.0.14.2.20030109124152.07a18e28@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 09 Jan 2003 12:45:37 -0800
To: "David S. Miller" <davem@redhat.com>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030107.012139.34126482.davem@redhat.com>
References: <Pine.LNX.4.33.0212252340090.1270-100000@champ.qualcomm.com>
 <Pine.LNX.4.33.0212252340090.1270-100000@champ.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:21 AM 1/7/2003 -0800, David S. Miller wrote:

>Change is buggy, there are many places that sk_alloc() but don't use
>sock_init_data().  net/ipv4/tcp_minisocks.c is one of many such
>places.
Those guys will have to bump mod refcount themselves then.
sock_init_data() and sock_graft() have access to ->owner field but sk_alloc()
doesn't. So we either have to change sk_alloc() API or make call to
sock_init_data()/sock_graft() a must. Any other suggestions ?

Max

