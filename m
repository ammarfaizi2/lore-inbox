Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbVIRHXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbVIRHXn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 03:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbVIRHXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 03:23:43 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:6304 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751161AbVIRHXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 03:23:42 -0400
Message-ID: <432D15FA.8030100@v.loewis.de>
Date: Sun, 18 Sep 2005 09:23:38 +0200
From: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it>	 <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it>	 <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it>	 <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it>	 <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it>	 <432B2E09.9010407@v.loewis.de> <1126910730.3520.7.camel@gimli.at.home>	 <432BB59C.8060108@v.loewis.de> <1126996093.3373.21.camel@gimli.at.home>
In-Reply-To: <1126996093.3373.21.camel@gimli.at.home>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
> Most of the text editors have ways to markup the source files. Not even
> the various editors are able to agreen on one method for all, so why
> could the (Linux) world agree on one for all text files?

You are ignoring the role of standardization. People invent their own
mechanism if a standard is missing (or virtually unimplementable). For
declaring encodings, there is no standard (except of iso-2022, which
is really hard to implement correctly). Therefore, editor authors
create their own standards.

Atleast Python abstained from creating yet another standard, and instead
supports both the declarations from Emacs and vim. To some degree, it
also supports notepad (namely through the UTF-8 signature).

However, people are much more likely to agree on a technology when it
is defined by a recognized standards body. This is the case for the
UTF-8 signature, which is defined by the Unicode consortium, for
precisely this purpose. Therefore, editors *will* agree on that
mechanism, while keeping their own mechanism for the more general
problem.

>>Even for the programming language, it is a pain to implement: what
>>if you have non-ASCII characters before the pragma that declares the
>>encoding? and so on.
> 
> 
> That's the problem of the language definers who absolutely want such
> (IMHO absolutely superflous) features.

It's not the language designers who absolutely want this feature. It's
the language users. Of course, you'ld have to be a language designer to
know that fact - language users go to the language designers asking for
the feature, not to the kernel developers.

>>Hmm. What does that have to do with the patch I'm proposing? This
>>patch does *not* interfere with all text files. It is only relevant
>>for executable files starting with the #! magic.
> 
> 
> It *does* interfere since scripts are also text files in every aspect.
> So every feature you want for "scripts" you also get for text files (and
> vice versa BTW).

The specific feature I get is that when I pass a file starting
with <utf8sig>#! to execve, Linux will execute the file following
the #!. In what way do I get this feature for text in general?
And if I do, why is that a problem?

> If you think "script" and "text file" are different, define both of
> them, please, otherwise a discussion is pointless.

A script file (in the context of this discussion) is a text file
that is executable (i.e. has the appropriate subset of
S_IXUSR|S_IXGRP|S_IXOTH set), starts with #!, and has the path
name of an executable file after the #!.

More generally, a script file is a text file written in a scripting
language. A scripting language is a programming language which
supports "direct" execution of source code. So in the more
general definition, a script file does not need to start with
#!; for the context of this discussion, we should restrict
attention to files actually affected by the patch.

>>This conclusion is false. Many tools that don't understand the file
>>structure still can do their job on the files. So the fact that a tool
>>does not understand the structure does not necessarily imply that
>>the tool breaks when the structure changes.
> 
> 
> It *may* break just because of some to-be-ignored inline marking due to
> some questionable feature.

Be more specific. For what specific kind of file will cat(1) break?
Unless cat(1) has a 2GB limitation, I very much doubt it will break
(i.e. fail to do its job, "concatenate files and print on the standard
output") for any kind of input - whether this is text files, binary
files, images, sound files, HTML files. cat always does what it is
designed to do.

> Let alone the confusion why the size of a file with `ls -l` is different
> from the size in the editor or a marker-aware `wc -c`.

This is true for any UTF-8 file, or any multibyte encoding. For any
multibyte encoding, the number of bytes in the file is different from
the number of characters. That doesn't (and shouldn't) stop people from
using multi-byte encodings.

What the editor displays as the number of "things" is up to its own.
The output of wc -c will always be the same as the one of ls -l,
as wc -c does *not* give you characters:

       -c, --bytes
              print the byte counts

You might have been thinking of 'wc -m'.

>>For a Python script, I don't need to guess: It will just work.
> 
> 
> Then write a short python script (with a "#!/usr/bin/python" line at the
> start [without parameters]) natively on a Win*-system, copy it binary
> over to an arbitrary Linux system and see what's happening.

It depends on the editor I use, of course: the kernel will consider any
CR after the n as part of the interpreter name. Not sure what this has
to do with the specific patch, though.

Regards,
Martin

