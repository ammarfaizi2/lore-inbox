Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSIAVvj>; Sun, 1 Sep 2002 17:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318123AbSIAVvj>; Sun, 1 Sep 2002 17:51:39 -0400
Received: from pat.uio.no ([129.240.130.16]:62599 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318121AbSIAVvg>;
	Sun, 1 Sep 2002 17:51:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.36080.987645.452664@charged.uio.no>
Date: Sun, 1 Sep 2002 23:56:00 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030916061.2145.344.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no>
	<1030890022.2145.52.camel@ldb>
	<15730.17171.162970.367575@charged.uio.no>
	<1030906488.2145.104.camel@ldb>
	<15730.27952.29723.552617@charged.uio.no>
	<1030916061.2145.344.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

    >> Because, as has been explained to you, we have things like
    >> Coda, Intermezzo, NFS, for which this is insufficient.
     > If they only need them at open, and the open is synchronous,
     > you don't need to copy them.

Bullshit. You clearly haven't got a clue what you are talking about.

For all these 3 systems credentials need to be cached from file open
to file close.

  YES EVEN NOW, WITH NO CLONE_CRED AND WITH SYNCHRONOUS OPEN !!!!

On something like NFS or Coda, the server needs to receive
authentication information for each and every RPC call we send to
it. There's no state. The server does not know that we have opened a
file.

Currently this is done by the NFS client hiding information in the
file's private_data field. This means that other people that want to
do write-through-caching etc are in trouble 'cos they have to cope
with the fact that NFS has its private field, Coda has its private
field,... And they are all doing the same thing in different ways.

Now stop trolling

  Trond
