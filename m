Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270505AbTGSHE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 03:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270506AbTGSHE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 03:04:27 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:11270 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S270505AbTGSHEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 03:04:25 -0400
Date: Sat, 19 Jul 2003 09:19:19 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Michael Still <mikal@stillhq.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steve@ggi-project.org
Subject: Re: [PATCH] docbook: Added support for generating man files
Message-ID: <20030719091919.A3236@pclin040.win.tue.nl>
References: <20030719004833.A3174@pclin040.win.tue.nl> <Pine.LNX.4.44.0307191237540.1829-100000@diskbox.stillhq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0307191237540.1829-100000@diskbox.stillhq.com>; from mikal@stillhq.com on Sat, Jul 19, 2003 at 12:47:31PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 12:47:31PM +1000, Michael Still wrote:
> On Sat, 19 Jul 2003, Andries Brouwer wrote:
> 
> > Please put all legalities in comments - behind .\" we do not have to read
> > them, but they are there if anyone cares.
> 
> Ok. After having done some more poking, I can't see a way of doing this 
> with docbook2man -- there doesn't appear to be any way of emitting 
> comments. There strike me as two options here: write a script to convert 
> SGML to man pages, or perhaps just insert a single sentence into the 
> "About this Document" section which explains where to look for copyright 
> information.
> 
> Any thoughts?

You do this in two steps: first construct an sgml document, then invoke
docbook2man.

So, first you have to figure out what the proper docbook markup is
for such material. According to me it is <docinfo>...</docinfo>,
to be placed inside <refentry> before <refmeta>.
So you do that - example script fragments appended below.

Next, the docbook2man stage. My presently installed docbook2man says

# IGNORE.
sgml('<DOCINFO>', sub { push_output('nul'); });
sgml('</DOCINFO>', sub { pop_output(); });

That is, it does not produce any output for a docinfo section.
I consider that a bug in docbook2man - it should output nroff comments.
Probably this bug will be fixed sooner or later.
(I'll cc Steve Cheng who is listed as maintainer.)
In the meantime I do not worry too much about this missing copyright.

By the way, you start copying at <legalnotice>, but I consider that
the least interesting part. The fact that these docs were written
by Alan Cox is much more interesting. In other words, it might be
a good idea to enlarge this <docinfo> section a bit.

Andries


In split-man:

  elsif($mode == 2){
    if(/<refmeta>/){
      $refdata = "$refdata\n<docinfo>\n$front\n$blurb\n</docinfo>\n"
    }
    $refdata = "$refdata$_";
  }

Here $front is the original one - do not delete <legalnotice>.
And $blurb is your text:

  <authorblurb><para>
    If you have comments on the formatting of this manpage, then please contact
    Michael Still (mikal\@stillhq.com).
  </para></authorblurb>



