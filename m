Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVASUMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVASUMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVASUMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:12:14 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:640 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261799AbVASUL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:11:59 -0500
Message-ID: <41EEBF15.9050700@comcast.net>
Date: Wed, 19 Jan 2005 15:12:05 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org>            <41EEABEF.5000503@comcast.net> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
In-Reply-To: <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Wed, 19 Jan 2005 13:50:23 EST, John Richard Moser said:
> 
>>Arjan van de Ven wrote:
>>
>>>>Split-out portions of PaX (and of ES) don't make sense.  
>>>
>>>they do. Somewhat. 
> 
> 
>>They do to "break all existing exploits" until someone takes 5 minutes
>>to make a slight alteration.  Only the reciprocating combinations of
>>each protection can protect the others from being exploited and create a
>>truly secure environment.
> 
> 
> OK, for those who tuned in late to the telecast of "Kernel Development Process
> for Newbies":
> 
> It *DOES NOT MATTER* that PaX and ES "don't make sense" split out into 5 or
> 6 pieces.  We merge in stuff *ALL THE TIME* in 20 or 30 chunks, where it
> doesn't make any real sense unless all 20 or 30 go in.  Just today, there was
> a 29-patch monster replacing kexec, and another 12-patcher replacing something
> else.  And I don't think anybody claims that many of those 29 patches stand
> totally by themselves. You install 25 of them, you probably don't have a working
> kexec, which is the goal of the patch series.
> 
> The point is that *each* of those 29 patches is small and self-contained enough
> to review for breakage of current stuff, elegance of coding, and so on.  Now
> let's look at grsecurity:
> 
> % wc grsecurity-2.1.0-2.6.10-200501071049.patch 
>  23539  89686 700414 grsecurity-2.1.0-2.6.10-200501071049.patch
> 
> 700K. In one patch. If PAX is available for 2.6.10 by itself, it certainly
> hasn't been posted to http://pax.grsecurity.net - that's still showing a 2.6.7
> patch.  But even there, that's a single monolithic 280K patch.  That's never
> going to get merged, simply because *nobody* can review a single patch that big.
> 

PaX is available for 2.6.10, but it's in the testing phase.  I've had
good results.

> Now look at http://www.kernel.org/pub/linux/kernel/people/arjan/execshield/.
> 4 separate hunks, the biggest is under 7K.  Other chunks of similar size
> for non-exec stack and NX support are already merged.
> 
> And why were they merged?  Because they showed up in 4-8K chunks.
>   

so you want 90-200 split out patches for GrSecurity?

> 
>>Split-out portions of PaX (and of ES) don't make sense.  ASLR can be
>>evaded pretty easily:  inject code, read %efp, find the GOT, read
>>addresses.  The NX protections can be evaded by using ret2libc.  on x86,
>>you need emulation to make an NX bit or the NX protections are useless.
>>So every part prevents every other part from being pushed gently aside.
> 
> 
> Right.  But if you *submit* them as "a chunk to add x86 emulation of an NX
> bit", "a chunk to add ASLR", "a chunk to add NX", "a chunk to do FOO with the
> vsyscall page", and so on, they might actually have a snowball's chance of
> being included.
> 
> If nothing else, the fact they're posted as different patches means each can be
> used as the anchor for a thread discussing the merits of *that* patch.  Adrian
> Bunk has been submitting patches for the last several weeks which probably
> total *well* over the size of the PAX patch.  And since they show up as
> separate patches, the non-controversial ones can sail by, the ALSA crew can
> comment when he hits an ALSA module, the filesystem people can comment when he
> hits one of their files, and so on.

ok ok ok.  I get the point:  I'm the only person in the world who can
swallow a twinkie whole, the rest of you need to chew.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7r8UhDd4aOud5P8RAg6tAJ4uWXxFSVcLhfB/QwWcBR0rTS/WKgCcD5ga
S1xb603WKqgk2Bq5/zhpSXw=
=aHEb
-----END PGP SIGNATURE-----
