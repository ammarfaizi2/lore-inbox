Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbSJRI4n>; Fri, 18 Oct 2002 04:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbSJRI4n>; Fri, 18 Oct 2002 04:56:43 -0400
Received: from mithra.wirex.com ([65.102.14.2]:1805 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S262914AbSJRI4l>;
	Fri, 18 Oct 2002 04:56:41 -0400
Message-ID: <3DAFCE1B.805@wirex.com>
Date: Fri, 18 Oct 2002 02:02:19 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigAE2DE3990B6D079497BFCD5C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE2DE3990B6D079497BFCD5C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alexander Viro wrote:

>On Fri, 18 Oct 2002, Crispin Cowan wrote:
>  
>
>>    * server users can choose a highly secure model
>>    * workstation users can choose something desktop oriented
>>    * embedded people can choose nothing at all, or the specific
>>      narrow-cast model that they need
>>
>>On the other hand: what is the big cost here? One system call. Isn't 
>>that actually *lower* overhead than the (say) half dozen 
>>security-oriented syscalls we might convince you to accept if we drop 
>>the sys_security syscall as you suggest? Why the fierce desire to remove 
>>something so cheap?
>>    
>>
>Because ugliness has its price.  As for "highly secure"...  Could we please
>see some proof?  Clearly stated properties with code audit to verify them
>would be nice.
>
LSM being an interface, it doesn't provide that. LSM's objective is to 
provide modules with the ability to mediate access to major internal 
kernel objects by user processes.

The security modules, in turn, use this ability to mediate to access to 
objects to implement some specific stated security property, and you 
would have to audit the module's code.

Some simple properties in the OWLSM module (porting some of the 
properties from the Openwall patch, and adding some more):

    * root may not follow non-root symlinks in certain circumstances
      (prevent some temp file attacks)
    * non-root may not create a hard-link to root-owned files in certain
      circumstances (prevent some other temp file attacks)
    * may not ptrace root processes (preventing further recurrance of
      the bugs in ptrace over the last year or so)

These policies help a lot to secure a system. But these policies also 
break some things, so it is good that they be a loadable module, and not 
a proposed Linux patch.

>I'm yet to see a single shred of evidence that so-called security improvements
>actually do improve security (as opposed to feeling of security - quite
>a different animal).  And in this case burden of proof is clearly on your
>side.
>
We took a system protected with SubDomain to Defcon and kicked ass 
http://news.com.com/2100-1001-948404.html?tag=rn

That was a 2.2 version of SubDomain. SubDomain is in the process of 
being ported to the 2.4 back-patch version of LSM.

>What I _do_ see is a lucrative market for peddlers of feel-good "solutions"
>that do not make anything secure but have miles-long feature lists that
>can be used to impress PHBs.  Now, I have no particular problems with
>people who help suckers part with their money, but I don't see any reason
>to support them.
>
>3 or 4 patches that might be interesting would be better off without LSM.
>The rest...  care to give a hard evidence that it is worth any support?
>
The SELinux and DTE modules provide a similar form of security, but with 
different trade-offs between expressivenes and complexity. *Not* forcing 
a specific choice in this space on users was a major reason Linus 
rejected SELinux as a patch, and instead suggested enhancing the module 
interface.

There is GOBS of evidence that mandatory access control enhances 
security. But there is also gobs of evidence that mandatory access 
control is a huge pain in the ass to manage, leading to a huge plethora 
of different access control models. Being able to choose your model to 
suit your needs & circumstances, or choose none at all, was another 
reason for implementing an interface instead of a specific set of features.

Crispin


--------------enigAE2DE3990B6D079497BFCD5C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9r84b5ZkfjX2CNDARAdTSAKCGC5BYpzxaUVcP2YE3TM46afax6ACggsk7
2AcPMkT9ma/YAenCbR3Lv4g=
=/H52
-----END PGP SIGNATURE-----

--------------enigAE2DE3990B6D079497BFCD5C--

