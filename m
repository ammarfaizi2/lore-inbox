Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267661AbTAMAEK>; Sun, 12 Jan 2003 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbTAMAEJ>; Sun, 12 Jan 2003 19:04:09 -0500
Received: from pat.uio.no ([129.240.130.16]:22477 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267661AbTAMAEI>;
	Sun, 12 Jan 2003 19:04:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.1154.649765.791797@charged.uio.no>
Date: Mon, 13 Jan 2003 01:12:50 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Secure user authentication for NFS using RPCSEC_GSS [0/6]
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

 The following set of 6 patches implements support for the RPCSEC_GSS
security protocol (authentication only) and the Kerberos V5 security
mechanism.
 These patches constitute a resend (modulo some bugfixes) of a set
that was originally sent to you and the L-K list on 31/10/2002. I
received no comment on them at the time (and they were not immediately
applied), and so I've been waiting for the general hubbub after the
feature freeze to die down before.

RPCSEC_GSS is the security mechanism that is mandated for all compliant
NFSv4 implementations by RFC3010. It provides a protocol for negotiating
secure authentication and data transfers on a per-user basis. It does
so in a manner that does not depend on the actual security mechanism
that is used, and so can support a variety of such mechanisms. The
mechanisms that are mandated for NFSv4 by RFC3010 are Kerberos V5 (see
RFC1964), SPKM-3 (RFC2025), and LIPKEY (RFC2847).

The actual security negotiation can be done out of band, so it makes
sense to delegate as much of this as possible to a userland
daemon. The result of negotiation is a security 'context' which is
cached in the kernel, and is subsequently used for authentication (as
part of the credential in the RPC header) and/or for data
integrity/privacy protection (using whatever crypto mechanism your
chosen security mechanisms support).

Our wish is to provide basic kernel RPC client support for the generic
RPCSEC_GSS protocol, and for communicating with a userland daemon that
does the actual the security context negotiation with the RPC server.
Communication between kernel and userland is done over a set of named
pipes (in much the same way as the CODA upcall/downcall is done) in a
private ramfs-like filesystem.

Cheers,
  Trond
