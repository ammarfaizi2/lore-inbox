Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129073AbRBBMPJ>; Fri, 2 Feb 2001 07:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129099AbRBBMO7>; Fri, 2 Feb 2001 07:14:59 -0500
Received: from pat.uio.no ([129.240.130.16]:20728 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129073AbRBBMOo>;
	Fri, 2 Feb 2001 07:14:44 -0500
To: Andrew Morton <andrewm@uow.edu.au>
Cc: "David S. Miller" <davem@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A728475.34CF841@uow.edu.au> <3A726087.764CC02E@uow.edu.au> <20010126222003.A11994@vitelus.com> <3A728475.34CF841@uow.edu.au> <14966.22671.446439.838872@pizda.ninka.net> <3A7A8822.CC5D8E4E@uow.edu.au>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Feb 2001 13:14:33 +0100
In-Reply-To: Andrew Morton's message of "Fri, 02 Feb 2001 21:12:50 +1100"
Message-ID: <shs4rydnuxi.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <andrewm@uow.edu.au> writes:


     > Much the same story.  Big increase in sendfile() efficiency,
     > small drop in send() and NFS unchanged.

This is normal. The server doesn't do zero copy reads, but instead
copies from the page cache into an NFS-specific buffer using
file.f_op->read(). Alexey and Dave's changes are therefore unlikely to
register on NFS performance (other than on CPU use as has been
mentioned before) until we implement a sendfile-like scheme for knfsd
over TCP.
I've been wanting to start doing that (and also to finish the client
conversion to use the TCP zero-copy), but I'm pretty pressed for time
at the moment.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
