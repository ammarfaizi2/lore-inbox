Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbUJYMgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUJYMgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 08:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbUJYMgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 08:36:09 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:63957 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S261776AbUJYMfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 08:35:31 -0400
In-Reply-To: <20041025082910.GA17089@taniwha.stupidest.org>
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025082910.GA17089@taniwha.stupidest.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9-141439091"
Message-Id: <571A250A-2682-11D9-8AC3-000393CC2E90@iki.fi>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Timo Sirainen <tss@iki.fi>
Subject: Re: readdir loses renamed files
Date: Mon, 25 Oct 2004 15:35:23 +0300
To: Chris Wedgwood <cw@f00f.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-9-141439091
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 25.10.2004, at 11:29, Chris Wedgwood wrote:

> On Mon, Oct 25, 2004 at 04:21:57AM +0300, Timo Sirainen wrote:
>
>> My problem is that mails in a large maildir get temporarily
>> lost. This happens because readdir() never returns a file which was
>> just rename()d by another process. Either new or the old name would
>> have been fine, but it's not returned at all.
>
> i don't think there are well defined semantics for this, it's
> intrinsically hard to make it work the way you want for a number of
> reasons (and what they are depends on the underlying fs)

Thought so. Maybe reiser4 would work?

>> so I'll have to implement some extra locking anyway (so much for
>> maildir being lockless), but it would be nice to have at least one
>> OS where it works without the extra locking overhead.
>
> why do you need extra locking?  the next time the maildir is scanned
> the message(s) will appear surely?

So if I lose a file, how many times should I scan the directory again 
to know if it's really gone? And is it really worth the extra overhead 
when it's hardly ever needed? I'd rather not knowingly build software 
that works only in optimal conditions.

The test program that I had showed that the next scan didn't 
necessarily return it either. The file was sometimes lost for as long 
as 5 scans.

Of course I could just accept that messages go away and come back 
again, but it's not very nice for an IMAP server to do. Some clients 
attach metadata to messages based on their IMAP UID, so that would be 
lost.

I guess one solution would be to use one of the dnotify's replacements 
which tells which files were added, removed or renamed. Then readdir() 
would be needed only when mailbox is being opened.

--Apple-Mail-9-141439091
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (Darwin)

iD8DBQFBfPMLyUhSUUBViskRAhKYAKClG7gsHN8HXlX5oqEraOfeQ/EAWQCbBYRg
aoFz82BzGqH9TI6pCQt3q5A=
=AdpO
-----END PGP SIGNATURE-----

--Apple-Mail-9-141439091--

