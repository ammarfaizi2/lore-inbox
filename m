Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVF3ONx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVF3ONx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVF3ONx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:13:53 -0400
Received: from mxout03.versatel.de ([212.7.152.117]:4559 "EHLO
	mxout03.versatel.de") by vger.kernel.org with ESMTP id S262967AbVF3ONV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:13:21 -0400
Message-ID: <42C3FDE5.4080808@web.de>
Date: Thu, 30 Jun 2005 16:12:53 +0200
From: Christian Trefzer <ctrefzer@web.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050617)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: "Darryl L. Miles" <darryl@netbauds.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 initrd module loading seems parallel on bootup
References: <42BDFEC2.3030004@netbauds.net> <20050625234611.118b391d.akpm@osdl.org> <42BE7E38.9070703@netbauds.net> <42BE98C5.1070102@web.de> <20050626141106.GA12223@shuttle.vanvergehaald.nl> <42BF92D4.3040609@netbauds.net> <42C33149.3090305@web.de> <42C3B11B.80909@netbauds.net>
In-Reply-To: <42C3B11B.80909@netbauds.net>
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=6B99E3A5
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD51FBA3ED1C8A92343633FA0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD51FBA3ED1C8A92343633FA0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Darryl L. Miles schrieb:
> 
> The exact patch for kernel/module.c that was marked for 2.6.11-rcX hit 
> general release in patch-2.6.12.
That explains a lot. Thanks for clarification : )

> What $PID is bash running as ?  Martin's comments on this are seem most 
> relevant.
The initramfs contains /init which is a shell script, while /bin/sh is 
bash. So I figure bash is running with PID 1, but I'll verify that by 
adding echo $$ to the init script.

> Can you build your own (2 pages of code) init process, that does 
> something along the lines of
> * gracefully handles SIGCHLD
> * forks
> * executes bash
> * waits for bash to exit much like the patch does
> 
> So bash is not running a pid 1.  While nash is expected to run as init, 
> bash is not, so fixing bash might also break it (its a complex beast).
> 
I'm not (yet) too much into C programming, so I'm afraid I won't be able 
to do that. As this problem arises only due to my own early-userspace 
setup, I'd rather try using different shells for init-as-shell-script, 
and maybe do some not-so-clean hacks to get the bigger picture.

As this is not a kernel issue, I'd rather take this one off LKML and 
write a success report once appropriate.

Thanks for your help to everyone involved : )


--------------enigD51FBA3ED1C8A92343633FA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsP9512m8MprmeOlAQLWYw//e0MBupeRp74F2W05f1xdaASYFjek5KV1
5Sg33YZpLPso9ZLxoTx7KaP3PUzimSkmk+G8JiAVhvoFFRJ1FUC4qdyTaDFsCA8U
bFz/iIw+BnwDsfXeh8f+UHmRm6uEN3FA/Hbpyyeqkdso+iyvmdMG/5w6FkFOAtl8
UjA+D40eg4jUYZuUW8bWx6TI/36OsoFI6hualZoFzSNerEglklgivIDCqRxRyL/4
Z40fCqIk1TZXpjTiMZRXfB7jssPStYQ6GSqUdVCey5PWIN+Q7yn3Gfopzue2V5dH
HaNlS23XM8S9CExu7BAx1bfbyj5TDgvdZaQkdC7TcmGLgOMly3dVz6pojuZUuEaV
zN0ec/w2o1sZuvNwSSfDnf1QzEdbGRZIm8eEKwGXeGejCN9QZJgCsLy8Gvd63Ikn
YLAizJpqLiwuO1vTYWRE6zK2QdLli4IRZC4gUZkCoTS4cZS7RPRVLtXVSGo6ThEE
IMlJVr6AXsIyUDXShl8RDT1g4ypPT0CfWhzohR2I5Vp2ZtaBKLQSg3qkVeLcC2v2
Kwhd+Qd2vUGg2wzCg0KQxN33K5u+Pa/THUjp62Q1UwXudAInfo/v1QIk7u1FSNm5
NbZU7R5b50cuefwmB/vkmatiLj0hod0SNq0+xqaEu9P+sEJso9vCRb7hIpjLQp9R
8zvZQ45Fwo8=
=BeZD
-----END PGP SIGNATURE-----

--------------enigD51FBA3ED1C8A92343633FA0--
