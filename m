Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVASSuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVASSuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVASSuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:50:40 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:64410 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261843AbVASSuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:50:12 -0500
Message-ID: <41EEABEF.5000503@comcast.net>
Date: Wed, 19 Jan 2005 13:50:23 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <20050112205350.GM24518@redhat.com>	 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>	 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>	 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>	 <20050113082320.GB18685@infradead.org>	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>	 <1105635662.6031.35.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>	 <41EE96E7.3000004@comcast.net> <1106157152.6310.171.camel@laptopd505.fenrus.org>
In-Reply-To: <1106157152.6310.171.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
>>ES has been actively developed since it was poorly implemented in 2003.
>> PaX has been actively developed since it was poorly implemented in
>>2000.  PaX has had about 4 times longer to go from a poor
>>proof-of-concept NX emulation patch based on the plex86 announcement to
>>a full featured security system, and is written by a competant security
>>developer rather than a competant scheduler developer.
> 
> 
> I would call that an insult to Ingo.
> 

You're reading too deeply then.

> 
> 
>>Split-out portions of PaX (and of ES) don't make sense.  
> 
> 
> they do. Somewhat. 

They do to "break all existing exploits" until someone takes 5 minutes
to make a slight alteration.  Only the reciprocating combinations of
each protection can protect the others from being exploited and create a
truly secure environment.

Ingo said there's other stuff in ES that this doesn't apply to but
*shrug* again, beyond what I intended when I said that.

> 
>>ASLR can be
>>evaded pretty easily:  inject code, read %efp, find the GOT, read
>>addresses.  The NX protections can be evaded by using ret2libc.  on x86,
>>you need emulation to make an NX bit or the NX protections are useless.
> 
> 
> actually modern x86 cpus have hardware NX. 

not my point. . .
> 
> 
>>PT_GNU_STACK annoys me :P  I'm more interested in 1) PaX' full set of
>>markings (-ps for NX, -m for mprotect(), r for randmmap, x for
>>randexec), 2) getting rid of the need for anything but -m, and 3)
>>eliminating relocations.  Sometimes they don't patch GLIBC here and
>>Firefox won't load flash or Java because they're PT_GNU_STACK and don't
>>really need it (the java executables are marked, but the java plug-in
>>doesn't need PT_GNU_STACK).
> 
> 
> so remark them.

Manually.  Annoying because now I'm doing PaX AND Exec Shield markings,
but I do remark them anyway.  This wasn't meant to sound like it was a
major problem, just to be a side comment.

> 
> 
>>I guess it works on Exec Shield, but it frightens me that I have to
>>audit every library an executable uses for a PT_GNU_STACK marking to see
>>if it has an executable stack.
> 
> 
> there is lsexec which does this automatic for you based on running
> propcesses
> 

I don't want to run something potentially dangerous.  Think secret
military installation with no name and blank checks made out to nobody.
 The security has to scale up and down; it has to be useful for the home
user, for the business, and for those that don't officially exist.

> 
>>Either or if it stops an exploit; there's no "stopping an exploit
>>better," just stopping more of them and having fewer loopholes.  As I
>>understand, ES' NX approximation fails if you relieve protections on a
>>higher mapping
> 
> 
> which is REALLY rare for programs to do
> 

True, but PaX has a failsafe in PAGEEXEC, and doesn't suffer this in
SEGMEXEC.

> 
>>-- which confuses me, isn't vsyscall() a high-address
>>executable mapping, which would disable NX protection for the full
>>address space?
> 
> 
> just like PaX, execshield has to disable the vsyscall page.
> Exec-Shield actually has the code to 1) move the vsyscall page down in
> the address space and 2) randomize it per process, but that is inactive
> right now since it needs a bit of help from the VM that isn't provided
> anymore since 2.6.8 or so.
> 
> 

ah.

> 
>>PaX though gives me powerful, flexible administrative control over
>>executable space protections as a privileged resource.
>>mprotect(PROT_EXEC|PROT_WRITE) isn't something normal programs need; so
>>it's not something I allow everyone to do.
> 
> 
> it's a balance between compatibility and security. PaX strikes a
> somewhat different balance from E-S. E-S goes a long way to avoid
> breaking things that posix requires, even if they are silly and rare.
> Apps don't DO   PROT_EXEC|PROT_WRITE normally after all.. so this added
> "protect" is to a point artifical.
> 
> 

The actual threat this mitigates is that the app may be ret2libc'd to
mprotect() (possible with unrandomized ET_EXEC?), but in reality a more
complex attack can accomplish the same thing.  I prefer it more as a
speed bump to expose broken code to me or at least give me an idea of
what to audit.  If something HAS to mprotect() the stack, then I HAVE to
make sure that program is audited, or I'm just being a dumbass and
waiting to be infected with a cheap worm some scriptkiddie wrote using a
build-your-own-virus program.

> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7qvthDd4aOud5P8RAhbVAJ9Jdxp/mKByxWChjM1bQMVZaIN4JACfaJ1I
Rezv+g9BE7ezKwHB5UCvdnk=
=EEu/
-----END PGP SIGNATURE-----
