Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264410AbUAIVbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 16:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUAIVbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 16:31:39 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:44963 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S264410AbUAIVbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 16:31:33 -0500
Date: Fri, 09 Jan 2004 16:31:19 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFF07B2.70801@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Ian Kent <raven@themaw.net>,
       autofs mailing list <autofs@linux.kernel.org>,
       "Ogden, Aaron A." <aogden@unocal.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFF1DA7.8060005@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig0BC603AFCD0DE3986BBF4C74;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <3FFC96FE.9050002@zytor.com>
 <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
 <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
 <3FFF03EA.4060603@sun.com> <3FFF07B2.70801@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0BC603AFCD0DE3986BBF4C74
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

>Mike Waychison wrote:
>  
>
>>>Special vfsmount mounted somewhere; has no superblock associated with it;
>>>attempt to step on it triggers event; normal result of that event is to
>>>get a normal mount on top of it, at which point usual chaining logics
>>>will make sure that we don't see the trap until it's uncovered by removal
>>>of covering filesystem.  Trap (and everything mounted on it, etc.) can
>>>be removed by normal lazy umount.
>>>
>>>Basically, it's a single-point analog of autofs done entirely in VFS.
>>>The job of automounter is to maintain the traps and react to events.
>>>
>>>      
>>>
>>Is there any clear advantage to doing this in the VFS other than saving
>>a superblock and a dentry/inode pair or two?
>>
>>I remember talking to you about this, and I seem to recall that these
>>mount traps would probably communicate using a struct file, so a
>>trap-user would somehow receive events about when the trap was set
>>off.   Will this communication model continue to work within a cloned
>>namespace?  What happens if the trap-client closes the file?
>>
>>    
>>
>
>The biggest issue is to ensure that the appropriate atomicity guarantees
>can be maintained.  In particular, it must be possible to umount the
>underlying filesystem and all mount traps on top of it atomically.
>Anything less will result in race conditions.
>
>	-hpa
>
>  
>
Unless I'm missing something, implementing this as a seperate filesystem 
type still has the appropriate atomicity guarantees as long as the VFS 
support complex expiry, whereby userspace would tag submounts as being 
part of the overall expiry for a base mountpoint.

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


--------------enig0BC603AFCD0DE3986BBF4C74
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//x2odQs4kOxk3/MRAmX7AJ48ewk0pgAvwtUvjNz6YMk4jVhAuACfRdBp
jfR4LzbYMcIDCHHqgolyhjQ=
=dirY
-----END PGP SIGNATURE-----

--------------enig0BC603AFCD0DE3986BBF4C74--

