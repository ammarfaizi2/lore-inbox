Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVDFSM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVDFSM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 14:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVDFSM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 14:12:59 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:51381 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262265AbVDFSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 14:12:56 -0400
Date: Wed, 6 Apr 2005 20:13:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Renate Meijer <kleuske@xs4all.nl>
Cc: jdike@karaya.com, Blaisorblade <blaisorblade@yahoo.it>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Greg KH <gregkh@suse.de>
Subject: Re: [stable] Re: [08/08] uml: va_copy fix
Message-ID: <20050406181306.GB17413@wohnheim.fh-wedel.de>
References: <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <20050406113233.GD7031@wohnheim.fh-wedel.de> <14410feafdb3a83e1ae457b93e593b81@xs4all.nl> <20050406122750.GE7031@wohnheim.fh-wedel.de> <20050406154648.GA28638@kroah.com> <c9f1f9c86f38a0dc3ff50ac93d2f9979@xs4all.nl> <20050406173336.GA17413@wohnheim.fh-wedel.de> <09119e1fa05596980af4b69fb18637fa@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09119e1fa05596980af4b69fb18637fa@xs4all.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 April 2005 19:58:06 +0200, Renate Meijer wrote:
> On Apr 6, 2005, at 7:33 PM, Jörn Engel wrote:
> >On Wed, 6 April 2005 19:29:46 +0200, Renate Meijer wrote:
> >>
> >>I think its worth the time and trouble to take this up with the gcc
> >>crowd. So if you could provide a list of things 3.3 misses, i'm sure
> >>the gcc-crowd would like it.
> >
> >If you volunteer to do work with the gcc-crowd, I can dig up some old
> >stuff and send you testcases.  Sure.
> 
> I'll volunteer. [...]

Thanks!

> Problem is, i'll be spending 5 weeks prety much scattered around 
> europe, [...]

Have fun!

Ok, here is the first testcase.  It was a real bug, even though never
submitted to Linus:

#define ASM_MACRO	\
	op;		\
#ifdef FOO		\
	op;		\
#else			\
	op;		\
#endif			\
	op;		\
	op;


The thing occurred in some entry.S or head.S, don't remember exactly
which one.  Gcc people might tell you unfriendly things about using
the _C_ preprocessor for _ASM_ code, but that's just how the kernel
code is written.

With gcc 2.95, the old preprocessor errored out on the correct line
and we had a look at the code.  With 3.x, preprocessor chewed things
and starting from "#ifdef", everything was interpreted as a comment
and ignored.

Code never worked and the real bug was papered over by more ugliness,
but stayed that way for a year until someone (me) tried to compile it
with 2.95.

Jörn

-- 
You cannot suppose that Moliere ever troubled himself to be original in the
matter of ideas. You cannot suppose that the stories he tells in his plays
have never been told before. They were culled, as you very well know.
-- Andre-Louis Moreau in Scarabouche
