Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVASSfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVASSfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVASSfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:35:46 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:16558 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261827AbVASSfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:35:16 -0500
Message-ID: <41EEA86D.7020108@comcast.net>
Date: Wed, 19 Jan 2005 13:35:25 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu>
In-Reply-To: <20050119174709.GA19520@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Ingo Molnar wrote:
> * John Richard Moser <nigelenki@comcast.net> wrote:
> 
> 
>>Split-out portions of PaX (and of ES) don't make sense. [...]
> 
> 
> which shows that you dont know the exec-shield patch at all, nor those
> split-out portions. At which point it becomes pretty pointless to 
> discuss any technical details, dont you think?
> 

I'm shoddy on ES details, but I was more remarking on the overlapping
functions between PaX and ES.

> 
>>PT_GNU_STACK annoys me :P  I'm more interested in 1) PaX' full set of
>>markings (-ps for NX, -m for mprotect(), r for randmmap, x for
>>randexec), [...]
>>
>>I guess it works on Exec Shield, but it frightens me that I have to
>>audit every library an executable uses for a PT_GNU_STACK marking to
>>see if it has an executable stack.
> 
> 
> here there are two misconceptions:
> 
> 1) you claim that the manual setting of markings is better than the
> _automatic_ setting of markings in Fedora. Manual setting is a support
> and maintainance nightmare, there can be false positives and false
> negatives as well. Also, manual setting of markings assumes code review
> or 'does this application break' type of feedback - neither is as
> reliable as automatic detection done by the compiler.

PaX has trampoline detection/emulation.  I think the toolchain spits out
libraries with -E when there's one.  It's not inherited from libraries
to the executable though; but a quick hack to trace down everything from
`ldd` or `readelf` and grab the -E would do the same thing without
giving a fully executable stack.

> 
> 2) you claim that you have to audit everything. You dont have to. It's
> all automatic. _Fedora developers_ (not you) then check the markings and
> reduce the number of executable stacks as much as possible.
> 

And a distribution maintainer could do the same with PaX.  Once it's
done it's fairly low maintenance.  I know because I've done it myself.
I can determine minimal pax markings on a given binary in about 15
seconds in most cases.

> 
>>[...] ES' NX approximation fails if you relieve protections on a
>>higher mapping-- which confuses me, isn't vsyscall() a high-address
>>executable mapping, which would disable NX protection for the full
>>address space?
> 
> 
> another misconception. Read the patch and you'll see how it's solved. 
> 

I've been told it maps vsyscall at a lower address, though didn't
remember until after I hit send.  Is this true?

> 
>>Aside from that, I just trust the PaX developer more.  He's already
>>got a more developed product; he's a security developer instead of a
>>scheduler developer; and he reads CPU manuals for breakfast. 
> 
> 
> this is your choice, and i respect it. Please show the same amount of
> respect for the choice of others as well, without badmouthing anything
> just because their choice is different from yours.
> 

I respect you as a kernel developer as long as you're doing preemption
and schedulers; but I honestly think PaX is the better technology, and I
think it's important that the best security technology be in place.  My
concerns are only with real security, and in that respect I feel that if
I didn't stand up and assert my understandings on the matter that people
may hurt themselves.  I can't put a slave collar on people and use force
feedback to control their minds, but I don't have to keep quiet either.

It doesn't much matter at this point.  If everything goes well, PaX
should show up in a fairly popular distribution soon, so we'll get to
finally see something added that this conversation lacks:  a genuine
large-scale demonstration of the deployment of PaX.  ES has that
already; but until I can see the excellence and the failings of PaX
deployed with a target on the average user as well, I can't make
assessments about which deploys better in what cases and why.

On a final note, isn't PaX the only technology trying to apply NX
protections to kernel space?  Granted, most kernel exploits aren't RCE;
but it's still a basic protection that should be in place.  Wouldn't it
be embarassing to say one day that RCE is so rare we don't need to waste
effort on kernel-level W/X separation, then the next day see an RCE
exploit?  :P  (do it murphy, do it!  >:P)  This is just a generic
observation; as I said, RCE in kernel is rare enough to not be a major
selling point, but it's still a consideration.

> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7qhthDd4aOud5P8RAkjFAJ0YGEjbpNvu2DEr7DiRicuVcWUwawCdGXV2
/CMT3w5TL7KmnsORwIB850M=
=mrQU
-----END PGP SIGNATURE-----
