Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTILTHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTILTHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:07:21 -0400
Received: from Hell.WH8.tu-dresden.de ([141.30.225.3]:60043 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S261853AbTILTHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:07:18 -0400
Date: Fri, 12 Sep 2003 21:07:16 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RPC kernel warning
Message-Id: <20030912210716.2a0ca4e6.us15@os.inf.tu-dresden.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="Multipart_Fri__12_Sep_2003_21_07_16_+0200_=.JqKKSENFQqGtX8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Fri__12_Sep_2003_21_07_16_+0200_=.JqKKSENFQqGtX8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


Hi,

Linux 2.6.0-test5 is reporting a lot of the following messages in dmesg on
one of the machines here:

RPC svc_write_space: some sleeping on f6ce8900

It is triggered by the following code in svcsock.c

static void
svc_write_space(struct sock *sk)
{
        struct svc_sock *svsk = (struct svc_sock *)(sk->sk_user_data);

        if (svsk) {
                dprintk("svc: socket %p(inet %p), write_space busy=%d\n",
                        svsk, sk, test_bit(SK_BUSY, &svsk->sk_flags));
                svc_sock_enqueue(svsk);
        }
  
        if (sk->sk_sleep && waitqueue_active(sk->sk_sleep)) {
                printk(KERN_WARNING "RPC svc_write_space: some sleeping on %p\n",
                       svsk);                                                    
                wake_up_interruptible(sk->sk_sleep);
        }
}

Can someone explain what the warning is about?

-Udo.

--Multipart_Fri__12_Sep_2003_21_07_16_+0200_=.JqKKSENFQqGtX8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/YhlknhRzXSM7nSkRAo+8AJ9gjx/BqPTAqOntJdIJfCtj5+OTkwCeLfSS
jU8FotfuimnSSlm7BRhW67Q=
=0IqX
-----END PGP SIGNATURE-----

--Multipart_Fri__12_Sep_2003_21_07_16_+0200_=.JqKKSENFQqGtX8--
