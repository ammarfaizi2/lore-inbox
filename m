Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUGZInO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUGZInO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265053AbUGZInO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:43:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43716 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265048AbUGZInH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:43:07 -0400
Date: Mon, 26 Jul 2004 10:18:48 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and SPEC SFS Run rules.
In-Reply-To: <Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407261016580.32233-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the important part of rule 1. saying "server adheres to the 
protocol" is this bit from rfc1813:

   The following data modifying procedures are
   synchronous: WRITE (with stable flag set to FILE_SYNC), CREATE,
   MKDIR, SYMLINK, MKNOD, REMOVE, RMDIR, RENAME, LINK, and COMMIT.

E.g. if a client had a successful SYMLINK and the server crashed, the 
client is not going to discover on the next reboot (of the server) that 
the symlink is somehow disappeared...

Kind regards
Tigran

On Mon, 26 Jul 2004, Tigran Aivazian wrote:

> On Mon, 26 Jul 2004, Andrew Morton wrote:
> > ext3 should be fully syncing data and metadata for both fsync() and O_SYNC
> > writes in all three journalling modes.  If not, that's a big bug.
> 
> Ok, so, can I conclude that you are therefore saying that ext3 (with 
> default mount options) is compliant with SPEC SFS Run rules wrt NFS 
> protocol requirements:
> 
>    1.   For NFS Version 2, the server adheres to the protocol 
> specification and in particular the requirement that for NFS write 
> operations the NFS server must not reply to the NFS client before any 
> modified file system data or metadata, with the exception of access times, 
> are written to stable storage.
>    2. For NFS Version 3, the server adheres to the protocol specification. 
> In particular the requirement that for STABLE write requests and COMMIT 
> operations the NFS server must not reply to the NFS client before any 
> modified file system data or metadata, with the exception of access times, 
> are written to stable storage for that specific or related operation. See 
> RFC 1813, NFSv3 protocol specification for a definition of STABLE and 
> COMMIT for NFS write requests.
>    3. For NFS Version 3, operations which are specified to return wcc data 
> must, in all cases, return TRUE and the correct attribute data. Those 
> operations are:
> 
>       NFS Version 3
>       SETATTR
>       READLINK
>       CREATE
>       MKDIR
>       SYMLINK
>       MKNOD
>       REMOVE
>       RMDIR
>       RENAME
>       LINK
> 
>    4. The server must pass the benchmark validation for the NFS protocol 
> being tested.
>    5. When UDP is the network transport, UDP checksums must be calculated 
> and verified for all NFS request and reply messages. In other words, 
> checksums must be enabled on both the client and server.
> 
> 
> Kind regards
> Tigran
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

