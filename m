Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTJIQyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTJIQyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:54:36 -0400
Received: from newsmtp.golden.net ([199.166.210.106]:26899 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S262241AbTJIQyd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:54:33 -0400
Date: Thu, 9 Oct 2003 12:54:28 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc/clnt.c compile fix
Message-ID: <20031009165428.GA12093@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20031009161350.GA9170@linux-sh.org> <shsr81mnz8i.fsf@charged.uio.no> <20031009164048.GA12029@linux-sh.org> <16261.37335.822076.188805@charged.uio.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <16261.37335.822076.188805@charged.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2003 at 12:50:31PM -0400, Trond Myklebust wrote:
> It's not a true process pid, but more of a tag on each struct
> rpc_task. It turns out to be more helpful when you are tracing the
> (d|)printk() debugging info, since a process may have several rpc_task
> in flight at any point in time.
>=20
Sounds reasonable. Does this look ok?

--- linux-sh-2.6.0-test7.orig/net/sunrpc/clnt.c	Thu Oct  9 09:42:45 2003
+++ linux-sh-2.6.0-test7/net/sunrpc/clnt.c	Thu Oct  9 12:53:05 2003
@@ -961,19 +961,19 @@
 	case RPC_SUCCESS:
 		return p;
 	case RPC_PROG_UNAVAIL:
-		printk(KERN_WARNING "RPC: %4d call_verify: program %u is unsupported by =
server %s\n",
-				task->tk_pid, (unsigned int)task->tk_client->cl_prog,
+		printk(KERN_WARNING "RPC: call_verify: program %u is unsupported by serv=
er %s\n",
+				(unsigned int)task->tk_client->cl_prog,
 				task->tk_client->cl_server);
 		goto out_eio;
 	case RPC_PROG_MISMATCH:
-		printk(KERN_WARNING "RPC: %4d call_verify: program %u, version %u unsupp=
orted by server %s\n",
-				task->tk_pid, (unsigned int)task->tk_client->cl_prog,
+		printk(KERN_WARNING "RPC: call_verify: program %u, version %u unsupporte=
d by server %s\n",
+				(unsigned int)task->tk_client->cl_prog,
 				(unsigned int)task->tk_client->cl_vers,
 				task->tk_client->cl_server);
 		goto out_eio;
 	case RPC_PROC_UNAVAIL:
-		printk(KERN_WARNING "RPC: %4d call_verify: proc %p unsupported by progra=
m %u, version %u on server %s\n",
-				task->tk_pid, task->tk_msg.rpc_proc,
+		printk(KERN_WARNING "RPC: call_verify: proc %p unsupported by program %u=
, version %u on server %s\n",
+				task->tk_msg.rpc_proc,
 				task->tk_client->cl_prog,
 				task->tk_client->cl_vers,
 				task->tk_client->cl_server);

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/hZLE1K+teJFxZ9wRAmSVAJ9SaWanaVDHcHO4d1tmL9nLdnZidgCfSH9W
Q/xTABBBoi+AUlFXyb//Lpk=
=+I7J
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
