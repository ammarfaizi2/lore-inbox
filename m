Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUHWR4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUHWR4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUHWR4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:56:40 -0400
Received: from [82.154.233.158] ([82.154.233.158]:33920 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S266249AbUHWR4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:56:21 -0400
Message-ID: <412A2FC5.8090402@vgertech.com>
Date: Mon, 23 Aug 2004 18:56:21 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040528 Thunderbird/0.6 Mnenhy/0.6.0.103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
Cc: "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       master@sectorb.msk.ru, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
 to become free. Usage count = 1
References: <E1BynUy-0007t1-00@gondolin.me.apana.org.au> <4128941D.9030000@trash.net>
In-Reply-To: <4128941D.9030000@trash.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patrick McHardy wrote:
| Herbert Xu wrote:
|
|> Nuno Silva <nuno.silva@vgertech.com> wrote:
|>
|>
|>> The problem is in the QoS code. If I start ppp whithout the
|>
|>
|> OK, this appears to be due to the changeset titled
|>
|> [PKT_SCHED]: Refcount qdisc->dev for __qdisc_destroy rcu-callback
|>
|> It adds a reference to dev.
|>
|> I don't see any code that cleans up that reference when the dev goes
|> down.  So someone needs to add that similar to the code in
|> net/core/dst.c.
|>
|> Patrick, could you please have a look at this?
|>
|>
| The reference is dropped in __qdisc_destroy. The problem lies in the CBQ
| qdisc, it doesn't destroy the root-class and leaks the inner qdisc. These
| two patches for 2.4 and 2.6 fix the problem.

Hi!

Just to give some feedback: IT WORKS! Thanks!

Didn't try with 2.4, but it works very well with 2.6.8.1.
Thanks again,
Nuno Silva

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKi/FOPig54MP17wRAiYBAJ41ZGzauhY6dDVtylWkLSD3V+vx9QCgteNF
21sEmv0wqP+9hdnXEc4DNBE=
=ByPY
-----END PGP SIGNATURE-----
