Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUIFStn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUIFStn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUIFStn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:49:43 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:63366 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S268448AbUIFSth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:49:37 -0400
Date: Mon, 6 Sep 2004 20:49:30 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andreas Happe <andreashappe@flatline.ath.cx>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <20040901082819.GA2489@final-judgement.ath.cx>
Message-ID: <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
References: <20040831175449.GA2946@final-judgement.ath.cx>
 <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>
 <20040901082819.GA2489@final-judgement.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andreas,

I really like the patch - I wanted to do quite the same so thanks that you
saved me some work ;-)

On Wed, 1 Sep 2004, Andreas Happe wrote:

> the attached patch creates a /sys/cryptoapi/<cipher-name>/ hierarchie

I'd prefer to have the algorithms grouped by "type" ("cipher", "digest",
"compress")? Then the apps could easily see only the algos that thay are
interested in...

> Also the different cipher types (digest, compress..) could be seperated
> into own ksets/directories, but this would make the crypto/proc.c code
> worse.

There could eventually be a separate crypto/sysfs.c, couldn't?

> | bash-2.05b# cd aes/
> | bash-2.05b# ls
> | blocksize  maxkeysize  minkeysize  module  name  type

Few notes:
- - some algorithms allow only discrete set of keysizes (e.g. AES can do
128b, 192b and 256b). Can we instead of min/max have a file 'keysize' with
either:
	minsize-maxsize
or
	size1,size2,size3
?

- - ditto for blocksize?

- - With the future support for hardware crypto accelerators it
might be possible to have more modules loaded providing the same
algorithm. They may have different priorities and one would be treated as
"default". Then I expect the syntax of 'module' file to change from a
simple module name to something like:
	# modname:prio:type:whatever
	aes:0:generic:
	aes_i586:1:optimized:
	padlock:2:hardware:default
But for now there is probably nothing to do about it.

Michal Ludvig
- -- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQFBPLFADDolCcRbIhgRAksyAJ4t+6m6demqQYdlJm3TnKMkLCSa5QCgrset
VlNlUPb0517aLARgI6mt8gk=
=rjsX
-----END PGP SIGNATURE-----

