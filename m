Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264608AbSJRJaz>; Fri, 18 Oct 2002 05:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSJRJaz>; Fri, 18 Oct 2002 05:30:55 -0400
Received: from mithra.wirex.com ([65.102.14.2]:62226 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S264608AbSJRJax>;
	Fri, 18 Oct 2002 05:30:53 -0400
Message-ID: <3DAFD61F.8090607@wirex.com>
Date: Fri, 18 Oct 2002 02:36:31 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: hch@infradead.org, greg@kroah.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       davem@redhat.com
Subject: Re: [PATCH] remove sys_security
References: <20021017201030.GA384@kroah.com.suse.lists.linux.kernel> <20021017211223.A8095@infradead.org.suse.lists.linux.kernel> <3DAFB260.5000206@wirex.com.suse.lists.linux.kernel> <20021018.000738.05626464.davem@redhat.com.suse.lists.linux.kernel> <3DAFC6E7.9000302@wirex.com.suse.lists.linux.kernel> <p73wuognlox.fsf@oldwotan.suse.de>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig575D92046349DE4D99C4A5F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig575D92046349DE4D99C4A5F0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andi Kleen wrote:

>Crispin Cowan <crispin@wirex.com> writes:
>  
>
>>Could you elaborate on why this is a sign of trouble, design wise?
>>    
>>
>David refers to the 32bit emulation issues. Some ports have a 64bit
>kernel, but support 64bit and 32bit userland (e.g. ia64 or x86-64). 
>Some ports even only have 32bit userland but 64bit kernel (like sparc64 or 
>mips64)
>
Thank you very much for clarifying.

>The 32bit and the 64bit worlds have different data types. Structure
>layout are different. To handle this the kernel has an emulation
>layer that converts the arguments of ioctls and system calls between 
>32bit and 64bit.
>
>This emulation layer sits at the 'edge' of the kernel. For example
>to convert an ioctl it first figures out the ioctl, converts it
>then reissues the same ioctl internally with 64bit arguments. When
>the ioctl returns outgoing arguments are converted too as needed.
>
>For this to work all data structures need to be transparent.
>The emulation layer needs to have a way to figure out what and
>how to convert without looking at internal state in the kernel.
>Otherwise it cannot do its job. 
>
>Without working emulation sparc64 won't work and David will be unhappy.
>
I'm all for 64-bit support, and for easy transition from 32 to 64 bits. 
Really: I was around to watch the pain of transition from 16 bits to 32 
bits, and I'm thrilled to see people taking the problem more seriously 
this time.

So: does it help to specify that the sys_security arguments be (say) 
"unsigned int"?  Then you can just zero-pad them, or truncate them.

And even if the 32bit emulation layer doesn't perfectly translate the 
sys_security arguments: that just breaks LSM modules. It would not 
surprise me that something like an application trying to talk to a 
security module might not cleanly port from 32 to 64 bits. By carefully 
stating the assumptions (clean data types) most of these problems should 
be addressed.

I don't get why this is a hard problem.

Crispin


--------------enig575D92046349DE4D99C4A5F0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9r9Yg5ZkfjX2CNDARAfteAKDJ0z4d96nkBvUw0dptQZD1SVP7fwCgjPok
Pq1sGs3y7Lob1rbrk/tsgPQ=
=IhQN
-----END PGP SIGNATURE-----

--------------enig575D92046349DE4D99C4A5F0--

