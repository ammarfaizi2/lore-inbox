Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRHXBv4>; Thu, 23 Aug 2001 21:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270827AbRHXBvr>; Thu, 23 Aug 2001 21:51:47 -0400
Received: from rj.sgi.com ([204.94.215.100]:10928 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S270825AbRHXBvk>;
	Thu, 23 Aug 2001 21:51:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Will 2.6 require Python for any configuration ? (CML2) 
In-Reply-To: Your message of "Thu, 23 Aug 2001 22:52:35 GMT."
             <3b8788c0.11437523@mail.mbay.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2001 11:51:52 +1000
Message-ID: <18892.998617912@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2001 22:52:35 GMT, 
jalvo@mbay.net (John Alvord) wrote:
>ESR is awaiting the 2.5 branch and the makefile rewrite.

Wrong.  CML2 is working fine now.  CML2 runs on kernel 2.4, with or
without kbuild 2.5.  kbuild 2.5 supports CML1 and CML2 and runs on
kernel 2.4.  There are no timeline dependencies between kbuild 2.5 and
CML2, they are independent features.

As the kbuild maintainer, I have no opinion about CML2, Python etc.  I
do require several things from CML:

* Generate an accurate .config.  CML1 can and does generate
  inconsistent .config files, because the language assumes top down
  processing.  Menus break that assumption, CML2 fixes the problem,
  Alan Cox's changes to CML1 may also do so.

* Use a single parser.  CML1 uses three different parsers for
  oldconfig, menuconfig and xconfig, each parser has special cases
  which do not work on the other parsers.  CML2 uses a single parser.

* Easy to maintain and verify.  Everybody involved with CML1, including
  the current maintainer, agrees that CML1 has reached end of life.  It
  is too difficult to maintain and to verify that the rule sets give
  the desired results.  CML2's constraint handler fixes this, AC's CML1
  might, I have not looked at it.

* Easier to configure for beginners and to autoconfigure.  The list of
  configure options has grown to the point where it discourages people
  from configuring their own kernel.  WIth CML1 it is well nigh
  impossible to autoconfigure a kernel by looking at the hardware and
  deducing the config settings required.

As long as those requirements are met I do not care how .config is
created nor which language is used to build .config, display menus etc.
So far CML2 is the only code that meets the requirements.  That does
not mean that CML2 is the only possibility, nor that Python 2.0 is an
absolute requirement.  There is (or was) a work in progress to do CML2
in C instead of Python.  If somebody else comes up with CML3, the
kbuild group would look at it.

Saying that Python is a problem is just guessing at this stage.  CML2
will only be getting widespread usage in kernel 2.5, developers can
cope with installing the latest Python.  By the time 2.6 is released,
Python 2.0 will be widespread.

Until somebody actually codes a better CML, we are going with CML2.  If
you don't like CML2 or Python, do a better version instead of
complaining.  Put up or shut up.

