Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVIQMxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVIQMxM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVIQMxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:53:12 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:32723 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750786AbVIQMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:53:11 -0400
Message-ID: <432C11B3.8080302@v.loewis.de>
Date: Sat, 17 Sep 2005 14:53:07 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de> <20050917122828.GA4103@ucw.cz>
In-Reply-To: <20050917122828.GA4103@ucw.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Agreed. On the other hand, in all these languages you can pass the encoding
> as a parameter to the interpreter, cannot you?

Not in general, no. If you have a library of multiple modules, different
modules may have different encodings. In particular, if UTF-8 in source
code becomes more common (because it is better supported than now),
people will start using it for libraries. At the same time, a lot of
code is around that still uses other encodings (typically Latin-1).
So you may have two encodings in the same program (different modules);
that's why you need the encoding declared *in* the file.

Now, there are different ways to do that: you can find language-specific
ways (such as 'use utf8;'), and this is what most languages currently
do. However, this is a nightmare for editor developers, and a severe
inconvenience for script authors - which now have to put the encoding
declaration into the files.

With the UTF-8 signature, things become much simpler: editors can
automatically detect presence of the signature, and need no
language-specific parsing. The language interpreters have a guarantee
that the signature is at the beginning of the file, so they don't
need to switch encodings in the middle of parsing. Users can configure
their editors to always write the signature for certain types of
files, and don't need to worry about putting correct encoding
declarations into the files.

>>In the future, the signature *will* carry no information. But the future
>>is, well, in the future.
>>
>>I just can't understand why (some) people are so opposed to this patch.
> 
> 
> Occam's razor?

Probably not literally, as we are not searching for an explanation of
some phenomenon. You are probably suggesting that people dislike the
feature because they see no need for it (as one poster stated it:
I don't use UTF-8, so I don't want that feature).

However, I do believe there is a need for the feature, and that
the gains by far outweigh the costs.

Regards,
Martin
