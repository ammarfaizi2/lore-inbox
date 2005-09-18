Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVIRAxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVIRAxf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 20:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVIRAxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 20:53:35 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:48807 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751259AbVIRAxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 20:53:34 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [Patch] Support UTF-8 scripts
To: Bernd Petrovitsch <bernd@firmix.at>,
       Martin =?ISO-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>,
       "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 18 Sep 2005 02:53:24 +0200
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it> <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EGnQr-00047F-HK@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch <bernd@firmix.at> wrote:
> On Sat, 2005-09-17 at 08:20 +0200, "Martin v. Löwis" wrote:
>> Bernd Petrovitsch wrote:
>> > On Fri, 2005-09-16 at 22:41 +0200, "Martin v. Löwis" wrote:

>> > [ Language-specific examples ]
>> > 
>> > And that's the only working way - the programming languages can actually
>> > do it because it defines the syntax and semantics of the contents
>> > anyways.
>> 
>> It works from the programming language point of view, but it is a mess
>> from the text editor point of view.
> 
> Most of the text editors have ways to markup the source files. Not even
> the various editors are able to agreen on one method for all, so why
> could the (Linux) world agree on one for all text files?

You don't need a marker for all text files, but it's legal to have a marker
for utf-8 text files (see the uniocode standard 4.0.0 section 15.9), and
it's handy to use it until you made everybody in the world convert
everything to utf-8 (but not utf-{16,32}{le,be}).

>> > With this marker you are interferign with (at least) *all* text files.
>> 
>> Hmm. What does that have to do with the patch I'm proposing? This
>> patch does *not* interfere with all text files. It is only relevant
>> for executable files starting with the #! magic.
> 
> It *does* interfere since scripts are also text files in every aspect.
> So every feature you want for "scripts" you also get for text files (and
> vice versa BTW).

If utf-8 encoded text files are text files, and text files are scripts,
and all of them shall have the same features, utf-8 encoded text files
with BOM MUST be recognized as legal scripts, too. Therefore this patch
fixes a kernel bug.

BTW: Implementing the other utf signatures from Table 15.3 is left to the
reader as an exercise.-)

> If you think "script" and "text file" are different, define both of
> them, please, otherwise a discussion is pointless.

If all text files are script files, execute this mail.

>> > And there are always tools out there which simply do not understand the
>> > generic marker and can not ignore it since these bytes are part of the
>> > file.
>> 
>> This conclusion is false. Many tools that don't understand the file
>> structure still can do their job on the files. So the fact that a tool
>> does not understand the structure does not necessarily imply that
>> the tool breaks when the structure changes.
> 
> It *may* break just because of some to-be-ignored inline marking due to
> some questionable feature.

How exactly does it break, and what is it? And why must *it* be prevented
from breaking by ignoring script signatures in valid text files?

> And *when* (not if) it breaks, it is probably cumbersome to find since
> you have pretty unprintable characters.

If your tools can't print utf-8 encoded characters, they are broken for
ISO-8859-*, too. Besides that, it's not a kernel problem.

> Let alone the confusion why the size of a file with `ls -l` is different
> from the size in the editor or a marker-aware `wc -c`.
> So IMHO either you have a clear and visible marker or you none at all.

Like e.g. the "From "-line starting each message in a mbox file? Virtually
no email client will display it. The size of email messages does differ
from it's unencoded content size, too! Off cause nobody can handle this,
and all users contantly try to kill themselfes because of that - NOT.

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
