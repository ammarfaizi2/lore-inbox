Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbRBLM6f>; Mon, 12 Feb 2001 07:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129384AbRBLM6Z>; Mon, 12 Feb 2001 07:58:25 -0500
Received: from limes.hometree.net ([194.231.17.49]:10803 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129501AbRBLM6P>; Mon, 12 Feb 2001 07:58:15 -0500
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2001 12:55:41 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <968mgd$l8m$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de>, <3A83335A.A5764CD7@transmeta.com>
Reply-To: hps@tanstaafl.de
Subject: Re: DNS goofups galore...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa@transmeta.com (H. Peter Anvin) writes:

>>         In other words, you do a lookup, you start with a primary lookup
>> and then possibly a second lookup to resolve an MX or CNAME.  It's only
>> the MX that points to a CNAME that results in yet another lookup.  An
>> MX pointing to a CNAME is almost (almost, but not quite) as bad as a
>> CNAME pointing to a CNAME.
>> 

>There is no reducibility problem for MX -> CNAME, unlike the CNAME ->
>CNAME case.

>Please explain how there is any different between an CNAME or MX pointing
>to an A record in a different SOA versus an MX pointing to a CNAME
>pointing to an A record where at least one pair is local (same SOA).

CNAME is the "canonical name" of a host. Not an alias. There is good
decriptions for the problem with this in the bat book. Basically it
breaks if your mailer expects one host on the other side (mail.foo.org) 
and suddently the host reports as mail.bar.org). The sender is
allowed to assume that the name reported after the "220" greeting
matches the name in the MX. This is impossible with a CNAME:

mail.foo.org.   IN A 1.2.3.4
mail.bar.org.   IN CNAME mail.foo.org.
bar.org.        IN MX 10 mail.bar.org.

% telnet mail.bar.org smtp
220 mail.foo.org ESMTP ready
    ^^^^^^^^^^^^

This kills loop detection. Yes, it is done this way =%-) and it breaks
if done wrong.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
