Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTEIR11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 13:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTEIR11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 13:27:27 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:59794
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263355AbTEIR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 13:27:22 -0400
Message-ID: <3EBBE7E2.1070500@redhat.com>
Date: Fri, 09 May 2003 10:39:46 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell>
In-Reply-To: <20030509092026.GA11012@averell>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> That's just an inadequate data structure. It does an linear search of the
> VMAs and you probably have a lot of them. Before you add kludges like this 
> better fix the data structure for fast free space lookup.

If you mean the code in arch_get_unmapped_area(), yes, this needs
fixing.  In fact, Ingo has already a patch which brings back the
performance of thread creation to what we had back in September/October.


> In some vendor kernels it's already in /proc/pid/mapped_base, but that is 
> quite costly to change. That would probably give you the best of both, Just 
> set it to a low value for the thread stacks and then reset it to the default.
> 
> I guess that would be the better solution for your stacks. 

Are you sure this is the best solution?  It means the mmap regions for
restricted 31/32 bit addresses and that for the normal, unrestricted
mapping is continuous.  This removes a lot of freedom in deciding where
the unrestricted mappings are best located and it would make programs
using threads have a very different memory layout.  Not that it should
make any difference; but I can here /them/ already scream that this
breaks applications.

My kernel-uninformed opinion would be to keep the settings separate.

Oh, and please rename MAP_32BIT to MAP_31BIT.  This will save nerves on
all sides.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+u+fi2ijCOnn/RHQRAqeBAKC3ZlSCNcw3f7SXahvxRc0WMupYgwCgyBGy
fMqzCxWcx90e002CNUQqwgM=
=LDJf
-----END PGP SIGNATURE-----

