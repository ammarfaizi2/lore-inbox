Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUAMSre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUAMSre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:47:34 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:26362 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264942AbUAMSrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:47:16 -0500
Date: Tue, 13 Jan 2004 13:46:49 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <40043D19.3010608@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig5E7A436193FFFE5FA916DA2B;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com> <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E7A436193FFFE5FA916DA2B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

raven@themaw.net wrote:

>On Mon, 12 Jan 2004, Mike Waychison wrote:
>
>  
>
>>>Transparency of an autofs filesystem (as I'm calling it) is the situation
>>>where, given a map
>>>
>>>/usr	/man1	server:/usr/man1
>>>	/man2	server:/usr/man2
>>>
>>>where the filesystem /usr contains, say a directory lib, that needs to be
>>>available while also seeing the automounted directories.
>>>
>>> 
>>>
>>>      
>>>
>>I see.  This requires direct mount triggers to do properly.  Trying to 
>>do it with some sort of passthrough to the underlying filesystem is a 
>>nightmare waiting to happen..
>>
>>    
>>
>
>So what are we saying here?
>
>We install triggers at /usr/man1 and /usr/man2.
>Then suppose the map had a nobrowse option.
>  
>
This is a direct map.  The browse / nobrowse options do not apply to 
direct maps.

>Does the trigger also take care of hiding man1 and man2?
>
>  
>
No.  man1 and man2 appear as directories to anyone doing an lstat on 
them.  Traversing *into* them will cause filesystems to be mounted on 
them.  This appears to be similar to browsing of an indirect map at 
first, however it is a different beast.  With indirect maps, we are 
given the right to cover up /usr to help us detects stats and traversals 
into its sub-directories.  With direct entries, we don't have these 
leisure.  Everything in /usr most be accessible at all times. 

Your need for 'transparency' comes from the fact that you convert direct 
maps into indirect maps, which require the covering of /usr.

>Is there some definition of these triggers?
>
>  
>
This question is up in the air. 

I propose using a magic filesystem, whose root dentry has a follow_link 
callback defined.  When somebody walks into the filesystem, the 
follow_link is called, which does the mount onto a different dentry, and 
then forwards the original caller to the new vfsmount/dentry pair. 

HPA and Viro believe this is better done in the VFS layer directly by 
using special vfsmounts without super_blocks.  The path walking code 
would be modified to know of these 'traps' or 'triggers' natively.

Which solution is best is left as an exercise.

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


--------------enig5E7A436193FFFE5FA916DA2B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFABD0cdQs4kOxk3/MRAl02AJ9DeLf53/wgbXORk2P/11UkCKKRHgCfYQ4j
Jsl0hzwGpzEN0Cyy26d8+oc=
=6X1I
-----END PGP SIGNATURE-----

--------------enig5E7A436193FFFE5FA916DA2B--

