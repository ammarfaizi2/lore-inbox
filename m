Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbVESQCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbVESQCF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262556AbVESQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:02:05 -0400
Received: from alog0180.analogic.com ([208.224.220.195]:31395 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262501AbVESQB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:01:57 -0400
Date: Thu, 19 May 2005 11:58:58 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Schwab <schwab@suse.de>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       "Gilbert, John" <JGG@dolby.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Illegal use of reserved word in system.h
In-Reply-To: <je64xf450i.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.61.0505191150070.30960@chaos.analogic.com>
References: <2692A548B75777458914AC89297DD7DA08B0866F@bronze.dolby.net><20050518195337.GX5112@stusta.de><6EA08D88-7C67-48ED-A9EF-FEAAB92D8B8F@mac.com><20050519112840.GE5112@stusta.de><Pine.LNX.4.61.0505190734110.29439@chaos.analogic.com><1116505655.6027.45.camel@laptopd505.fenrus.org><Pine.LNX.4.61L.0505191342460.10681@blysk.ds.pg.gda.pl><Pine.LNX.4.61.0505190853310.29611@chaos.analogic.com><jeacmr5mzk.fsf@sykes.suse.de><1116512140.15866.42.camel@localhost.localdomain><Pine.LNX.4.61.0505191024110.30237@chaos.analogic.com>
 <je64xf450i.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1305716564-1116518338=:30960"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1305716564-1116518338=:30960
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 19 May 2005, Andreas Schwab wrote:

> "Richard B. Johnson" <linux-os@analogic.com> writes:
>
>> It's also hard to see what is happening in 'C'. When I execute
>> this:
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> int main(int cnt, char *argv[], char *env[], char *aux[])
>> {
>>     printf("Aux 0 =3D %s\n", aux[0]);
>> //    printf("Aux 1 =3D %s\n", aux[1]);
>> }
>
> There is no pointer to the aux table passed to main, you have to skip pas=
t
> the environment.  Also, the aux table is an array of key/value pairs.
>
>> This shows that ld-linux.so, that got called first, didn't
>> preserve the vector.
>
> It does.
>
> Andreas.

Well, the first entry is supposed to be AT_HWCAP, a number 16.
This is what I get:

long  value

0 =3D 00000020
1 =3D ffffe400
2 =3D 00000021
3 =3D ffffe000
4 =3D 00000010=09Seems to start here?
5 =3D bfebfbff=09Some bits
6 =3D 00000006=09AT_PAGESZ
7 =3D 00001000=09Correct
8 =3D 00000011=09AT_CLKTCK
9 =3D 00000064=09Correct
10 =3D 00000003
11 =3D 08048034
12 =3D 00000004
13 =3D 00000020
14 =3D 00000005
15 =3D 00000003

Nothing that makes any sense with the extra stuff in front.
I don't know where it came from.


>
> --=20
> Andreas Schwab, SuSE Labs, schwab@suse.de
> SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
> Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1305716564-1116518338=:30960--
