Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288637AbSAIAX3>; Tue, 8 Jan 2002 19:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288640AbSAIAXU>; Tue, 8 Jan 2002 19:23:20 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:47762 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288637AbSAIAXN>; Tue, 8 Jan 2002 19:23:13 -0500
Message-Id: <5.1.0.14.2.20020109001407.03063730@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 00:23:09 +0000
To: David Weinehall <tao@acc.umu.se>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: __FUNCTION__
Cc: Andrew Morton <akpm@zip.com.au>, Greg KH <greg@kroah.com>,
        jtv <jtv@xs4all.nl>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020109010424.U5235@khan.acc.umu.se>
In-Reply-To: <3C3B85E6.9634B180@zip.com.au>
 <3C3B664B.3060103@intel.com>
 <20020108220149.GA15816@kroah.com>
 <20020108235649.A26154@xs4all.nl>
 <20020108231147.GA16313@kroah.com>
 <20020108231147.GA16313@kroah.com>
 <20020109003901.T5235@khan.acc.umu.se>
 <3C3B85E6.9634B180@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:04 09/01/02, David Weinehall wrote:
>On Tue, Jan 08, 2002 at 03:51:02PM -0800, Andrew Morton wrote:
> > David Weinehall wrote:
> > > ...
> > > > Since the C99 spec does not state anything about __FUNCTION__, changing
> > > > it from the current behavior does not seem like a wise thing to do.
> > > >
> > > > Any pointers to someone to complain to, or is there no chance for
> > > > reversal?
> > >
> > > Because the want people to stop using a gcc-specific way and start
> > > using the C99-mandated way instead?! Very sane imho.
> > >
> > They shouldn't take a GNU extension which has been offered
> > for ten years and suddenly revert it, or unoptionally spit a
> > warning.  But they keep on doing this.
>
>Well, as the C standards evolve to incorporate things that gcc earlier
>had to create extensions to provide, it is reasonable that gcc, which
>after all _is_ a C-compiler (yeah, yeah, I know that gcc is GNU Compiler
>Collection or whatever, but disregard from that now, ok?!) should
>use those. Deprecating the use of the extension in one release and
>removing it from the next is something we do from time to time in the
>kernel too...
>
> > I've had large codebases which compiled just fine five years ago.
> > But with a current compiler, same codebase produces an *enormous*
> > number of warnings.  There's no switch to turn them off and going
>
>So, you:
>
>a.) Coded with a lot of gcc specific code
>[snip]
>In both cases I'd recommend fixing the code...

Why? Using a perfectly well documented extension is certainly not wrong. Or 
are you saying one shouldn't use gcc extensions?!? We should rewrite half 
the kernel then...

> > in and changing the code is clearly not an option.  The only options
>
>Huh? Most likely, your code is broken, rather than blaming the
>messenger, act properly upon the received message.

His code is not broken at all. gcc has just turned on its head. I 
absolutely agree with Andrew here that gcc shouldn't do that.

The gcc-2.96 manual which I just looked up explicitly says for __FUNCTION__:
---quote---
  The compiler automagically replaces the identifiers with a string
literal containing the appropriate name. Thus, they are neither
preprocessor macros, like `__FILE__' and `__LINE__', nor variables.
This means that they catenate with other string literals, and that they
can be used to initialize char arrays. For example

      char here[] = "Function " __FUNCTION__ " in " __FILE__;
---quota---

So now they are suddenly saying "sorry we are changing how __FUNCTION__ 
works" which is ridiculous IMO.

What is wrong with keeping __FUNCTION__ as it is?!?

Note that gcc-2.96 also supports __func__ and that has the C-99 defined 
semantics so clearly both can co-exist without a problem... Again from the 
gcc-2.96 manual:

  GNU CC also supports the magic word `__func__', defined by the ISO
standard C-99:

---quote---
      The identifier `__func__' is implicitly declared by the translator
      as if, immediately following the opening brace of each function
      definition, the declaration
           static const char __func__[] = "function-name";

      appeared, where function-name is the name of the lexically-enclosing
      function. This name is the unadorned name of the function.

    By this definition, `__func__' is a variable, not a string literal.
In particular, `__func__' does not catenate with other string literals.
---quote---

Taking functionality away like this seems to me (never even seen the gcc 
source) very silly.

Best regards,

         Anton

ps. Yeah, I know gcc-2.96 is not an official gcc release but I don't care. 
It works and it's the only compiler I have here to look the docs up for...


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

