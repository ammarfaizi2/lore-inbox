Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVIQNdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVIQNdc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 09:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbVIQNdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 09:33:32 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:56454 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750808AbVIQNdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 09:33:31 -0400
Message-ID: <432C1B23.9090507@v.loewis.de>
Date: Sat, 17 Sep 2005 15:33:23 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de> <20050917122828.GA4103@ucw.cz> <432C11B3.8080302@v.loewis.de> <20050917130529.GA4398@ucw.cz>
In-Reply-To: <20050917130529.GA4398@ucw.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> I still think that this does solve only a completely insignificant part
> of the problem. Given the zillion existing encodings, you are able to identify
> UTF-8, leaving you with zillion-1 other encodings you are unable to deal with.

Correct. This is a special case only. The more general problem is
already solved: both Python and Perl support source encodings in
the entire zillion encodings. As I explained, this general solution,
while being general, is also not very user-friendly.

Now, why does UTF-8 deserve to be a special case? One reason is that it
has the potential to replace the entire zillion of encodings over time.
However, this can only happen if tool support for this encoding is
really good. The patch contributes a (minor) fragment to the support -
it is a small patch only.

The other reason is that UTF-8 defines its own encoding declaration,
unlike most of the other zillion-1 encodings. So naturally, an
implementation that supports UTF-8 in this way cannot extend to other
encodings. hpa suggested that ISO-2022 would be a more general
mechanism, but pointed out that it hasn't implemented widely in the
last 30 years, so it is unlikely that it will get much better support
in the next thirty years.

> I see a need for a feature which would help identify the charset of the script,
> but the patch in question obviously doesn't offer that -- it solves only a single
> special case of the problem in a completely non-systematic way. This does not
> sound right.

It's not a complete solution, but it *is* part of a general solution.
People have tried in the past to solve the general problem of "identify
the encoding of a text file", both in really general ways (iso-2022)
and in format-specific ways (perl, python). All these solutions are
tedious to use.

There is another general solution: gradually replace the zillion
encodings with a single one, namely Unicode (or, specifically, UTF-8).
This solution will only work when done gradually. Clearly, this
patch doesn't implement this solution entirely, but it contributes
to it, by making usage of UTF-8 in script files more simple. Many
more changes to other software (i.e. non-kernel changes) will be
necessary to implement this solution, as well as (obviously) changes
to existing files.

Regards,
Martin
