Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbUKSJlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbUKSJlz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 04:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbUKSJlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 04:41:55 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:12211 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261332AbUKSJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 04:41:05 -0500
Message-ID: <419DBFA7.7000705@blueyonder.co.uk>
Date: Fri, 19 Nov 2004 09:40:55 +0000
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: James Morris <jmorris@redhat.com>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
References: <Xine.LNX.4.44.0411180257300.3144-100000@thoron.boston.redhat.com> <Xine.LNX.4.44.0411180305060.3192-100000@thoron.boston.redhat.com> <20041118084449.Z14339@build.pdx.osdl.net> <419D6746.2020603@blueyonder.co.uk> <20041118231943.B14339@build.pdx.osdl.net>
In-Reply-To: <20041118231943.B14339@build.pdx.osdl.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5D86439C9872B78DC700D940"
X-OriginalArrivalTime: 19 Nov 2004 09:41:33.0058 (UTC) FILETIME=[F4415E20:01C4CE1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5D86439C9872B78DC700D940
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wright wrote:
> * Ross Kendall Axe (ross.axe@blueyonder.co.uk) wrote:
> 
>>Taking this idea further, couldn't we split unix_dgram_sendmsg into 2 
>>functions, do_unix_dgram_sendmsg and do_unix_connectionless_sendmsg (and 
>>similarly for unix_stream_sendmsg), then all we'd need is:
>>
>><pseudocode>
>>static int do_unix_dgram_sendmsg(...);
>>static int do_unix_stream_sendmsg(...);
>>static int do_unix_connectionless_sendmsg(...);
>>static int do_unix_connectional_sendmsg(...);
> 
> 
> We could probably break it down to better functions and helpers, but I'm
> not sure that's quite the breakdown.  That looks to me like an indirect
> way to pass a flag which is already encoded in the ops and sk_type.

The idea of that breakdown was to encode the semantics purely into the ops 
and mostly ignore sk_type. An alternative would be to create a couple of 
macros is_connectionless and is_stream and lump it all together in one big 
unix_sendmsg. Unfortunately, unix_sendmsg could end up a bit too large. 
IMHO, unix_{dgram,stream}_sendmsg are large as it is.

> At anyrate, for 2.6.10 the changes should be small and obvious.
> Better refactoring should be left for 2.6.11.

Agreed. I had my eye on 2.6.11 anyway.

> 
> thanks,
> -chris

Ross


--------------enig5D86439C9872B78DC700D940
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBnb+t9bR4xmappRARAi2wAJ9j7e1W+67cJEZxRB+3mqwomuALlgCgnlD9
askyxQzduUklgL76DWcDKaQ=
=frax
-----END PGP SIGNATURE-----

--------------enig5D86439C9872B78DC700D940--
