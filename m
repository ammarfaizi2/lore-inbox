Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265879AbUGZUix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUGZUix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUGZUgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:36:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:57786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265487AbUGZUCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:02:53 -0400
Date: Mon, 26 Jul 2004 13:01:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and SPEC SFS Run rules.
Message-Id: <20040726130128.668c0722.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain>
References: <20040726000313.3fbf8403.akpm@osdl.org>
	<Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@aivazian.fsnet.co.uk> wrote:
>
> On Mon, 26 Jul 2004, Andrew Morton wrote:
> > ext3 should be fully syncing data and metadata for both fsync() and O_SYNC
> > writes in all three journalling modes.  If not, that's a big bug.
> 
> Ok, so, can I conclude that you are therefore saying that ext3 (with 
> default mount options) is compliant with SPEC SFS Run rules wrt NFS 
> protocol requirements:

That is the design objective within ext3, the VFS and the NFS server, yes. 
Of course, there may be bugs in the implementation.

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

To confirm this we'd need to undertake an audit of the server
implementation, and we'll need to ask Neil about it.

