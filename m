Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUAIVpe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264508AbUAIVpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:45:33 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:14325 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S264493AbUAIVnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:43:52 -0500
Date: Fri, 09 Jan 2004 16:43:33 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFF14F9.6030601@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael Clark <michael@metaparadigm.com>, Ian Kent <raven@themaw.net>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFF2085.4020102@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig90F0E425FCCF33089537B762;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
 <3FFD9498.6030905@zytor.com> <3FFDEAE6.4030503@metaparadigm.com>
 <3FFF0EF0.90807@sun.com> <3FFF14F9.6030601@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90F0E425FCCF33089537B762
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>Mike Waychison wrote:
>  
>
>>This is an interesting approach to killing off a mountpoint.  However,
>>the problem in question is not the destruction of the mountpoints, but
>>rather being able to
>>check_activity_of_a_hierarchy_of_mountpoints/unmount_them_together
>>atomically.  This cannot be done cleanly in userspace even when given an
>>interface to do the check, someone can race in before userspace
>>initiates the unmounts.  The alternative is to have userspace detach the
>>hierarchy of mountpoints using the '-l' option to umount(8), but then we
>>may still unneccesarily unmount the filesystem will someone is in it.
>>I think that both HPA and I agree that this capability is needed in
>>order to support lazy mounting of multimounts properly.    The issue
>>that remains is *how* to do it.
>>
>>    
>>
>
>I would argue even stronger: allowing the administrator to umount
>directories manually is a hard requirement.  This means that partial
>hierarchies *will* occur.  Thus, relying on the hierarchy being
>atomically destructed in inherently broken.
>  
>
Yes, but they shouldn't occur due to normal operation of the system.  
Yes, the administrator can manually prune things away, yet the remaining 
bits should still be able to expire atomically.

On the other end of the spectrum is the situation where if I had 
accessed my homedir, /home/mikew, and then I manually mounted something 
in /home/mikew/mnt as root in another window, /home/mikew should _not_ 
expire.  /home/mikew/mnt is not managed by the automounter, so it 
shouldn't be expired by it either.

>This means that constructing the hierarchy with direct-mount automount
>triggers in between the filesystems is mandatory; you get lazy mounting
>for free, then -- it's a userspace policy decision whether or not to
>release the waiting processes before the hierarchy is complete or not.
>
>  
>
Yes, and this policy in my proposal is handled by the automount 
useragent.  The system is constructed such that any waiting processes 
are released when the useragent dies off.  If userspace wanted to let 
people in before it finished construction, it would fork and exit in the 
parent process.

>Now, once you recognize that the administrator needs to be able to do
>umounts, expiry in userspace becomes quite trivial, since expiry is
>inherently probabilistic: it can simply mimic an administrator preening
>the trees, and if it fails, stop (or re-mount the submounts, policy
>decision.)  Having a simple kernel-assist to avoid needless umount
>operations is a good thing if (and only if!) it's cheap, but it doesn't
>have to be foolproof.
>
>  
>
But it doesn't work as a daemon when you have namespaces created left 
and right.  It *would maybe* work as a cron job, if cron was namespace 
aware.

>Again, the atomicity constraint that umounting a filesystem needs to
>destroy the mount traps above it derives from the need to cleanly deal
>with nonatomic destruction.
>
>  
>
??

>>The time required to unmount something is constant if we detach the
>>mountpoint using a lazy umount.
>>
>>    
>>
>
>You probably don't want to do that -- you could end up with some really
>odd timing-related bugs if you then re-mount the filesystem.  It's also
>unnecessary, since expiry is not a triggered event and therefore doesn't
>keep anything that needs to happen from happening.
>
>  
>
Off the top of my head, I don't see any issues, but you are right in 
that something may creep up. 

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


--------------enig90F0E425FCCF33089537B762
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//yCIdQs4kOxk3/MRAnxvAJ4yYiUDtlN5Du7XBf+vxSdwhzP6wACgniVK
QTa+HmcaXF6gXcIpr+C+TsI=
=q4pi
-----END PGP SIGNATURE-----

--------------enig90F0E425FCCF33089537B762--

