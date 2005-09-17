Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVIQGUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVIQGUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbVIQGUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:20:16 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:34499 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750958AbVIQGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:20:15 -0400
Message-ID: <432BB59C.8060108@v.loewis.de>
Date: Sat, 17 Sep 2005 08:20:12 +0200
From: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it>	 <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it>	 <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it>	 <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it>	 <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it>	 <432B2E09.9010407@v.loewis.de> <1126910730.3520.7.camel@gimli.at.home>
In-Reply-To: <1126910730.3520.7.camel@gimli.at.home>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> On Fri, 2005-09-16 at 22:41 +0200, "Martin v. Löwis" wrote:
> [ Language-specific examples ]
> 
> And that's the only working way - the programming languages can actually
> do it because it defines the syntax and semantics of the contents
> anyways.

It works from the programming language point of view, but it is a mess
from the text editor point of view.

Even for the programming language, it is a pain to implement: what
if you have non-ASCII characters before the pragma that declares the
encoding? and so on.

> With this marker you are interferign with (at least) *all* text files.

Hmm. What does that have to do with the patch I'm proposing? This
patch does *not* interfere with all text files. It is only relevant
for executable files starting with the #! magic.

> And thus with *all* tools which "handle" those text files.

This is simply not true. My patch does not interfere with any such
tools. They continue to work just fine.

>>So you *must* use encoding declarations in some languages; the UTF-8
> 
> 
> ... if you absolutely want to use Non-ASCII characters in the source
> code. In most (if not all) of them exist a native gettext()
> interface ...

True. However, this is more tedious to use. Also, it doesn't apply to
all cases: e.g. if you have comments, documentation etc. in the source
code, gettext is no option.

Likewise, people often want to use non-ASCII in identifiers (e.g. class
Lösung); this can also only work if you know what the source encoding
is. You may argue that people just shouldn't do that, because it does
not work well, but this is not convincing: it doesn't work well because
language developers are to lazy to implement it. In fact, some languages
(C, C++, Java, C#) do support non-ASCII identifiers (atleast in their
specifications); there really isn't a good reason not to support it
in scripting languages as well.

> And there are always tools out there which simply do not understand the
> generic marker and can not ignore it since these bytes are part of the
> file.

This conclusion is false. Many tools that don't understand the file
structure still can do their job on the files. So the fact that a tool
does not understand the structure does not necessarily imply that
the tool breaks when the structure changes.

> Or another example: (Try to) start a perl/shell/... script (without
> paranmeter on the first line) which was edited on Win* and binary copied
> to a Unix system. Or at least guess what will happen ....

For a Python script, I don't need to guess: It will just work.

Regards,
Martin
