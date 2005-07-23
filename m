Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVGWPma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVGWPma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 11:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVGWPkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 11:40:03 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:17116 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261800AbVGWPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 11:38:18 -0400
Date: Sat, 23 Jul 2005 11:38:00 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Matthew Helsley <matthltc@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: 2.6.13-rc3-mm1 (ckrm)
In-Reply-To: <1122092398.5242.326.camel@stark>
Message-ID: <Pine.LNX.4.44.0507231122550.18904-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.23.14
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > if CKRM is just extensions, I think it should be an external patch.
> > if it provides a path towards unifying the many disparate RM mechanisms
> > already in the kernel, great!
> 
> OK, so if it provides a path towards unifying these, what should happen
> to the old interfaces when they conflict with those offered by CKRM?

I don't think the name matters, as long as the RM code is simplified/unified.
that is, the only difference at first would be a change in name - 
same behavior.

> For instance, I'm considering how a per-class (re)nice setting would
> work. What should happen when the user (re)nices a process to a
> different value than the nice of the process' class? Should CKRM:

it has to behave as it does now, unless the admin has imposed some 
class structure other than the normal POSIX one (ie, nice pertains 
only to a process and is inherited by future children.)

> a) disable the old interface by
> 	i) removing it
> 	ii) return an error when CKRM is active
> 	iii) return an error when CKRM has specified a nice value for the
> process via membership in a class
> 	iv) return an error when the (re)nice value is inconsistent with the
> nice value assigned to the class

some interfaces must remain (renice), and if their behavior is implemented
via CKRM, it must, by default, act as before.  other interfaces (say 
overcommit_ratio) probably don't need to remain.

> b) trust the user, ignore the class nice value, and allow the new nice
> value

users can only nice up, and that policy needs to remain, obviously.
you appear to be asking what happens when the scope of the old mechanism
conflicts with the scope determined by admin-set CKRM classes.  I'd 
say that nicing a single process should change the nice of the whole 
class that the process is in, if any.  otherwise, it acts to rip that 
process out of the class, which is probably even less 'least surprise'.

> 	This sort of question would probably come up for any other CKRM
> "embraced-and-extended" tunables. Should they use the answer to this
> one, or would it go on a case-by-case basis?

I don't see that CKRM should play by rules different from other 
kernel improvements - preserve standard/former behavior when that 
behavior is documented (certainly nice is).  in the absense of admin-set
classes, nice would behave the same. 

all CKRM is doing here is providing a broader framework to hang the tunables
on.  it should be able to express all existing tunables in scope.

