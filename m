Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVIROxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVIROxb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVIROxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:53:31 -0400
Received: from ns.firmix.at ([62.141.48.66]:28037 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751108AbVIROxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:53:30 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: "\"Martin v." =?ISO-8859-1?Q?L=F6wis=22?= <martin@v.loewis.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <432D15FA.8030100@v.loewis.de>
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it>
	 <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it>
	 <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it>
	 <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it>
	 <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it>
	 <432B2E09.9010407@v.loewis.de> <1126910730.3520.7.camel@gimli.at.home>
	 <432BB59C.8060108@v.loewis.de> <1126996093.3373.21.camel@gimli.at.home>
	 <432D15FA.8030100@v.loewis.de>
Content-Type: text/plain; charset=UTF-8
Organization: http://www.firmix.at/
Date: Sun, 18 Sep 2005 16:50:55 +0200
Message-Id: <1127055055.8395.14.camel@gimli.at.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-09-18 at 09:23 +0200, "Martin v. Löwis" wrote:
[...]
> >>Hmm. What does that have to do with the patch I'm proposing? This
> >>patch does *not* interfere with all text files. It is only relevant
> >>for executable files starting with the #! magic.
> > 
> > It *does* interfere since scripts are also text files in every aspect.
> > So every feature you want for "scripts" you also get for text files (and
> > vice versa BTW).
> 
> The specific feature I get is that when I pass a file starting
> with <utf8sig>#! to execve, Linux will execute the file following
> the #!. In what way do I get this feature for text in general?
> And if I do, why is that a problem?

After applying this patch it seems that "Linux" is supporting this
marker officially in general - especially if the kernel supports it. I
suppose the next kernel patch is to support Win-like CR-LF sequences
(which is not the case AFAIK).
BTW even some standards body thinks that this is the way to go, it
raises more problems and questions than resolves anything.

> > If you think "script" and "text file" are different, define both of
> > them, please, otherwise a discussion is pointless.
> 
> A script file (in the context of this discussion) is a text file
> that is executable (i.e. has the appropriate subset of
> S_IXUSR|S_IXGRP|S_IXOTH set), starts with #!, and has the path
> name of an executable file after the #!.
> 
> More generally, a script file is a text file written in a scripting
> language. A scripting language is a programming language which
> supports "direct" execution of source code. So in the more
> general definition, a script file does not need to start with
> #!; for the context of this discussion, we should restrict
> attention to files actually affected by the patch.

And though scripts are usually edited/changed/"parsed"/... with an text
editor, it is not always the case. Therefore the automatic extension to
*all text files* (especially as the marker basically applies to all text
files, not only scripts).
You want to focus just on your patch and ignore the directly implied
potential problems arising ...

[...]
> > It *may* break just because of some to-be-ignored inline marking due to
> > some questionable feature.
> 
> Be more specific. For what specific kind of file will cat(1) break?

`cat` as such will not break (as such).

> Unless cat(1) has a 2GB limitation, I very much doubt it will break
> (i.e. fail to do its job, "concatenate files and print on the standard
> output") for any kind of input - whether this is text files, binary
> files, images, sound files, HTML files. cat always does what it is
> designed to do.

Apparently I have to repeat: If you do `cat a.txt b.txt >c.txt` where
a.txt and b.txt have this marker, then c.txt have the marker of b.txt
somewhere in the middle. Does this make sense in anyway?
How do I get rid of the marker in the middle transparently?

> > Let alone the confusion why the size of a file with `ls -l` is different
> > from the size in the editor or a marker-aware `wc -c`.
> 
> This is true for any UTF-8 file, or any multibyte encoding. For any
> multibyte encoding, the number of bytes in the file is different from
> the number of characters. That doesn't (and shouldn't) stop people from
> using multi-byte encodings.

It is different even if a pure ASCII file is marked as UTF-8.
And sure, the problem exists in general with multi-byte encodings.

> What the editor displays as the number of "things" is up to its own.
> The output of wc -c will always be the same as the one of ls -l,
> as wc -c does *not* give you characters:
> 
>        -c, --bytes
>               print the byte counts
> 
> You might have been thinking of 'wc -m'.

It depends on the definition of "character". There are other standards
which define "character" as "byte".

[...]
> > Then write a short python script (with a "#!/usr/bin/python" line at the
> > start [without parameters]) natively on a Win*-system, copy it binary
> > over to an arbitrary Linux system and see what's happening.
> 
> It depends on the editor I use, of course: the kernel will consider any

No, more on the OS the editor runs on.

> CR after the n as part of the interpreter name. Not sure what this has

ACK.

> to do with the specific patch, though.

It is not supported by the kernel. So either you remove it or you make
some compatibility hack (like an appropriate sym-link, etc.). Since the
kernel can start java classes directly, you can probably make a similar
thing for the UTF-8 stuff.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services



