Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbULRXDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbULRXDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 18:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULRXDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 18:03:12 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:42660 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261238AbULRXDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 18:03:02 -0500
Message-ID: <41C4B709.2010108@kolivas.org>
Date: Sun, 19 Dec 2004 10:02:33 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lista4@comhem.se
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, mr@ramendik.ru,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <22192287.1103280348090.JavaMail.tomcat@pne-ps1-sn1>
In-Reply-To: <22192287.1103280348090.JavaMail.tomcat@pne-ps1-sn1>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4C40A8F955487CD9BEBAE793"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4C40A8F955487CD9BEBAE793
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Voluspa wrote:
> Sorry about the delay.
> 
> On 2004-12-17 0:41:30 Andrew Morton wrote:
> 
> 
>>Can you identify the kernel release which caused the problem to start?
> 
> 
> My next mail did just that. Sort of. Somewhere between, and including, 2.6.9-
> rc1 and 2.6.9-rc1-bk4. The latter being the first functional kernel I can 
> test due to oopses and loss of keyboard in X starting from -rc1.
> 
> 
>>>with a default of nice 19 and sucks up every free CPU cycle.
>>
>>What sucks up all the CPU?  The application?  kswapd?
> 
> 
> The folding client uses all unused CPU, as it should. What kswapd does is 
> beyond my knowledge.
> 
> 
>>How much RAM, how much swap?
> 
> 
> 256 megabyte ram, about 1 gigabyte swap. You'll find more info in the next 
> section.
> 
> On 2004-12-16 8:14:44 Nick Piggin wrote:
> 
> 
>>So please, do the sysrq+m traces with a 2.6.10-rc3 kernel. Thanks.
> 
> 
> Ok, done. I can do the same with last uneffected 2.6.8.1-bk2 upon request (didn't 
> want to spam unless told to). Log from dmesg attached. Don't want to "inline" 
> it since my ISP has changed the webmail program to some POS java where I 
> have no control over the linebreaks.
> 
> Testing explanation: Cold boot. Started the folding client and waited 15 
> minutes for it to write the first checkpoint (wanted full stability). Started 
> X. Started Blender. Loaded a scene where I only use the "Sequence Editor" 
> mode.
> 
> In this mode there's a 'preview' window where you can Alt-a, for animate, and 
> watch your work in an almost real time. Overhead prevents a real, real time. 
> Here I let the animation loop until the testing is over.
> 
> What happens during animation is that my 500 1.2 meg pictures (ie 20 seconds) is 
> read from /dev/hdb - a slightly better and modern disk, fills up memory 
> and then starts using the swap partition on /dev/hda. The read from /dev/hdb 
> seems to be done only once since neither memory nor swap is released until 
> I close the scene.
> 
> The machine CPU usage, as monitored by Gkrellm, is highest during the initial 
> phase of swapping, about 50 percent (not counting the niced folding client 
> usage) and then falls to about 15 percent when all swapping is done. How 
> high it reaches during the screen freezes I don't know.
> 
> The sysrq+m snapshots were taken thusly: 1) Some seconds after the beginning of 
> swap usage. 2) When the first screen freeze began. 3) In another screen 
> freeze. 4) In the last minute of swapping, also during a screen freeze.
> 
> Total wall clock was about 3 minutes from beginning of animation to when all 
> swapping had been done and the animation was "stable".

Try disabling the swap token

echo 0 > /proc/sys/vm/swap_token_timeout

Cheers,
Con

--------------enig4C40A8F955487CD9BEBAE793
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxLcJZUg7+tp6mRURAhCYAJ9jDUQZqWS14gBE+DwgEMT8rGkhAwCePt71
2yIoDtXUA2DPDjwfRGe98z4=
=a3oI
-----END PGP SIGNATURE-----

--------------enig4C40A8F955487CD9BEBAE793--
