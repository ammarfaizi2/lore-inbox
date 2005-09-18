Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVIRTYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVIRTYF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 15:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVIRTYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 15:24:05 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:14732 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S932175AbVIRTYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 15:24:04 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [Patch] Support UTF-8 scripts
To: Bernd Petrovitsch <bernd@firmix.at>,
       Martin =?ISO-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 18 Sep 2005 21:23:42 +0200
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it> <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it> <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EH4lL-0001Iz-Lx@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Sun, 2005-09-18 at 09:23 +0200, "Martin v. Löwis" wrote:
> [...]
>> >>Hmm. What does that have to do with the patch I'm proposing? This
>> >>patch does *not* interfere with all text files. It is only relevant
>> >>for executable files starting with the #! magic.
>> > 
>> > It *does* interfere since scripts are also text files in every aspect.
>> > So every feature you want for "scripts" you also get for text files (and
>> > vice versa BTW).
>> 
>> The specific feature I get is that when I pass a file starting
>> with <utf8sig>#! to execve, Linux will execute the file following
>> the #!. In what way do I get this feature for text in general?
>> And if I do, why is that a problem?
> 
> After applying this patch it seems that "Linux" is supporting this
> marker officially in general - especially if the kernel supports it.

It will be the first POSIX kernel to correctly support utf-8 scripts.
It's 2005, and according to other(?) posters, this should be standard.

> I
> suppose the next kernel patch is to support Win-like CR-LF sequences
> (which is not the case AFAIK).

Maybe it should, maybe it shouldn't. If I used MAC or DOS, I'd be sure it
should.-)

> BTW even some standards body thinks that this is the way to go,

Not surprisingly the Unicode Consortium is one of them.

> it
> raises more problems and questions than resolves anything.

The problem of ow to handle BOM is solved by reading the standard.

> And though scripts are usually edited/changed/"parsed"/... with an text
> editor, it is not always the case. Therefore the automatic extension to
> *all text files* (especially as the marker basically applies to all text
> files, not only scripts).
> You want to focus just on your patch and ignore the directly implied
> potential problems arising ...

There is no problem arising from the patch, it solves one.
To solve the rest, use recode.

[...]
> Apparently I have to repeat: If you do `cat a.txt b.txt >c.txt` where
> a.txt and b.txt have this marker, then c.txt have the marker of b.txt
> somewhere in the middle. Does this make sense in anyway?
> How do I get rid of the marker in the middle transparently?

The unicode standard defines how to handle them.

>> > Let alone the confusion why the size of a file with `ls -l` is different
>> > from the size in the editor or a marker-aware `wc -c`.
>> 
>> This is true for any UTF-8 file, or any multibyte encoding. For any
>> multibyte encoding, the number of bytes in the file is different from
>> the number of characters. That doesn't (and shouldn't) stop people from
>> using multi-byte encodings.
> 
> It is different even if a pure ASCII file is marked as UTF-8.

No pure ASCII file will be marked, since a marked file will be no
ASCII file.

> And sure, the problem exists in general with multi-byte encodings.

ACK, but that's not a kernel problem nor a specific unicode problem.
Fix it by making China, Greece an Japan convert to ASCII and by making
all mathematicans stop using strange characters. All other users will
follow.

>> What the editor displays as the number of "things" is up to its own.
>> The output of wc -c will always be the same as the one of ls -l,
>> as wc -c does *not* give you characters:
>> 
>>        -c, --bytes
>>               print the byte counts
>> 
>> You might have been thinking of 'wc -m'.
> 
> It depends on the definition of "character". There are other standards
> which define "character" as "byte".

There are architectures defining a byte to be 32 bit.
They are irrelevant, too.

[...]
>> Not sure what this has
>> to do with the specific patch, though.
> 
> It is not supported by the kernel. So either you remove it or you make
> some compatibility hack (like an appropriate sym-link

-EDOESNOTWORK

#!/usr/bin/perl -T -s -w

>, etc.). Since the
> kernel can start java classes directly, you can probably make a similar
> thing for the UTF-8 stuff.

If MSDOS text files are text files are legal scripts, the kernel
should recognize [\x0D\x0A] as valid line breaks.

(The real reason would be unicode allowing NEL to be encoded as 0x0D
 or 0x0A.)

This compile-tested patch adds 32 bytes to binfmt_script:

--- ./fs/binfmt_script.c.old    2005-09-18 20:28:32.000000000 +0200
+++ ./fs/binfmt_script.c        2005-09-18 20:29:44.000000000 +0200
@@ -18,7 +18,7 @@

 static int load_script(struct linux_binprm *bprm,struct pt_regs *regs)
 {
-       char *cp, *i_name, *i_arg;
+       char *cp, *cp2, *i_name, *i_arg;
        struct file *file;
        char interp[BINPRM_BUF_SIZE];
        int retval;
@@ -47,6 +47,9 @@ static int load_script(struct linux_binp
        bprm->buf[BINPRM_BUF_SIZE - 1] = '\0';
        if ((cp = strchr(bprm->buf, '\n')) == NULL)
                cp = bprm->buf+BINPRM_BUF_SIZE-1;
+       if ((cp2 = strchr(bprm->buf, '\x0D')) != NULL
+       &&  cp2 < cp)
+               cp = cp2;
        *cp = '\0';
        while (cp > bprm->buf) {
                cp--;
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
