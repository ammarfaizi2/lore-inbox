Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbQKMFgw>; Mon, 13 Nov 2000 00:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130149AbQKMFgn>; Mon, 13 Nov 2000 00:36:43 -0500
Received: from dolly.vellum.cz ([62.80.80.20]:19531 "EHLO dolly.vellum.cz")
	by vger.kernel.org with ESMTP id <S130074AbQKMFg2>;
	Mon, 13 Nov 2000 00:36:28 -0500
Message-ID: <20001113063559.A27820@dolly.vellum.cz>
Date: Mon, 13 Nov 2000 06:35:59 +0100
From: Karel Zatloukal <kamzik@dolly.vellum.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: NFS-client & NIS-client UID/GID remapper
In-Reply-To: <200011062121.eA6LLir27520@dolly.vellum.cz> <200011062321.eA6NLON235284@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <200011062321.eA6NLON235284@saturn.cs.uml.edu>; from Albert D. Cahalan on Mon, Nov 06, 2000 at 06:21:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 06:21:24PM -0500, Albert D. Cahalan wrote:
> 
> The UID/GID mapper should be sepatate from the regex rewriting rules.

This is already done - the code is independent, it is just written in the same
source file.  Any problems from it?

> Both should be separate from NFS, because they have little to do with NFS.
> These are useful generic VFS features. It would be perfectly reasonable
> to use these features on a Zip disk with UFS (from MacOS X maybe).

Hmm... You are perfectly right, oops.

There is only a bit of technical detail how to set such mapping:  Currently I'm
using the "struct nfs_mount_data" which can contain any passed id-mapping
table.  When it would be filesystem-general, it would need different solution
("data" mount(2) argument is passed only as textstring, not as flexible
'struct' as in NFS case).  Probably to pass it by ioctl() call after the
mount(2) call has been done.

OK, I've todolisted this better generic-VFS approach, thanks. B ut I'll
implement it with some delay (busy etc).

...
> The pathname remapper might best be done as a namespace operation
> similar to mounting.
...
> an exploitable /usr/bin/suidperl, I'd like to "mount" a new
> executable on top of that from /bin/good-suidperl to fix the hole.

Such pathname remapper may be nice but it IMHO doesn't correspond to any code
written for announced idmapper.  This would be a nice but completely separate
feature.  Just to clarify - I have previously written:

# As a feature it also supports general regex rewriting rules for NIS client (to
# enable adjusts like "/bin/ksh -> /bin/bash" etc.).

This has the purpose to change the NIS line itself to prevent such hacking as
simulating some /bin/ksh etc.


						Karel Zatloukal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
