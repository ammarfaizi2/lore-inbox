Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSL3D>; Tue, 19 Dec 2000 06:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLSL2x>; Tue, 19 Dec 2000 06:28:53 -0500
Received: from [212.32.186.211] ([212.32.186.211]:7108 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129228AbQLSL2j>; Tue, 19 Dec 2000 06:28:39 -0500
Date: Tue, 19 Dec 2000 11:58:10 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Hans-Joachim Baader <hjb@pro-linux.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: Thread problem with smbfs
In-Reply-To: <20001219093341.E10DC3ED844@grumbeer.hjb.de>
Message-ID: <Pine.LNX.4.21.0012191057010.8007-100000@cola.svenskatest.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2000, Hans-Joachim Baader wrote:

> and so on, endlessly. So, AFAIK,  smbfs thinks it has lost connection and
> tells smbmount to re-establish it, which succeeds (at least smbmount
> thinks so). This happens several times per second.

-512 means that the recv was interrupted by a signal, or rather, the
current process has a signal maybe the recv was interrupted, maybe there
is a problem with the connection, better reconnect.

Still, it's better than pre-2.2.18 where smbmount wouldn't stay alive ...

I don't really know how signal delivery works within the kernel, but
smb_trans2_request tries to disable some signals. That does not work
(completely?) so either it needs fixing or the -512 errno needs to be
handled.

Why so bad in gdb? perhaps it causes more signals.
Why does one thread end up in D state? don't know.


> Kernel 2.2.18, smbfs as a module. I can provide more info if necessary.

A small testprogram that causes this would be nice. The -512 is easy to
reproduce but I haven't seen the 'D' before.

If someone is interested the relevant code is fs/smbfs/sock.c
(smb_trans2_request, ..., _recvfrom)

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
