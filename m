Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbUAIUQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUAIUQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:16:33 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:35257 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264252AbUAIUQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:16:28 -0500
Date: Fri, 09 Jan 2004 15:16:06 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFDB272.8030808@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: trond.myklebust@fys.uio.no, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, raven@themaw.net, thockin@Sun.COM
Message-id: <3FFF0C06.9070502@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enigF4228D656386ADD7393EF64B;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <33128.141.211.133.197.1073590355.squirrel@webmail.uio.no>
 <3FFDB272.8030808@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF4228D656386ADD7393EF64B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>trond.myklebust@fys.uio.no wrote:
>  
>
>>Finally, because the upcall is done in the user's own context, you avoid
>>the whole problem of automounter credentials that are a constant plague
>>to all those daemon-based implementations when working in an environment
>>where you have strong authentication.
>>If anyone wants evidence of how broken the whole daemon thing is, then see
>>the workarounds that had to be made in RFC-2623 to disable strong
>>authentication for GETATTR etc. on the NFSv2/v3 mount point.
>>
>>    
>>
>
>It's not broken as much as what you want to do is outside the scope of
>automount.  automount is one particular user of these facilities, and as
>you correctly point out, it can't solve the problems for all of them.
>The right thing for AFS and NFSv4 is clearly to do something different.
>
>  
>
If automount is going to be mounting NFS shares for users, I don't see 
how this is out of scope.

>Mount traps by themselves are not sufficient for automount, which is why
>I think we will always have a special "autofs" filesystem, for the
>simple reason that automount in typical use doesn't either have an a
>priori complete list of directories!  Even with ghosting you might find
>that you're accessing a new key which has not yet been ghosted, and it
>needs to be handled correctly.  Additionally, not all map types can be
>enumerated, and some aren't even finite in size (consider /net, program
>maps and wildcard map entries.)  Thus, for indirect mountpoints you
>still need a filesystem which can trap on non-enumerated entries.
>
>  
>
Yup.

>That being said, mount traps in particular, and possibly this "trap
>filesystem" are more generic kernel facilities which should be of use to
>other things than automount.  AFS/NFSv4 are the obvious examples, quite
>possibly other things like intermezzo might be interested, and we don't
>want to have to reinvent the wheel every time.
>
>  
>
I could see AFS using these mounttraps, however I don't see any benefit 
for NFS.   If anything, the migration issue is about getting rid of the 
daemon, not mounttraps.  The issues I think Trond is putting forward are:

a) The kernel needs to initiate a remount, but doesn't have nameservice 
functionality.

b) User credentials are needed to perform the initial mount itself 
because some servers don't allow non-authenticated calls to the MOUNT 
program, keeping the system from grabbing a root filehandle.

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enigF4228D656386ADD7393EF64B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//wwIdQs4kOxk3/MRAi3fAJ99NMP8oc8Amn/mjGijZQoSts97KwCeOcsA
gHkNSa5fpmFAiX5Ktd+QHbY=
=bLY8
-----END PGP SIGNATURE-----

--------------enigF4228D656386ADD7393EF64B--

