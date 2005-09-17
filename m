Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVIQM0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVIQM0B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVIQM0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:26:01 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:50382 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751088AbVIQM0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:26:00 -0400
Message-ID: <432C0B51.704@v.loewis.de>
Date: Sat, 17 Sep 2005 14:25:53 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Mares <mj@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz>
In-Reply-To: <20050917120123.GA3095@ucw.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> This makes no sense. For a script, the shell does not care about the encoding
> at all.

I'm not (only) talking about /bin/sh. I'm primarily talking about
/usr/bin/python, /usr/bin/perl, and /usr/bin/wish. In all these
languages, the interpreter *does* care about the encoding.

1. In Python, the syntax

   u"some data"

   denotes a Unicode literal (stored internally either in UCS-2 or
   UCS-4); the literals are converted from the source encoding to
   the internal representation. This requires knowledge of the source
   encoding.

2. In Tcl, all strings are internally represented in UTF-8, and
   converted from the source encoding (which currently is inferred
   from the locale of the process executing the script).

3. In Perl, 'use utf8' declares that the encoding of the script is
   UTF-8, meaning that non-ASCII can be used in string literals,
   identifiers, and regular expressions.

> Also, currently, people use zillions of encodings, most of which have no
> signature, so introducing a signature for UTF-8 does not win anything.

This specific patch does win something: it allows to executed scripts
which start with <utf8 signature>#!

This is useful e.g. for Python, which recognizes the UTF-8 signature
as declaring the source encoding of the Python module to be UTF-8.

> In the future, most people will probably use only UTF-8, so the signature
> carries no information.

In the future, the signature *will* carry no information. But the future
is, well, in the future.

I just can't understand why (some) people are so opposed to this patch.
It is a really trivial, straight-forward change. It introduces no
policy, just a feature: you can put the UTF-8 signature in your script
file, if you want to (and your scripting language supports it). By
no means it forces you to put the UTF-8 signature in your all script
files, let alone all your text files.

Regards,
Martin
