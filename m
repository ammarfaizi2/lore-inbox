Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVISEyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVISEyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 00:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVISEyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 00:54:44 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:37070 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932221AbVISEyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 00:54:44 -0400
Message-ID: <432E448D.2080402@v.loewis.de>
Date: Mon, 19 Sep 2005 06:54:37 +0200
From: =?UTF-8?B?Ik1hcnRpbiB2LiBMw7Z3aXMi?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it> <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it> <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>
In-Reply-To: <4O8Oh-5jp-7@gated-at.bofh.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:
>>The specific feature I get is that when I pass a file starting
>>with <utf8sig>#! to execve, Linux will execute the file following
>>the #!. In what way do I get this feature for text in general?
>>And if I do, why is that a problem?
> 
> 
> After applying this patch it seems that "Linux" is supporting this
> marker officially in general - especially if the kernel supports it.

What makes it seem so? That binfmt_script supports a certain convention
doesn't mean that all other programs also somehow need to support that
convention - and certainly not in the same way.

> I suppose the next kernel patch is to support Win-like CR-LF sequences
> (which is not the case AFAIK).

What makes you suppose that? I have no plans to submit such a patch.

> And though scripts are usually edited/changed/"parsed"/... with an text
> editor, it is not always the case. Therefore the automatic extension to
> *all text files* (especially as the marker basically applies to all text
> files, not only scripts).
> You want to focus just on your patch and ignore the directly implied
> potential problems arising ...

Because there are no problems arising. The next time somebody submits
a patch to cat(1) to strip off UTF-8 signatures, you *then* complain
that this is the wrong thing to do, because it violates the
specification of cat.

This reasoning is just flawed: it is like saying to a web browser
developer: "don't _support_ XHTML, because there are so many tools
which use HTML 4".

> Apparently I have to repeat: If you do `cat a.txt b.txt >c.txt` where
> a.txt and b.txt have this marker, then c.txt have the marker of b.txt
> somewhere in the middle. Does this make sense in anyway?

Indeed, it does. There is nothing inherently wrong with having
the marker in the middle.

> How do I get rid of the marker in the middle transparently?

http://www.unicode.org/faq/utf_bom.html#38

>>What the editor displays as the number of "things" is up to its own.
>>The output of wc -c will always be the same as the one of ls -l,
>>as wc -c does *not* give you characters:
>>
>>       -c, --bytes
>>              print the byte counts
>>
>>You might have been thinking of 'wc -m'.
> 
> 
> It depends on the definition of "character". There are other standards
> which define "character" as "byte".

Certainly. However, you specifically talked about 'wc -c', and, in
wc(1), atleast in the implementation commonly used on Linux, characters
and bytes are not the same.

>>It depends on the editor I use, of course
> 
> 
> No, more on the OS the editor runs on.

You talked about Windows specifically. On Windows, most editors give you
the choice of chosing the line ending, and will preserve whatever line
ending they find when adding new lines to a file.

Regards,
Martin
