Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbQLOQ2W>; Fri, 15 Dec 2000 11:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129641AbQLOQ2M>; Fri, 15 Dec 2000 11:28:12 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:15112 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129423AbQLOQ2A>;
	Fri, 15 Dec 2000 11:28:00 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Dana Lacoste" <dana.lacoste@peregrine.com>
Date: Fri, 15 Dec 2000 16:56:52 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [OT] Re: Linus's include file strategy redux
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <FBF96516CD5@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Dec 00 at 10:23, Dana Lacoste wrote:
> > On Fri, Dec 15, 2000 at 12:14:04AM +0000, Miquel van Smoorenburg wrote:
> 
> > It's the version that's in cvs, I just did an cvs update.  It's
> > been in it for ages.  If it's wrong, someone *please* correct it.
> 
> I think this is the important part.
> This subject has come up quite a few times in the past
> couple of weeks on the scyld (eepro/tulip) mailing lists.
> 
> Essentially, whatever solution is implemented MUST ensure :
> 
> 1 - glibc will work properly (the headers in /usr/include/* don't
>     change in an incompatible manner)
> 
> 2 - programs that need to compile against the current kernel MUST
>     be able to do so in a quasi-predictable manner.

Maybe you did not notice, but for months we have
/lib/modules/`uname -r`/build/include, which points to kernel headers,
and which should be used for compiling out-of-tree kernel modules
(i.e. latest vmware uses this).

If you want to use some linux-specific feature in your program, you have
two choices: (1) use standard <linux/xxx.h> from version which came with
glibc, or (2) create your personal copy of known-to-work xxx.h.
Using anything else (such as latest version of xxx.h) is known to not
work, and brokes very often. Compare existing headers between 1.2.0 and
2.4.0. They are - hmm - a bit different. Also, what if user currently
has installed 2.2.x kernel, but in future it will want to use 2.4.x, with
its new features. You have to recompile all programs because of they were 
compiled with old kernel headers? No. 

[And for example, with ncpfs you just cannot create version which works
with 2.0/2.2/2.4 using kernel headers, as API changed during time
completely. With private headers it is easy. You can also add support
into userspace without modifying Linus kernel. And after some time
you can swap API in kernel and no-one notices (modulo whether Linus will 
agree with change, but you can always ask in advance).]
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
