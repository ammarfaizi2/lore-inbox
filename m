Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbUAGXrW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUAGXrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:47:22 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:57531 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S265153AbUAGXrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:47:12 -0500
Date: Wed, 07 Jan 2004 18:47:02 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <3FFC790A.3060206@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Message-id: <3FFC9A76.4070407@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig12CF335458B0A93714ACE66E;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it>
 <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com>
 <3FFC7469.3050700@sun.com> <3FFC7469.3050700@sun.com>
 <3FFC790A.3060206@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12CF335458B0A93714ACE66E
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> Mike Waychison wrote:
> 
>> To put it into perspective, the I'm calling for the following major 
>> changes:
> 
> [...]
> 
>> 2) move the loop that used to spin around and ask kernelspace if there 
>> was anything to expire into the VFS as well, where it won't be killed.
> 
> [...]
> 
>> (1) and (2) shouldn't be hard at all to do considering David Howells 
>> has done the majority of this already. (3) is needed in order to 
>> manage direct mounts properly for when they are 'covered'.  
>> Admittedly, (4) comes off as an ugly hack.
>>
>> Also, (2) was the only 'active' task the automount daemon was doing. 
>> Everything else it did can be rewritten in the form of a usermode 
>> helper that runs only when it is needed.  This simplifies the 
>> userspace code a lot.
> 
> 
> Just going by your own explanation here, #2 should not be in the kernel.
> 
> If we moving daemons into the kernel just because they won't be killed, 
> we'll have Oracle in-kernel before you know it.  Completely spurious 
> reason.
> 

You wouldn't put a bdflush daemon in userspace either would you?  The 
loop in question is just that; (overly simplified):

while (1) {
	f = ask_kernel_if_anything_looks_inactive();
	if (f) {
		try_to_umount(f);
		continue;
	} else {
		sleep(x seconds);
	}
}

My point is, if this is the only active action done by userspace, why 
open it up to being broken?

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

--------------enig12CF335458B0A93714ACE66E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//Jp7dQs4kOxk3/MRAnHVAJ0VNqJb2V4PMu24d8PS+KkhWvw5ygCglCqU
G9lvx4I2FmwtBQNzOWaY4jI=
=rxqP
-----END PGP SIGNATURE-----

--------------enig12CF335458B0A93714ACE66E--

