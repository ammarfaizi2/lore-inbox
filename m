Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSJUVHQ>; Mon, 21 Oct 2002 17:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJUVHQ>; Mon, 21 Oct 2002 17:07:16 -0400
Received: from mithra.wirex.com ([65.102.14.2]:64264 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S261642AbSJUVHP>;
	Mon, 21 Oct 2002 17:07:15 -0400
Message-ID: <3DB46DD2.8030007@wirex.com>
Date: Mon, 21 Oct 2002 14:12:50 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <20021017195015.A4747@infradead.org>	<20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org>	<20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> 	<20021017201030.GA384@kroah.com> <1035208643.27309.109.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig82E27E025063FB50546F4CBD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig82E27E025063FB50546F4CBD
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

>On Thu, 2002-10-17 at 21:10, Greg KH wrote:
>  
>
>>Ok, I think it's time for someone who actually cares about the security
>>syscall to step up here to try to defend the existing interface.  I'm
>>pretty sure Ericsson, HP, SELinux, and WireX all use this, so they need
>>to be the ones defending it.
>>    
>>
>The existing interface is basically the one Linus asked for, although
>perhaps with a little less thought on the structure side than it would
>have benefitted
>
The intent behind the syscall interface was that it needed to be generic 
enough to support the 50+ syscalls that SELinux wants, and also be 
generic enough to support potential modules that have not been invented 
yet. That's why it is a MUX, and why the signature definition is enough 
to deal with stacked modules and then pass a generic argv list to the 
module itself.

Unfortunately, this design goal (highly generic interface) is 
incompatible with the 32/64 bit transparancy layer that several 
supported architectures need. As Christoph says, this is unfixable. 
IMHO, it is unfixable because of conflicting design goals: you cannot 
have a truly generic syscall interface and hope for it to port clean 
from 32 bits to 64 bits.

Therefore, the sys_security syscall has been removed. LSM-aware 
applications that want to talk to security modules can do so through a 
file system interface. This will work for WireX, and Smalley says it 
will work for SELinux. I hope it will work for others.

Again, my thanks for eveyone's help in cleaning up this issue, and my 
apologies to anyone I may have offended. We should have thought about 
the 32/64 bit issue when we defined that interface. Kudos to Greg K-H, 
who told me that this syscall would be a problem.

Thanks,
    Crispin

--------------enig82E27E025063FB50546F4CBD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9tG3b5ZkfjX2CNDARASNdAKCwdQvWx7puvMaDoBenNjVjnTyDJACdEPj0
anA1Ri+pl+hLuSROSHPbdko=
=GXuV
-----END PGP SIGNATURE-----

--------------enig82E27E025063FB50546F4CBD--

