Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265642AbUAGVNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUAGVNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:13:49 -0500
Received: from CPE0010e000064f-CM014270111571.cpe.net.cable.rogers.com ([65.49.100.253]:27621
	"EHLO CPE0010e000064f-CM014270111571.cpe.net.cable.rogers.com")
	by vger.kernel.org with ESMTP id S265642AbUAGVNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:13:16 -0500
Message-ID: <3FFC7664.5060702@waychison.com>
Date: Wed, 07 Jan 2004 16:13:08 -0500
From: Mike Waychison <mike@waychison.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFB12AD.6010000@sun.com> <3FFB223A.8000606@zytor.com> <20040106215018.GA911@sun.com> <3FFB316A.6000004@zytor.com> <20040106221502.GA7398@hockin.org> <20040106221502.GA7398@hockin.org> <3FFB34C9.5010305@zytor.com> <3FFC3187.4010004@sun.com> <3FFC481B.5030905@zytor.com>
In-Reply-To: <3FFC481B.5030905@zytor.com>
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8822B7A441EC8CD6D7C3016"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8822B7A441EC8CD6D7C3016
Content-Type: multipart/mixed;
 boundary="------------090404040501070201060308"

This is a multi-part message in MIME format.
--------------090404040501070201060308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:

> Mike Waychison wrote:
>
>> This is clearly not 'all of userspace'.  Autofs is an exception.  As 
>> is /etc/mtab.  The way I see it, automounting is a 'mount facility', 
>> as are namespaces.  The two should be made to work together.  Yes, 
>> mount(8) should probably be fixed one way or another as well due to 
>> /etc/mtab breakage. Why? Because it too is a mount facility.
>>
>> There are a couple problems inherent with namespaces.  Most of these 
>> are mount facilities that are broken such as mentioned above.  They 
>> *should* be fixed to work nicely.
>
>
> For that one needs to know how the namespaces are used, not just how 
> they are implemented.  There was a long discussion on this on #kernel 
> yesterday, by the way.
>
The one between you and viro?   I read the logs last night.  I didn't
see much discussion at all.

>> Other parts of userspace get confused with namespaces, eg: cron and 
>> atd.  These programs clearly need infrastructure added that somehow 
>> allows for arbitrary namespace joining/saving.  If you have 
>> suggestions for how we can solve this issue, please do let me know.  
>> I'm stumped :\  I'd be more than happy to discuss this with you.
>
>
> Do they?  In order for that to be a "clearly", I believe one needs to 
> understand how namespaces are used in practice.  It may not be 
> desirable or even possible; this starts getting into a policy decision.
>
Yes.  It is somewhat policy, but as it currently stands, the kernel not
being able to give userspace the option is itself quite restricting.

>> One not-so-far fetched approach would be to associate cron/at jobs 
>> with automount configurations so that a namespace can be 
>> re-constructed at runtime.
>
>
> I am not entirely sure what you mean with this, but it sounds 
> incredibly dangerous to me.
>
>
Basically, consider Plan 9 namespaces (I admit I'm no expert on Plan 9
:).  I'm told it allows one to somehow share namespaces with other users
/ processes as long as they exists.   Linux has a per-process namespace
model that (currently) doesn't allow this to happen.  Once all processes
that share a namespace die, the entire namespace ceases to exist.  In
order to 'reconstruct' a namespace, a service could somehow say: "Use
this automount configuration" (manually by creating a fresh namespace,
removing all non-essential mounts, and installing new mount-traps within
this namespace).

This of course has corner cases like the chicken and egg problem where
the configuration files have to be available in that namespace already,
but with some thought we could figure that out.  (Something similar to
the way 2.6 uses rootfs could be used to strap into this fresh
namespace, entirely from userspace).

This would in effect allow me to say "Take a snapshot of my namespace"
(this would probably require more help from individual filesystem
implementations in order to get all the mount information used) which
would dump an automount map that could later be used to lazily recreate it.

Just a thought.

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



--------------090404040501070201060308
Content-Type: application/pgp-signature;
 name="file:///tmp/nsmail.pgp"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="file:///tmp/nsmail.pgp"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi4yIChH
TlUvTGludXgpCkNvbW1lbnQ6IFVzaW5nIEdudVBHIHdpdGggRGViaWFuIC0gaHR0cDovL2Vu
aWdtYWlsLm1vemRldi5vcmcKCmlEOERCUUUvL0ZmUGRRczRrT3hrMy9NUkFqQ0tBSjlMakhJ
VU4rcUtTR1kyQWFQNWxkNFFNeHlMeHdDZEV2TTMKUWNmcmh2WE5Ga1BDS3NZR0tjTFFWSFk9
Cj15T1hGCi0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoK
--------------090404040501070201060308--

--------------enigA8822B7A441EC8CD6D7C3016
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//HZkdQs4kOxk3/MRAsyoAJ9rOF2hM8u0wEZvaZJRUp9146B9yQCfcCrT
VNjco04tug9yVf6ziwlNiM4=
=I3HS
-----END PGP SIGNATURE-----

--------------enigA8822B7A441EC8CD6D7C3016--

