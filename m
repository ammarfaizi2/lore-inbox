Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261707AbSJQQps>; Thu, 17 Oct 2002 12:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbSJQQps>; Thu, 17 Oct 2002 12:45:48 -0400
Received: from mithra.wirex.com ([65.102.14.2]:58890 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S261707AbSJQQpq>;
	Thu, 17 Oct 2002 12:45:46 -0400
Message-ID: <3DAEEA7A.6000803@wirex.com>
Date: Thu, 17 Oct 2002 09:51:06 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make LSM register functions GPLonly exports
References: <20021017153505.A27998@infradead.org> <20021017150740.GA31056@kroah.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigF14B24A9121C81991429F048"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF14B24A9121C81991429F048
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>On Thu, Oct 17, 2002 at 03:35:05PM +0100, Christoph Hellwig wrote:
>  
>
>>These exports have the power to change the implementations of all
>>syscalls and I've seen people exploiting this "feature".
>>
>>Make the exports GPLonly (which some LSM folks agreed to
>>when it was merged initially to avoid that).
>>    
>>
>I would really, really, really like to make this change.  Unfortunatly,
>one of the current copyright holders of this file does not agree with
>it.
>
>Crispin, for the benifit of the lkml readers, can you explain why WireX
>does not want this change?
>
Here's the monster flame-war we had the last time this issue was debated 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.3/0102.html

My argument against the intent of this change is that no, I do not think 
we should restrict LSM modules to be GPL-only. LSM is an API for loading 
externally developed packages of software, similar to syscalls. There is 
benefit in permitting proprietary modules (you get additional modules 
that you would not get otherwise) just as there is benefit in permitting 
proprietary applications (you get Oracle, DB2, and WordPerfect).

My argument against the implementation technique of dropping in these 
export GPLonly symbols is that my read of the GPL itself means that they 
have no legal impact. The crux of the matter is whether a *court* finds 
that LSM is "linking" (in the GPL sense) or is an "interface":

    * If it is "linking": then all LSM modules end up GPL'd, regardless
      of what any of us want.
    * If it is "an interface": then the GPL specifically *prohibits* you
      from imposing additional restrictions, such as requiring someone
      else's module to be GPL'd, to wit:
          o Clause 4: "You may not copy, modify, sublicense, or
            distribute the Program except as expressly provided under
            this License."
          o Clause 6: "... You may not impose any further restrictions
            on the recipients' exercise of the rights granted herein."

Therefore, the EXPORT_SYMBOL_GPL is just a bunch of useless bloat, with 
no legal standing what so ever. If kernel module interfaces are held by 
a court to be linking, then export symbols are redundant. If kernel 
module interfaces are held by a court to be an interface, then the 
export symbols are just wrong.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


--------------enigF14B24A9121C81991429F048
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9ruqC5ZkfjX2CNDARAb9oAJ0Rfcs1AmzFcThwMu6LwjYk53kNFgCg3Pr7
ZRqO8UZlVjmiWuDqa1W7XUM=
=5oBb
-----END PGP SIGNATURE-----

--------------enigF14B24A9121C81991429F048--

