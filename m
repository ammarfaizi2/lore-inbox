Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWEYHLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWEYHLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWEYHLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:11:14 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:15407 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965060AbWEYHLN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:11:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HXnAdtTNieaR7149Eycsu9NgDT6gd6hXLTYG4mQ7FxnMsggC/wo4gPWWrYrNasHxdwVx49YMfvpM1ECHJF2mbH/R7FAbBcY8flkbNIncARw3uGLY7Khvtpl7p2AZteU5hxT4hR3DXOwvKV2dZ2aR8NhR3hL2/WnsgRNtUQ5A0Lc=
Message-ID: <aec7e5c30605250011y35f295a0rf15e152910e98b94@mail.gmail.com>
Date: Thu, 25 May 2006 16:11:12 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 01/03] kexec: Avoid overwriting the current pgd (V2, stubs)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m1bqtmsosw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524044237.14219.15615.sendpatchset@cherry.local>
	 <m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
	 <1148528742.5793.135.camel@localhost>
	 <m1bqtmsosw.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Magnus Damm <magnus@valinux.co.jp> writes:
> > On Wed, 2006-05-24 at 20:41 -0600, Eric W. Biederman wrote:
> >> Magnus Damm <magnus@valinux.co.jp> writes:
> >>
> >> > --===============059810052910035161==
> >> >
> >> > kexec: Avoid overwriting the current pgd (V2, stubs)
> >> >
> >> > This patch adds an architecture specific structure "struct kimage_arch" to
> >> > struct kimage. This structure is filled in with members by the architecture
> >> > specific patches followed by this one.
> >>
> >> You should be able to completely remove the need for this by simply
> >> adding a single additional external variable to the control code
> >> page.  Given that you abuse this information and store way more
> >> than you need I am not persuaded that it is an interesting case.
> >
> > I'm sorry, but I do not understand. Care to explain a bit more, maybe
> > with some examples?
>
> I believe I gave a complete explanation the first round.
>
> By having an extra extern variable you can export the offset of
> a variable on the control code page, or what you need to compute
> the offset.

You explained some things last round, but there were still some
questions left open. The main question was regarding "additional
protection".

I'd be happy to change to code into something that you would feel
comfortable with, I just like to understand why. Having a
per-architecture data area in struct kimage is by far the simplest way
IMO.

> > Also, I get the impression that you dislike my patches. I'd like to work
> > with you and the community to merge my patches, but for that to happen
> > I'd appreciate if we both kept the language on a professional level.
>
> Yes. I dislike your patches, but I don't dislike what you are trying to do.

That's one good thing at least I guess. =)

> Part of the reason is you do more than one thing at a time, which makes
> review much more difficult than it needs to be.

Yeah, I know. I'm sorry about that. I took some time to split the
patches in the most logical way I could think of. The reason behind
not separating the segment code and the page_table_a code was that
they both touched more or less the same lines.

Let's figure out _what_ you want to merge, then let us decide in what
order to merge it. If we end up with more than 0 things to do then I'd
be happy to help out implementing them one by one.

> > Next time, please try to avoid strong words such as "abuse", "horrible"
> > and "ridiculous".
>
> I call them as I see them, and probably if I am a little frustrated I
> may be a little more extreme.  Usually I find that I have too much
> implied content and don't explain why I consider something abuse
> for example.

Right. And I get offended by the strong works which is bad.
I think we both should try to stay cool, otherwise this will go nowhere.

> In the above quoted section I figure it is abuse to place what only needs
> to be an array of local variables in a global structure.

And by global structure you mean the dynamically allocated struct
kimage? If you find that abusive then I think that _not_ using an
already existing structure is abusive. =)

I just want to keep things as simple as possible.

Thanks for your comments!

/ magnus
