Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSA0OKs>; Sun, 27 Jan 2002 09:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSA0OKi>; Sun, 27 Jan 2002 09:10:38 -0500
Received: from pat.uio.no ([129.240.130.16]:22522 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S287840AbSA0OKe>;
	Sun, 27 Jan 2002 09:10:34 -0500
To: Stefan Frank <sfr@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre3-ac2 : stuck when mounting NFS v3 via automounter
In-Reply-To: <20020126225232.GA1017@obelix.gallien.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Jan 2002 15:10:29 +0100
In-Reply-To: <20020126225232.GA1017@obelix.gallien.de>
Message-ID: <shsy9ij7ulm.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stefan Frank <sfr@gmx.net> writes:

     > Jan 23 13:06:47 asterix kernel: NFS: server cheating in read
     > reply:
     >        count 270336 > recvd 8680

     > Jan 12 22:36:47 asterix kernel: call_verify: server accept
     > status: 2

     > Jan 13 12:43:49 asterix kernel: expected (0x808/0x1c0b6), got
     >        (0x4000000040808/0x400000001c0b6)

     > Anyone can tell me what they mean?

Those are all reports of server bugs.

The first says that you are receiving read packets that are reported
to be longer than they actually are. This is harmless, since the RPC
layer automatically truncates any packets that threaten to overflow
our buffers.

The second is a report from the RPC layer. The server is saying that
you are trying to use an RPC service that it doesn't support.

The third states that your server is returning seriously screwed up
file attributes: even the fileid (a.k.a. inode number) is changed.

None of the above errors can cause a client to hang, however I suggest
that you try upgrading/patching your server.

Cheers,
   Trond
