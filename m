Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267473AbTCETOI>; Wed, 5 Mar 2003 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267547AbTCETOI>; Wed, 5 Mar 2003 14:14:08 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:6107 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267473AbTCETOG>; Wed, 5 Mar 2003 14:14:06 -0500
Message-ID: <3E664F26.7000602@redhat.com>
Date: Wed, 05 Mar 2003 11:25:26 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de>
In-Reply-To: <20030305190622.GA5400@wotan.suse.de>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:

> The problem is that the context switch is much more expensive with that
> (wrmsr is quite expensive compared to the memcpy or index reload). The kernel 
> optimizes it away when not needed, but with glibc using them 
> for everything all processes will switch slower.

And the loadsegment() call with all the preparations if faster?  And
faster in future revisions of the processor?  Since I cannot get any
recent kernel to run you'll have to do the timing.  I wouldn't expect
the difference to be significant.


>  but is it that big a problem to split the
> index table for thread local data and the stack? 

Yes, it it.  It would basically double thread create-destroy costs.
double the internal administrative overhead (and time and memory), would
add more dcache pressure, and so on.  It is simply stupid.  We don't
have to do it for any other architecture, so don't force such hacks on
us for an architecture whose lifespan just starts.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Zk8m2ijCOnn/RHQRAiUWAJ4o3akYg11tw4PGoIrqln3r/9v4kQCgm+MD
kcrsGMVa0Z++yccEkxolxX8=
=gHz/
-----END PGP SIGNATURE-----

