Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTIQXHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbTIQXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 19:07:22 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:64723 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262894AbTIQXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 19:07:19 -0400
X-Mailer: exmh version 2.5+CL 07/13/2001 with nmh-1.0.4
From: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>
X-emacs-edited: yes
To: Russell King <rmk@arm.linux.org.uk>
cc: Martin Diehl <lists@mdiehl.de>, linux-kernel@vger.kernel.org
Subject: Re: Omnibook PCMCIA slots unusable after suspend. 
In-reply-to: Your message of "Tue, 16 Sep 2003 23:56:07 BST."
             <20030916235607.H20141@flint.arm.linux.org.uk> 
X-Face: H#SM:U1U-/6#NN83s6?Die557~]Dfifz~-|V:wSKGL6T-|!qk{U4/M7+k5Py!-{q=2Q/%0@
        E29yc_kQC&^
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Thu, 18 Sep 2003 00:07:05 +0100
Message-ID: <4084.1063840025@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-09-16 at 23:56BST Russell King wrote:
> On Tue, Sep 16, 2003 at 11:13:54PM +0200, Martin Diehl wrote:
> > Of course I personally have no objections wrt. including it in the 
> > official tree. Russel, what do you think - do you want to apply it? Or 
> > shall I send it to Greg directly?
> 
> I think it would be a good idea to forward it to Greg

That might please me :-)

> > On Sat, 13 Sep 2003, Jon Fairbairn wrote:
> > > I think I got that too, at least, reinserting the card caused
> > > a lockup.  With the patch applied I can eject and reinsert,
> > > which is fortunate because there seems to be another problem
> > > where the card switches off when I switch VCs, but it's hard
> > > to reproduce. (and inconvenient because /usr is on nfs on
> > > this machine)
> > 
> > No idea - sounds strange to me. No such problem here with any of 
> > serial_cs, pcnet_cs or orinoco_cs with my ob800 (neither 2.4 nor 2.6).

I've experimented a bit more. With 2.4.22 the problem occurs
predictably if I initiate a suspend while displaying an X
console. The system resumes OK, but when I next change to a
text VC, the light goes out on the network card (and I get
swamped with log messages about nfs server not responding),
but I can clear it up by physically ejecting and reinserting
the network card. After that it's back to normal. I can't
see any clues in the logs -- as far as I can see the nfs
errors start without being preceded by any other error, and
inserting the card just brings it back up as if nothing had
been wrong.

> The following patch may help to track down this problem.
> Assuming Jon has sysfs mounted on /sys, there should be a
> bunch of files in /sys/class/pcmcia_socket/*/* - if Jon
> could get those to me after its gone wrong, it may be
> helpful.

I applied Martin's patch to 2.6.0-test5, and that seems to
solve the original problem. I also applied your patch, but
haven't had any luck getting the stuff from /sys. With
2.6.0-test5 patched like this (I didn't try it without your
patch, I'm afraid), if I initiate suspend from a text VC all
is fine, but if I initiate it from X, the machine suspends,
but when turned back on it just locks up with a blank
display. No apparent response to anything I do to the
keyboard, including magic sysrq :-(. Not mounting sysfs
doesn't change the behaviour AFAICT. 

It's not exactly a show-stopper as bracketing the apm
sequence with appropriate calls to chvt avoids it.

I haven't tried your patch with 2.4 as it doesn't have
sysfs -- or is there some way of retrofitting it?

Cheers,

  Jón


-- 
Jón Fairbairn                                 Jon.Fairbairn@cl.cam.ac.uk


