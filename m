Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265013AbSJRG6c>; Fri, 18 Oct 2002 02:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265025AbSJRG6c>; Fri, 18 Oct 2002 02:58:32 -0400
Received: from mithra.wirex.com ([65.102.14.2]:34062 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S265013AbSJRG6a>;
	Fri, 18 Oct 2002 02:58:30 -0400
Message-ID: <3DAFB260.5000206@wirex.com>
Date: Fri, 18 Oct 2002 00:04:00 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com> <20021017211223.A8095@infradead.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigC84BE6F65036E67936B49E99"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC84BE6F65036E67936B49E99
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christoph Hellwig wrote:

>On Thu, Oct 17, 2002 at 01:10:31PM -0700, Greg KH wrote:
>  
>
>>>>How would they be done differently now?  Multiple different syscalls?
>>>>        
>>>>
>>>Yes.
>>>      
>>>
>>Hm, in looking at the SELinux documentation, here's a list of the
>>syscalls they need:
>>	http://www.nsa.gov/selinux/docs2.html
>>
>>That's a lot of syscalls :)
>>    
>>
>I know.  but hiding them doesn't make them any better..
>
Actuall, yes it does, and that is the point. You don't have to like 
SELinux's system calls, or any other module's syscalls. The whole point 
of LSM was to decouple security design from the Linux kernel development.

There are a butt-load of different access control models, and many of 
them are not compatible with one another. You wouldn't want to support 
them all--that would be serious bloat. So instead, LSM lets each user 
choose the model that suits them:

    * server users can choose a highly secure model
    * workstation users can choose something desktop oriented
    * embedded people can choose nothing at all, or the specific
      narrow-cast model that they need

On the other hand: what is the big cost here? One system call. Isn't 
that actually *lower* overhead than the (say) half dozen 
security-oriented syscalls we might convince you to accept if we drop 
the sys_security syscall as you suggest? Why the fierce desire to remove 
something so cheap?

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


--------------enigC84BE6F65036E67936B49E99
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9r7Jp5ZkfjX2CNDARAQdaAJ4h2wU6j66EGH1kjPoP4nfNd8U5TQCfS0rP
d7GrvMlnI2gOz1WIZGqnD1w=
=a9fm
-----END PGP SIGNATURE-----

--------------enigC84BE6F65036E67936B49E99--

