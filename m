Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129101AbRBLTVS>; Mon, 12 Feb 2001 14:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129144AbRBLTVJ>; Mon, 12 Feb 2001 14:21:09 -0500
Received: from code.and.org ([63.113.167.33]:19332 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S129031AbRBLTUz>;
	Mon, 12 Feb 2001 14:20:55 -0500
To: hps@tanstaafl.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: DNS goofups galore...
In-Reply-To: <95ulrk$aik$1@forge.intermeta.de>
	<3A83335A.A5764CD7@transmeta.com> <968mgd$l8m$1@forge.intermeta.de>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 12 Feb 2001 14:19:01 -0500
In-Reply-To: "Henning P. Schmiedehausen"'s message of "Mon, 12 Feb 2001 12:55:41 +0000 (UTC)"
Message-ID: <nn4rxz7lqy.fsf@code.and.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" <hps@tanstaafl.de> writes:

> hpa@transmeta.com (H. Peter Anvin) writes:
> 
> >>         In other words, you do a lookup, you start with a primary lookup
> >> and then possibly a second lookup to resolve an MX or CNAME.  It's only
> >> the MX that points to a CNAME that results in yet another lookup.  An
> >> MX pointing to a CNAME is almost (almost, but not quite) as bad as a
> >> CNAME pointing to a CNAME.
> >> 
> 
> >There is no reducibility problem for MX -> CNAME, unlike the CNAME ->
> >CNAME case.
> 
> >Please explain how there is any different between an CNAME or MX pointing
> >to an A record in a different SOA versus an MX pointing to a CNAME
> >pointing to an A record where at least one pair is local (same SOA).
> 
> CNAME is the "canonical name" of a host. Not an alias. There is good
> decriptions for the problem with this in the bat book. Basically it
> breaks if your mailer expects one host on the other side (mail.foo.org) 
> and suddently the host reports as mail.bar.org). The sender is
> allowed to assume that the name reported after the "220" greeting
> matches the name in the MX. This is impossible with a CNAME:
> 
> mail.foo.org.   IN A 1.2.3.4
> mail.bar.org.   IN CNAME mail.foo.org.
> bar.org.        IN MX 10 mail.bar.org.
> 
> % telnet mail.bar.org smtp
> 220 mail.foo.org ESMTP ready
>     ^^^^^^^^^^^^
> 
> This kills loop detection. Yes, it is done this way =%-) and it breaks
> if done wrong.

 This is humour, yeh ?

 I would be supprised if even sendmail assumed braindamage like the
above.
 For instance something that is pretty common is...

foo.example.com.         IN A 4.4.4.4
foo.example.com.         IN MX 10 mail.example.com.
foo.example.com.         IN MX 20 backup-mx1.example.com.

; This is really mail.example.org.
backup-mx1.example.com.  IN A 1.2.3.4

...another is to have "farms" of mail servers (the A record for the MX
has multiple entries).
 If it "broke" as you said, then a lot of mail wouldn't be being routed.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
