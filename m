Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUALQ7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 11:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUALQ7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 11:59:18 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:43140 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S265596AbUALQ7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 11:59:07 -0500
Date: Mon, 12 Jan 2004 11:58:48 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.58.0401130025540.6362@raven.themaw.net>
To: raven@themaw.net
Cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <4002D248.2070304@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig8E1C5834750FE2B509569C84;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com> <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
 <Pine.LNX.4.58.0401130025540.6362@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E1C5834750FE2B509569C84
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

raven@themaw.net wrote:

>On Tue, 13 Jan 2004 raven@themaw.net wrote:
>
>  
>
>>On Mon, 12 Jan 2004, Mike Waychison wrote:
>>
>>    
>>
>>>>Transparency of an autofs filesystem (as I'm calling it) is the situation
>>>>where, given a map
>>>>
>>>>/usr	/man1	server:/usr/man1
>>>>	/man2	server:/usr/man2
>>>>
>>>>where the filesystem /usr contains, say a directory lib, that needs to be
>>>>available while also seeing the automounted directories.
>>>>
>>>> 
>>>>
>>>>        
>>>>
>>>I see.  This requires direct mount triggers to do properly.  Trying to 
>>>do it with some sort of passthrough to the underlying filesystem is a 
>>>nightmare waiting to happen..
>>>
>>>      
>>>
>>So what are we saying here?
>>
>>We install triggers at /usr/man1 and /usr/man2.
>>Then suppose the map had a nobrowse option.
>>Does the trigger also take care of hiding man1 and man2?
>>
>>Is there some definition of these triggers?
>>
>>    
>>
>
>And I have another question concerning namespaces.
>
>Given that there may be several namespaces, each of which may or may not 
>have a trigger on this dentry, is there some sort of list of triggers?
>
>How do the triggers know who owns them?
>
>
>  
>
This is the reason I went with using distinct filesystems to perform the 
triggers.  If we use follow_link logic, we will have a reference to the 
respective vfsmount.  Dentry's themselves know nothing about the 
triggers, as the triggers just look like a mounted filesystem.   The 
vfsmount information has enough information for autofs to call a 
userspace agent through hotplug and have userspace handle the mount.  In 
effect, there is no daemon so nobody 'owns' a trigger in the same sense 
as with autofs3/4.

As far as userspace is concerned, an autofs filesystem is mounted as is 
any other filesystem.  All that is required is a proper set of mount 
options.  For example, mounting auto_home on /home is:

mount -t autofs -o maptype=indirect,mapname=auto_home auto_home /home

Whenever somebody traverses into a subdir in /home within any namespace 
this autofs filesystem has been inherited, userspace is invoked (in that 
namespace) to perform the mount.  Again, there is no 'ownership' other 
than maybe calling the namespace it resides it the 'owner', as you would 
for any other mountpoint.

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


--------------enig8E1C5834750FE2B509569C84
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAAtJIdQs4kOxk3/MRAroLAKCK3K6/m+s+4z6i9/lmUi0C8FDDuACffvD7
Urm2y6k9IR6ct5RZ8FLFKno=
=BwsR
-----END PGP SIGNATURE-----

--------------enig8E1C5834750FE2B509569C84--

