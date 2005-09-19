Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbVISI02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbVISI02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 04:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVISI02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 04:26:28 -0400
Received: from ns.firmix.at ([62.141.48.66]:11910 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932373AbVISI01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 04:26:27 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: "\"Martin v." =?ISO-8859-1?Q?L=F6wis=22?= <martin@v.loewis.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <432E448D.2080402@v.loewis.de>
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it>
	 <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it>
	 <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it>
	 <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it>
	 <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it>
	 <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it>
	 <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it>
	 <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>
	 <432E448D.2080402@v.loewis.de>
Content-Type: text/plain; charset=UTF-8
Organization: Firmix Software GmbH
Date: Mon, 19 Sep 2005 10:26:22 +0200
Message-Id: <1127118382.1080.19.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 06:54 +0200, "Martin v. Löwis" wrote:
> Bernd Petrovitsch wrote:
> >>The specific feature I get is that when I pass a file starting
> >>with <utf8sig>#! to execve, Linux will execute the file following
> >>the #!. In what way do I get this feature for text in general?
> >>And if I do, why is that a problem?
> > 
> > After applying this patch it seems that "Linux" is supporting this
> > marker officially in general - especially if the kernel supports it.
> 
> What makes it seem so? That binfmt_script supports a certain convention
> doesn't mean that all other programs also somehow need to support that
> convention - and certainly not in the same way.

We will see how it develops. Actually the marker could be used to detect
endianness of the file if I read below URL correctly ....

> > I suppose the next kernel patch is to support Win-like CR-LF sequences
> > (which is not the case AFAIK).
> 
> What makes you suppose that? I have no plans to submit such a patch.

No need to. Other people tried already.

> This reasoning is just flawed: it is like saying to a web browser
> developer: "don't _support_ XHTML, because there are so many tools
> which use HTML 4".

No, the saying was more: "don't support XHTML since it may break HTML
compliant browsers."
For XHTML/HTML we all know that this is not the case, so the comparison
is flawed.

> > Apparently I have to repeat: If you do `cat a.txt b.txt >c.txt` where
> > a.txt and b.txt have this marker, then c.txt have the marker of b.txt
> > somewhere in the middle. Does this make sense in anyway?
> 
> Indeed, it does. There is nothing inherently wrong with having
> the marker in the middle.
> 
> > How do I get rid of the marker in the middle transparently?
> 
> http://www.unicode.org/faq/utf_bom.html#38

Thanks.
----  snip  ----
In that case, any U+FEFF occurring in the middle of the file can be
ignored, or treated as an error.
----  snip  ----
Well, this doesn't sound like an clear rule stating that it *must* be
ignored.
BTW:
----  snip  ----
Q: How I should deal with BOMs?
[...]
3. Some byte oriented protocols expect ASCII characters at the beginning
of a file. If UTF-8 is used with these protocols, use of the BOM as
encoding form signature should be avoided.
----  snip  ----
Voila. Avoid the BOM in your scripts and be done.

> > It depends on the definition of "character". There are other standards
> > which define "character" as "byte".
> 
> Certainly. However, you specifically talked about 'wc -c', and, in
> wc(1), atleast in the implementation commonly used on Linux, characters
> and bytes are not the same.

Yes, now since multi-byte character sets gets more commonly used.
However, I don't think you get this into the C standard. But we are now
far off the discussion ....

> >>It depends on the editor I use, of course
> > 
> > No, more on the OS the editor runs on.
> 
> You talked about Windows specifically. On Windows, most editors give you
> the choice of chosing the line ending, and will preserve whatever line
> ending they find when adding new lines to a file.

I belive this vor vim, emacs, etc. but I don't believe ir for the native
ones ...

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

