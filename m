Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTJWOPq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbTJWOPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 10:15:46 -0400
Received: from borg.org ([64.105.205.123]:62002 "HELO borg.org")
	by vger.kernel.org with SMTP id S263579AbTJWOPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 10:15:44 -0400
Date: Thu, 23 Oct 2003 10:15:43 -0400
From: Kent Borg <kentborg@borg.org>
To: Sandy Harris <sandy@storm.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031023101543.D6434@borg.org>
References: <3F8E552B.3010507@users.sf.net> <bn40oa$i4q$1@gatekeeper.tmr.com> <bn46q9$1rv$1@cesium.transmeta.com> <bn4aov$jf7$1@gatekeeper.tmr.com> <bn4l5q$v73$1@cesium.transmeta.com> <20031022025602.GH17713@pegasys.ws> <20031022122251.A3921@borg.org> <3F97498D.9050704@storm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F97498D.9050704@storm.ca>; from sandy@storm.ca on Thu, Oct 23, 2003 at 11:22:53AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 11:22:53AM +0800, Sandy Harris wrote:
> That's not secure; four bytes give only 2^32 = 4 billion odd
> possibilities. An enemy can easily enumerate them all as the
> start of an attack.

It depends upon whether the foe can get access to the encrypted/hashed
copy, and it depends upon the importance of the password.  For
example, what properties do you think my amazon.com password should
have?  Is a sufficiently motivated foe really likely to get access?
And what is the cost of that happening?  I think 32-bits of entropy is
quite reasonable for such uses.  Certainly for some uses, such as
encrypted communications, 32-bits is not enough, but have you tried
remembering a passphrase with, say, 128-bits of entropy?  It can be
done, but it is not easy.  And entering such a passphrase blind (with
no echo) is not easy either.  

I want normal people with normal notivations to be able to keep their
computers secure, and expecting a normal person to use such a long
passphrase not reasonable.  Let's keep the shadow file not world
readable, and then 32-bit passwords are secure.

> > -kb, the Kent who would like to see the kernel's random number
> > generator improved
> 
> I think we'd all like to see it improved if possible. The question
> is how, and why?

Actually, I think much of what I was thinking of has been done for
2.6.

> > ability to supply some initial entropy early in the
> > boot--for embedded devices
> 
> [...]
> 
> Do you think you need this before there's a file system? Why?
> Or are you thinking of boxes that don't have a file system?
> Or not writable? Not local?

I am thinking of little embedded boxes which can cobble up some
trickle of entropy once running (frequently from the network), and
probably find a place to store some, but at the very beginning of
their first boot, before opening networking or before it has been up
for long, at the point when they might want to generate ssh keys, it
would be nice to have ~some~ entropy.  One source would be to hash the
power-on contents of some of the DRAM.  Yes, I know DRAM does not come
up in a random state, but it does not come up in a predictable state
either; there *is* some entropy there.  Make a digest of a megabyte.
How many bits need vary from one boot to another (or even easier, from
one physical chip to another) to produce a useful lump of entropy?
Yes, I know that a warm boot might have no entropy in RAM contents,
but in the case of a warm boot there can be some saved entropy, and
mixing in known data does the entropy pool no harm.  And hashing a
megabyte of RAM is not that expensive, even on a slow CPU.

Maybe I am wrong about needing entropy so early, but if it is
collected before Linux boots, it needs to be stored somewhere, and it
would be nice to be able to free that space when Linux frees other
boot memory.


-kb
