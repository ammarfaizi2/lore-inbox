Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbRBMT6V>; Tue, 13 Feb 2001 14:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129269AbRBMT6L>; Tue, 13 Feb 2001 14:58:11 -0500
Received: from limes.hometree.net ([194.231.17.49]:14914 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129181AbRBMT5z>; Tue, 13 Feb 2001 14:57:55 -0500
To: linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2001 19:52:29 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <96c39t$o1g$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de>, <nn4rxz7lqy.fsf@code.and.org>
Reply-To: hps@tanstaafl.de
Subject: Re: DNS goofups galore...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james@and.org (James Antill) writes:

>"Henning P. Schmiedehausen" <hps@tanstaafl.de> writes:

>> % telnet mail.bar.org smtp
>> 220 mail.foo.org ESMTP ready
>>     ^^^^^^^^^^^^
>> 
>> This kills loop detection. Yes, it is done this way =%-) and it breaks
>> if done wrong.

> This is humour, yeh ?

No.

> I would be supprised if even sendmail assumed braindamage like the
>above.
> For instance something that is pretty common is...

>foo.example.com.         IN A 4.4.4.4
>foo.example.com.         IN MX 10 mail.example.com.
>foo.example.com.         IN MX 20 backup-mx1.example.com.

>; This is really mail.example.org.
>backup-mx1.example.com.  IN A 1.2.3.4

No. This is a misconfiguration. Yes, RFC821 is a bit rusty but as far
as I know, nothing has superseded it yet. And Section 3.7 states
clearly:

      Whenever domain names are used in SMTP only the official names are
      used, the use of nicknames or aliases is not allowed.

And the 220 Message is defined as

220 <domain>

On sendmail, this is enforced by the "k" flag in the mailer definition.

>...another is to have "farms" of mail servers (the A record for the MX
>has multiple entries).
> If it "broke" as you said, then a lot of mail wouldn't be being routed.

You're correct. A lot of mail isn't routed or just routed because the
mailers believe in the "be liberal in what you accept" policy. Or
plainly non-RFC-compliant.

There is a concept behind CNAMEs just like behind IP Fragmentation and
the NT domains. Noone stated that it is a _SANE_ concept but it is now
here and we have to live with it. CNAMES ARE NOT ALIASES.

A CNAME is a reference. It states "the canonical name of "xxxx" is
podunk.org". You write it as

xxx	IN	CNAME	podunk.org.

SMTP requests that you use the canonical name in the 220 greeting,
according to RFC 821. Everything else is misconfiguration.

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
