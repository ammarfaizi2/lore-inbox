Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUHBFT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUHBFT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 01:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266267AbUHBFT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 01:19:28 -0400
Received: from mail003.syd.optusnet.com.au ([211.29.132.144]:60574 "EHLO
	mail003.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266263AbUHBFT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 01:19:26 -0400
Message-ID: <410DCEBC.8030600@kolivas.org>
Date: Mon, 02 Aug 2004 15:18:52 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, sjiang@cs.wm.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] token based thrashing control
References: <Pine.LNX.4.58.0407301730440.9228@dhcp030.home.surriel.com> <Pine.LNX.4.58.0408010856240.13053@dhcp030.home.surriel.com> <20040801175618.711a3aac.akpm@osdl.org> <410DAC89.4000002@kolivas.org> <Pine.LNX.4.58.0408012332080.13053@dhcp030.home.surriel.com> <410DCD84.2070707@kolivas.org>
In-Reply-To: <410DCD84.2070707@kolivas.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDDAD4F44AF32328151427E49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDDAD4F44AF32328151427E49
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> Rik van Riel wrote:
> 
>> On Mon, 2 Aug 2004, Con Kolivas wrote:
>>
>>
>>> We have some results that need interpreting with contest.
>>> mem_load:
>>> Kernel    [runs]    Time    CPU%    Loads    LCPU%    Ratio
>>> 2.6.8-rc2      4    78    146.2    94.5    4.7    1.30
>>> 2.6.8-rc2t     4    318    40.9    95.2    1.3    5.13
>>>
>>> The "load" with mem_load is basically trying to allocate 110% of free 
>>> ram, so the number of "loads" although similar is not a true 
>>> indication of how much ram was handed out to mem_load. What is 
>>> interesting is that since mem_load runs continuously and constantly 
>>> asks for too much ram it seems to be receiving the token most 
>>> frequently in preference to the cc processes which are short lived. 
>>> I'd say it is quite hard to say convincingly that this is bad because 
>>> the point of this patch is to prevent swap thrash.
>>
>>
>>
>> It may be worth trying with a shorter token timeout
>> time - maybe even keeping the long ineligibility ?
> 
> 
> Give them a "refractory" bit which is set if they take the token? Next 
> time they try to take the token unset the refractory bit instead of 
> taking the token.

Or take that concept even further; Give them an absolute refractory 
period where they cannot take the token again and a relative refractory 
bit which can only be reset after the refractory period is over.

Con

--------------enigDDAD4F44AF32328151427E49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBDc68ZUg7+tp6mRURAsjMAKCHVB0gvjtC9ZIU00SIfdKvawD8kwCeKxSp
CY3PgDqv5FgLbO0/S+cqiP4=
=5mha
-----END PGP SIGNATURE-----

--------------enigDDAD4F44AF32328151427E49--
