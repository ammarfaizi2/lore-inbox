Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbUKKHne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbUKKHne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUKKHne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:43:34 -0500
Received: from imap.gmx.net ([213.165.64.20]:52362 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262184AbUKKHnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:43:21 -0500
X-Authenticated: #4512188
Message-ID: <41931811.2090303@gmx.de>
Date: Thu, 11 Nov 2004 08:43:13 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041109)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1 and prev] System unuseable while writing to disk
References: <418FE968.4030300@gmx.de> <41927019.9050508@tmr.com> <41930F9C.8010308@gmx.de> <419315D7.9070308@yahoo.com.au>
In-Reply-To: <419315D7.9070308@yahoo.com.au>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig45117B3CF37BFAED1C2FF996"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45117B3CF37BFAED1C2FF996
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Prakash K. Cheemplavam wrote:
> 
>> 100  0
>>  0  0      0 774876  14532 136460    0    0     0     0 1180   436  1 
>> 0 99  0
>>  1  1      0 571740  14732 333736    0    0    32 42628 1325   633  3 
>> 43 52  2
>>  2  2      0 217812  15072 676648    0    0     0 45184 1523  1771 14 
>> 78  0  8
>>  1  2      0 220436  15072 676648    0    0     0 49664 1582  1365  9 
>> 6  0 85
>>  0  2      0  85460  15984 808012    0    0   164 73984 1487  1143 18 
>> 32  0 49
>>  0  1      0  85716  15984 808140    0    0     0 29056 1493  1381  4 
>> 6  0 90
>>  0  1      0  86100  15984 808140    0    0     0 40320 1420  1367  3 
>> 2  0 95
>>  0  1      0  86100  15984 808140    0    0     0 44416 1386   693  0 
>> 2  0 98
>>  0  1      0  86100  15984 808140    0    0     0 50304 1518  1413  5 
>> 6  0 89
>>  0  1      0  86164  15984 808140    0    0     0 28544 1452   827  1 
>> 2  0 97
>>  0  1      0  86292  15984 808140    0    0     0 35840 1386   809  1 
>> 2  0 97
>>  0  1      0  86356  15984 808140    0    0     0 37376 1450  1373  3 
>> 3  0 94
>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>> ----cpu----
>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>> sy id wa
>>  1  1      0  86484  15984 808140    0    0     0 42880 1752  2494  7 
>> 6  0 87
>>  0  1      0  86484  15984 808140    0    0     0 31872 1608  2098  7 
>> 4  0 89
>>  0  1      0  86484  15984 808140    0    0     0 45952 1530   795  1 
>> 2  0 97
>>  0  1      0  86484  15984 808140    0    0     0 44288 1515   814  0 
>> 3  0 97
>>  0  1      0  90580  15984 808140    0    0     0 29052 1471  1365  5 
>> 5  0 90
>>  1  0      0  90148  16108 809356    0    0   976  2088 1383  1319 22 
>> 11  0 67
>>  0  0      0  90148  16108 809360    0    0     4    16 1444   833 10 
>> 5 84  1
>>  0  0      0  90148  16108 809360    0    0     0     0 1256   473  0 
>> 0 100  0
>>  0  0      0  90148  16108 809360    0    0     0     0 1379   611  3 
>> 1 96  0
>>  0  0      0  90148  16108 809360    0    0     0     0 1526  2439 16 
>> 5 79  0
>>  0  0      0  90148  16164 809360    0    0     0   120 1563  1824 16 
>> 4 80  0
>>
>>
>> Beginning and end the system is idle and then I start writing down the 
>> file. During that time thunderbird gets unusable.
>>
> 
> It looks like it may be a CPU scheduler issue: Nothing needs to
> be read, no swap activity, enough free memory.

I see this behaviour with default scheduler in vanilla and with staircase...


> However, it also does look like there is a lot of CPU power free,
> which makes the cpu scheduler less likely... Maybe interrupts are
> using a lot of CPU time or latency, and that is being hidden from
> CPU time accounting.
> 
> I think Ingo did notice quite large latencies in disk interrupts,
> although whether that would be enough to make thunderbird "unusable",
> I'm not sure.

I tried preempt (inkl preempt "big kernel lock" in ck) which doesn't 
avoid above. (I don't rember whether it was better, though.)

bye,

Prakash

--------------enig45117B3CF37BFAED1C2FF996
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBkxgRxU2n/+9+t5gRAgBLAJ9Np/yVdL+jiFXAayaD6mUSh1w5LwCgvota
gnuL3FFS+l1qAKuBYOdh0zc=
=a0FD
-----END PGP SIGNATURE-----

--------------enig45117B3CF37BFAED1C2FF996--
