Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264362AbUD0Ve4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264362AbUD0Ve4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbUD0Ve4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:34:56 -0400
Received: from stokkie.demon.nl ([82.161.49.184]:60564 "HELO stokkie.net")
	by vger.kernel.org with SMTP id S264362AbUD0Veu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:34:50 -0400
Date: Tue, 27 Apr 2004 23:34:46 +0200 (CEST)
From: "Robert M. Stockmann" <stock@stokkie.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <Pine.LNX.4.44.0404272317390.11727-100000@hubble.stokkie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.2 (ftp://crashrecovery.org/pub/linux/amavis/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Apr 2004, Linus Torvalds wrote:

> On Tue, 27 Apr 2004, Carl-Daniel Hailfinger wrote:
> > 
> > LinuxAnt offers binary only modules without any sources. To circumvent our
> > MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
> > 
> > MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
> > LICENSE file applies");
> 
> Hey, that is interesting in itself, since playing the above kinds of games
> makes it pretty clear to everybody that any infringement was done
> wilfully. They should be talking to their lawyers about things like that.
> 
> Anyway, I suspect that rather than blacklist bad people, I'd much prefer
> to have the module tags be done as counted strings instead. It should be
> easy enough to do by just having the macro prepend a "sizeof(xxxx)" 
> thing or something.
> 
> Hmm. At least with -sdt=c99 it should be trivial, with something like
> 
> #define __MODULE_INFO(tag, name, info) \
> static struct { int len; const char value[] } \
> __module_cat(name,__LINE__) __attribute_used__ \
> __attribute__((section(".modinfo"),unused)) = \
> { sizeof(__stringify(tag) "=" info), \
> __stringify(tag) "=" info }
> 
> doing the job.
> 
> That should make it pretty easy to parse the .modinfo section too.
> 
> Linus

Its a joke anyway gcc3.x allows this to happen. As i posted on the
gcc mailinglist some time ago :

"Re: C Code mutilation by using gcc-3.3.x"
http://gcc.gnu.org/ml/gcc/2004-02/msg00313.html :
-------------------------------------------------
"
> 
> On Feb 4, 2004, at 12:01, Robert M. Stockmann wrote:
> > Whats going on here?
> 
> gcc 3.x supports C99 style of initializing of structors which was not 
> supported in 2.95.3.

To be more specific about what i am complaining about, here's a 
error message i get when doing ./configure inside ntfsprogs-1.8.4 :

checking version of gcc... 2.95.3, bad
configure: error: Please upgrade your gcc compiler to gcc-2.96+ or gcc-3+ 
version! Earlier compiler versions will NOT work as these do not support 
unnamed/annonymous structures and unions which are used heavily in linux-ntfs.
[jackson:stock]:(~/src/ntfsprogs-1.8.4)$

Aha, unnamed/annonymous structures and unions .....

Well thats briljant... in 2 years time all Open Source code will be unnamed
and anonymous in the form of propiatary .o modules, and Linus will still
be happy to deliver his /usr/src/linux/kernel subtree of the Linux
kernel source. Quite funny to see Open Source evolving by implementing
"modern" C compilers like gcc-3.x.

BTW. inside the Linux kernel source the Changes file explicitly states :

"The recommended compiler for the kernel is gcc 2.95.x (x >= 3), and it
should be used when you need absolute stability. You may use gcc 3.0.x
instead if you wish, although it may cause problems. Later versions of gcc
have not received much testing for Linux kernel compilation, and there are
almost certainly bugs (mainly, but not exclusively, in the kernel) that
will need to be fixed in order to use these compilers. In any case, using
pgcc instead of egcs or plain gcc is just asking for trouble."
-------------------------------------------------------------------------

It surely looks like the unnamed and annonymous powers of gcc-3.x finally
have reached the linux-kernel list. If you allow trash into your
gcc compilers, the resulting code and binary's are in the same
way affected. 

regards,

Robert
-- 
Robert M. Stockmann - RHCE
Network Engineer - UNIX/Linux Specialist
crashrecovery.org  stock@stokkie.net

