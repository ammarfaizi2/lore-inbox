Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280997AbRKTJeh>; Tue, 20 Nov 2001 04:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTJe2>; Tue, 20 Nov 2001 04:34:28 -0500
Received: from elin.scali.no ([62.70.89.10]:45071 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S280997AbRKTJeM>;
	Tue, 20 Nov 2001 04:34:12 -0500
Subject: Re: Executing binaries on new filesystem
From: Terje Eggestad <terje.eggestad@scali.no>
To: Rock Gordon <rockgordon@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
In-Reply-To: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 20 Nov 2001 10:34:08 +0100
Message-Id: <1006248848.19959.4.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 2001-11-19 kl. 17:34 skrev Rock Gordon:
> All said and done, the file is with correct
> permissions (for that matter any binary that I execute
> on my filesystem has correct permissions). The only
> thing strace tells me is "bad file format". The same
> binary works perfectly elsewhere.
> 
> I don't think mmap is the problem; you don't need it
> in order to run binaries ...
> 

Yes you do. See load_elf_binary in fs/binfmt_elf.c, or
load_aout_binary in fs/binfmt_aout.c.....


> --- Terje Eggestad <terje.eggestad@scali.no> wrote:
> > On Sat, 17 Nov 2001, Rock Gordon wrote:
> > 
> > > Hi,
> > >
> > > I've written a modest filesystem for fun, it works
> > > pretty ok, but when I try to execute binaries from
> > it,
> > > bash says "cannot execute binary file" ... If I
> > copy
> > > the same binary elsewhere, it executes perfectly.
> > >
> > > Does anybody have any clue ?
> > 
> > Yes
> > 
> > keep in mind taht the kernel do demand paging of the
> > text (code) in our
> > executable, meaning that a page of code is not
> > loaded into the procs
> > memory spce (and thus phys mem) until the proc
> > actually tries to exec the
> > code page. This is one manifestation of the funny
> > term "page fault"!
> > 
> > I do belive that the current kernel uses mmap to map
> > in the exec file text
> > segment. (Even if I can hear the ice cracking under
> > my feet, never
> > actually looked at the code handling execs) but if
> > you strace anexec that
> > uses shared libs you'll note that the sh.libs are
> > mmaped into the process
> > space. (also note the MMAP_EXEC flag in the mmap(2)
> > man page).
> > 
> > 
> > TJ
> > 
> > >
> > > Regards,
> > > Rock
> > >
> > > __________________________________________________
> > > Do You Yahoo!?
> > > Find the one for you at Yahoo! Personals
> > > http://personals.yahoo.com
> > > -
> > > To unsubscribe from this list: send the line
> > "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at 
> > http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > 
> > -- 
> >
> _________________________________________________________________________
> > 
> > Terje Eggestad                 
> > terje.eggestad@scali.no
> > Scali Scalable Linux Systems    http://www.scali.com
> > 
> > Olaf Helsets Vei 6              tel:    +47 22 62 89
> > 61 (OFFICE)
> > P.O.Box 70 Bogerud                      +47 975 31
> > 574  (MOBILE)
> > N-0621 Oslo                     fax:    +47 22 62 89
> > 51
> > NORWAY
> >
> _________________________________________________________________________
> > 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Find the one for you at Yahoo! Personals
> http://personals.yahoo.com
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

