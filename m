Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUDQLNO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 07:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUDQLNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 07:13:14 -0400
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:17287 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S263847AbUDQLNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 07:13:11 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: Fix UDF-FS potentially dereferencing null
Date: Sat, 17 Apr 2004 13:12:44 +0200
User-Agent: KMail/1.6
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>, viro@parcelfarce.linux.theplanet.co.uk,
       bfennema@falcon.csc.calpoly.edu
References: <20040416214104.GT20937@redhat.com> <Pine.LNX.4.58.0404161720450.3947@ppc970.osdl.org> <1082195458.4691.1.camel@laptop.fenrus.com>
In-Reply-To: <1082195458.4691.1.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200404171313.02784.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On Saturday 17 April 2004 11:50, Arjan van de Ven wrote:
[superflous NULL pointer checks]
> > > It'll take a lot of effort to 'fix' them all, and given the non-severity
> > > of a lot of them, I'm not convinced it's worth the effort.
> > 
> > Just for the fun of it, I added a "safe" attribute to sparse (hey, it was 
> > trivial), and made it warn if you test a safe variable. 
> > 
> > You can do
> > 
> > 	#define __safe __attribute__((safe))
> > 
> > 	static struct denty *
> > 	udf_lookup(struct inode * __safe dir,
> > 			struct dentry * __safe dentry,
> > 			struct nameidata * __safe nd);
> > 
> > or
> is it maybe a good idea to map this to gcc's "nonnull" attribute in some
> way? That way both sparse and the compiler get this explicit
> knowledge.... (afaics gcc will then also just optimize out the null ptr
> checks)

Or even call the attribute "nonnull", because this is a very obvious
naming, even to non-native English readers.

"safe" can mean anything from "safe to use under spinlock" to
"you cannot get pregnant from using this variable".

GCC will not only optimize out the check, but also ensure that the we
will not pass NULL ptrs, if it can notice it. If this gets pushed high
enough (up to the register-like functions, where it gets first
assigned), we will never face this kind of problem anymore and document
this fact per function. Sounds like C coder heaven ;-)


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAgRE9U56oYWuOrkARAjQFAKCIvypi8zPswOX/Q4Qlnh01CBrwDQCfTKRQ
BY8VRXpe0ZuHRRIHH8JgDag=
=mQNg
-----END PGP SIGNATURE-----
