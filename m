Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRDYVJ2>; Wed, 25 Apr 2001 17:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRDYVJR>; Wed, 25 Apr 2001 17:09:17 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:9168 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S132483AbRDYVJJ>; Wed, 25 Apr 2001 17:09:09 -0400
Message-ID: <3AE73D43.9DEAE608@kegel.com>
Date: Wed, 25 Apr 2001 14:10:27 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: /proc format (was Device Registry (DevReg) Patch 0.2.0)
In-Reply-To: <200104252056.PAA44995@tomcat.admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:
> > But one thing XML provides (potentially) is a DTD that defines meanings and formats.
> > IMHO the kernel needs something like this for /proc (though not in DTD format!).
> >
> > Has anyone ever tried to write a formal syntax for all the entries
> > in /proc?   We have bits and pieces of /proc documentation in
> > /usr/src/linux/Documentation, but nothing you could feed directly
> > into a parser generator.  It'd be neat to have a good definition for /proc
> > in the LSB, and have an LSB conformance test that could look in
> > /proc and say "Yup, all the entries there conform to the spec and can
> > be parsed properly."...
> 
> From one point of view (that of the /proc entries...) each file
> is by definition in the proper format. That format is specified
> (in the /proc interface to the driver). Using "proc_printf" is a
> specification for the output.

When two different distributions ship different forks of
the kernel source, which differ in the arguments passed to proc_printf,
which one is right?  
There's no way to tell.  That's why saying "the source is the spec" doesn't cut it.

Also, the source is not a specification a parser generator can use.

A formal spec for /proc entries maintained by e.g. the LSB is needed;
it has to be separate from the source code (to avoid forking problems),
and it should be machine-readable (so we can build parsers from it).

> That DOES NOT mean that no improvements are possible. If the formats
> used by the various modules/drivers has some variation in format from
> access to acess, then the determination of that format must also be
> included. From what I've seen (via "cat /proc/....") the files all
> have a fixed format. Sometimes the number of entries varies, but then
> the count should ALSO be included in the file (in a known place of
> course). The multi-entry files I've looked at (/proc/net) reach the
> EOF to end the list. This is not unreasonable.

Yeah, there's a general style that seems to work; it just needs to be
formalized.
 
> I'm not sure of the usefullness of the title lines that are printed. If
> looked at in raw form, yes the titles are nice. But the utilities
> that are aimed at examining the values should not have to discard them, nor
> should the drivers have to generate them.

I think they're good; they're a little bit like the XML tags you're proposing.
 
> I can live with them anyway, since they are already there.....
> 
> The biggest problem I know of is being able to retrieve structure
> in an atomic manner. Not easy (in any system, not just Linux).

Something SNMP doesn't deal well with, either.  People seem to cope,
though.

- Dan
