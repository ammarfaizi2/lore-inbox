Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265400AbUAMTCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265404AbUAMTC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:02:29 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:36238 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S265400AbUAMTCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:02:24 -0500
Date: Tue, 13 Jan 2004 14:01:48 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <4004409C.6040900@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig33ACE2770E76760CD51F22AF;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig33ACE2770E76760CD51F22AF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:

>On Mon, 12 Jan 2004, Mike Waychison wrote:
>
>  
>
>>>And I have another question concerning namespaces.
>>>
>>>Given that there may be several namespaces, each of which may or may not
>>>have a trigger on this dentry, is there some sort of list of triggers?
>>>
>>>How do the triggers know who owns them?
>>>
>>>
>>>
>>>
>>>      
>>>
>>This is the reason I went with using distinct filesystems to perform the
>>triggers.  If we use follow_link logic, we will have a reference to the
>>respective vfsmount.  Dentry's themselves know nothing about the
>>triggers, as the triggers just look like a mounted filesystem.   The
>>vfsmount information has enough information for autofs to call a
>>userspace agent through hotplug and have userspace handle the mount.  In
>>effect, there is no daemon so nobody 'owns' a trigger in the same sense
>>as with autofs3/4.
>>    
>>
>
>I'm not familiar with the follow_link mechanism (no prob. I'll pick it up
>as I go).
>
>Correct me if I'm wrong but, the only thing that I can see that is
>duplicated in cloning a namespace is the root dentry. The rest of the
>dentries on the system remain the same. The increase in complexity to the
>VFS to change this would be prohibitive.
>  
>
No.  Dentries are *never* duplicated.  This goes back to Viro's work on 
allowing a filesystem to be mounted in multiple locations.  See 
http://kt.zork.net/kernel-traffic/kt20000424_64.html#9 .

What is duplicated is the current->namespace tree of vfsmounts.  After 
this is done, current->fs vfsmount members are updated to point to their 
cloned counterparts.

>I see we want the triggers in the vfsmount struct. Is this a good idea?
>The vfsmount struct has always been difficult to get hold of during lookup
>and revalidate for me (someone like to help here).
>
>  
>
If triggers in the vfsmount struct are done, then there will be no need 
to handle lookups or revalidates.  In fact, triggers in the vfsmount 
struct will not help at all for indirect maps.

>
>Also, something needs to be done about mount table noise. Several hundred
>entries is very bad from an administration viewpoint.
>  
>
I don't see what you want here.  If you have hundreds of users logged 
into the same machine, you *will* have hundreds of entries in the 
mount-table.

>Except for the cross namespace issues, which I'm still digesting, I can't
>see why your design can't be done entirely as a filesystem using dentries
>instead of vfsmount, including expirey. Perhaps you could reinterate a few
>of the reasons for this.
>  
>
My proposal uses filesystems for all automount mechanism *except* 
expiry. I see expiry as a VFS service, and strongly believe that this is 
where it belongs.

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


--------------enig33ACE2770E76760CD51F22AF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFABEChdQs4kOxk3/MRAjN2AKCYbtW16sHaHGc0DnOHbrpDDjdjlACggMC8
tD9N1UTqN+4PmyjD0gmi874=
=b8tF
-----END PGP SIGNATURE-----

--------------enig33ACE2770E76760CD51F22AF--

