Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbUJYPXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbUJYPXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUJYPUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:20:04 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:49290 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S261922AbUJYPPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:15:46 -0400
Date: Mon, 25 Oct 2004 11:15:34 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 12/28] VFS: Remove (now bogus) check_mnt
In-reply-to: <20041025150941.GA1682@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Message-id: <417D1896.4080901@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1098715442105@sun.com> <10987154731896@sun.com>
 <20041025150941.GA1682@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Oct 25, 2004 at 10:44:33AM -0400, Mike Waychison wrote:
> 
>>check_mnt used to be used to see if a mountpoint was actually grafted or not
>>to a namespace.  This was done because we didn't support mountpoints being
>>attached to one another if they weren't associated with a namespace. We now
>>support this, so all check_mnt calls are bogus.  The only exception is that
>>pivot_root still requires all participants to exist within the same
>>namespace.
> 
> 
> did you audit the namespace code that it doesn't allow attachign to other
> namespaces than the current?
> 

So, I don't see how that is possible, other than through relative
resolution from a cwd in the other namespace.  Arguably, you aren't
buying any security by denying the mountpoint if you already let other
processes in your namespace.

Auditting the original code, it appeared that doing such a thing was a
no-no only because the locking semantics of current->namespace->sem made
this difficult.


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfRiVdQs4kOxk3/MRAmC2AJ93Dqcf1hNFjmjKESxsfuBeUqZ+nQCffEZX
Ej3a3wyhQAwTg+amwHqn1v0=
=se6H
-----END PGP SIGNATURE-----
