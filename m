Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268023AbTAIWoB>; Thu, 9 Jan 2003 17:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268029AbTAIWoB>; Thu, 9 Jan 2003 17:44:01 -0500
Received: from splat.lanl.gov ([128.165.17.254]:13444 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S268023AbTAIWoA>; Thu, 9 Jan 2003 17:44:00 -0500
Date: Thu, 9 Jan 2003 15:52:32 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][TRIVIAL] checksum.h header fixes for 2.4
Message-ID: <20030109225232.GH3329@lanl.gov>
References: <20030109200646.GG3329@lanl.gov> <1042153307.28469.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042153307.28469.15.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-01-09 at 20:06, Eric Weigle wrote:
> > I'm making a loadable module that will send IP packets; and need to
> > do IP
> > checksums. Unfortunately a simple #include of checksum.h fails
> > because that
> > file does not itself include the headers required to compile
> > correctly.
> > Several of the arch-specific files are this way.
> Include the other files you need first. The kernel headers are not
> really intended to always include everything you might want. That
> rapidly becomes unmanagable
These files include the ipv6 and VERIFY_* stuff unconditionally. _EVERY_
caller must know to include the in6.h/uaccess.h header files simply to get
it to compile. This is what the net/checksum.h file does. There are 31 files
including <asm/checksum.h> directly, and all of these _must_ track down the
dependencies by hand.

This isn't a _want_, it's an unconditional requirement. The files are broken.

<flamebait>
Of course, it's really C's bug, by doing brain-dead textual inclusion.
Trust me, I know the difficulties in managing #includes.
</flamebait>


-Eric


-- 
------------------------------------------------------------
        Eric H. Weigle -- http://public.lanl.gov/ehw/
"They that can give up essential liberty to obtain a little
temporary safety deserve neither" -- Benjamin Franklin
------------------------------------------------------------
