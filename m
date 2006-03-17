Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWCQU1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWCQU1v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWCQU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:27:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:48086 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751332AbWCQU1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:27:50 -0500
Date: Fri, 17 Mar 2006 21:27:49 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de, ak@muc.de,
       paulus@samba.org, mtk-manpages@gmx.net
MIME-Version: 1.0
References: <Pine.LNX.4.64.0603162140190.3618@g5.osdl.org>
Subject: =?ISO-8859-1?Q?Re:_[PATCH]_unshare:_Cleanup_up_the_sys=5Funshare_interfac?=
 =?ISO-8859-1?Q?e_before_we_are_committed.?=
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <31796.1142627269@www086.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

> On Fri, 17 Mar 2006, Michael Kerrisk wrote:
> > 
> > >  - it's all the same issues that clone() has
> > 
> > At the moment, but possibly not in the future (if one day
> > usnhare() needs a flag that has no analogue in clone()).
> 
> I don't believe that.
> 
> If we have something we might want to unshare, that implies by definition 
> that it was something we wanted to conditionally share in the first 
> place.
> 
> IOW, it ends up being something that would be a clone() flag.

I should have been a little clearer.  I was thinking of 
some orthogonal flag that would change the operation of unshare() 
itself (i.e., not some resource that was unshared, but something 
that changes how unshare() goes about its job).  It 
would not make sense to call such a flag CLONE_xxx.

> So I really do believe that there is a fundamental 1:1 between the flags. 
> They aren't just "similar". They are very fundamentally about the same 
> thing, and giving two different names to the same thing is CONFUSING.

This is your viewpoint ;-).  Actually, it cuts through to the
crux of the matter:

The existing flags are *about* the same fundamental things, 
but they *treat* those things in subtly different ways.  

I believe that sentence summarises how our viewpoints differ, 
and explains why you think the names should be the *same*, 
while I think they should better be just *similar*.

As I said in an earlier message, when I wrote my test program
I found myself getting confused about how CLONE_NEWNS worked,
even though I had just drafted a manual page that clearly
told me that CLONE_NEWNS did not reverse the clone() of the
same name.  I was CONFUSED.  (That's a "fact" ;-).)  

Maybe that is just a demonstration of the obvious: I'm not 
the sharpest tack in the box.  But my feeling is that part 
of my confusion *arose from the naming of the flags*, and
some others will be like me.  This is my belief 
about the two possible alternatives:

a) Flags with names that are *similar but not the same* 
   (CLONE_* vs UNSHARE_*) will give userland programmers what I
   think is the right clue about the reality: these flags are 
   working with the same things, but treating them somewhat 
   differently.

b) The flags have the *same* names.  This will lead *some* 
   programmers into thinking that the correspondence
   between the flags is *exact*.  But that is not so.

I believe that the first possibility is less likely to lead to 
traps (bugs) based on false understanding.  It also fits better 
with the possibility of a hypothetical "orthogonal unshare() 
flag".

Of course, I can construct a counterargument: some 
programmers will be smarter than me, and the ones who are 
like me will at least have my manual page to help them avoid 
trouble.  Nevertheless, my gut feel is that the status quo is 
an example of weak user interface design which could bear 
improvement.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
