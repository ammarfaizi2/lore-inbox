Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbSLDTPe>; Wed, 4 Dec 2002 14:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267028AbSLDTPe>; Wed, 4 Dec 2002 14:15:34 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:998 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S267027AbSLDTPd>;
	Wed, 4 Dec 2002 14:15:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: mbm@mort.demon.co.uk
Date: Wed, 4 Dec 2002 20:22:46 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <9633612287A@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Dec 02 at 18:52, mbm@mort.demon.co.uk wrote:
> > single argument but strips trailing whitespace. NetBSD does the same as
> > Linux but passes trailing whitespace as part of the argument.
> 
> NetBSD is also broken, in that case.  Everything I ever used that
> supported #! except linux worked sensibly.  I even wrote myself
> a patch, which still applied to 2.4 fairly recently.  It's not
> perfect (has a fixed number of args to avoid allocating from the
> heap, would be easy to change), but it's functional.

Without adding support to parse " and ' it is unacceptable. I have
dozens of scripts which use argument with spaces inside... Also
all references I was able to found talks about "single optional
argument" (SCO, AIX)... Try running script containing

#! /bin/ls a b c

on your favorite system. If it will report
'/bin/ls: a b c: No such file or directory', or 
'ls: 0653-341 The file a b c does not exist', system does not split
argument on spaces. If it will talk about 'a' not found, it splits them
on spaces.

And because of I was not able to find anything in POSIX which would say
that we should do split on spaces (not that I found that we should not), 
I vote for leaving current behavior in Linux, and fixing perl manpage 
(and eventually FreeBSD, if anyone is interested) instead.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
                                                    
