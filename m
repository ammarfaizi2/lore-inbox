Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265874AbUF3NPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUF3NPz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUF3NPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:15:54 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:40619 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S265874AbUF3NPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:15:51 -0400
Date: Wed, 30 Jun 2004 09:15:13 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: per-process namespace?
In-reply-to: <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org
Message-id: <40E2BCE1.3040302@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1088534826.2816.38.camel@dyn319623-009047021109.beaverton.ibm.com>
 <40E1DABD.9000202@sun.com>
 <20040629221025.GI12308@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Jun 29, 2004 at 05:10:21PM -0400, Mike Waychison wrote:
>
>>Another caveat is that the current system disallows you from doing any
>>mount/umount's in another namespace (bogus security?).
>
>
> Nothing bogus here - namespace boundary _IS_ a trust boundary and that's
> exactly the diference between symlinks and bindings - symlink attacks
> are possible exactly because they allow you to modify visible tree
topology
> for other users.

Yet being able to access another namespace via directory fd still breaks
that boundary.  I'm not sure if it's a feature or a not.  If it is a
feature, I'd argue that having the fd means you are trusted to play in
that namespace, which implies the right to do things like call mount(2)
in it.

>
> Note that sharing parts of namespace (which is basically what automounter
> wants and what we do not have yet) is deliberate act of trust - same as
> having a part of your address space shared with other process.

Namespace sharing has been touched on before, but hasn't been discussed
publicly.  My take on it is that in order to have namespace sharing work
in some semantically sane way, we need to be able to identify
owner-namespaces for shared branches of the vfsmount tree.  This implies
making namespaces first-class primitives.  Is this where we want to go
with this?

I only see automounting being the only consumer of such a beast, are
there other possible users?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4rzgdQs4kOxk3/MRAkxVAJ9kHj/6xfa/zSXLpT7v2hkOSFWhrgCggjL/
ovcsxTkm6FpbWMlzIQn4geU=
=B4D5
-----END PGP SIGNATURE-----
