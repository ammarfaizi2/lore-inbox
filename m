Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267806AbTCFFg1>; Thu, 6 Mar 2003 00:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267807AbTCFFg1>; Thu, 6 Mar 2003 00:36:27 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:62686
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267806AbTCFFg0>; Thu, 6 Mar 2003 00:36:26 -0500
Message-ID: <3E66E101.8050009@redhat.com>
Date: Wed, 05 Mar 2003 21:47:45 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com> <20030305210856.B16093@redhat.com> <3E66C5F4.5000106@redhat.com> <20030306002945.A31972@redhat.com>
In-Reply-To: <20030306002945.A31972@redhat.com>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Benjamin LaHaise wrote:
> using the TLS segment everywhere slows everything down
> a tiny bit.  Don't do it for unthreaded programs.

You completely (still!) fail to understand the issue.  How can I take
somebody who suggest using the stack as a pseudo thread register
serious?  You don't see the impact of this so you don't recognize who
absolutely absurd this is.

Wrt inthreaded apps: either TLS is used everywhere or not at all.
Single threaded code uses library code which relies on TLS.  And since
TLS is part of the ABI there is not question about the "not at all".
The remaining issue is how to do it with the least impact.  For this
I've proposed a method which does this (according to Andi's
measurements) with the least impact.

And nobody forces you to use the standard runtime environment.  Go on,
create your own.  Then you won't have any penalties except one single
'if' in the context switching code which you hopefully can live with.
Mark it with unlikely() for all I care.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZuEB2ijCOnn/RHQRAnlwAJ4kcZ7FbESC+FIsOyn6Ia0wN8FskgCgvh/K
SR1Ki1CnTe2QXq0Gn7TsvAY=
=jJ0e
-----END PGP SIGNATURE-----

