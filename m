Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTIMQwj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTIMQwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:52:39 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:37530 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261473AbTIMQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:52:36 -0400
X-Mailer: exmh version 2.5+CL 07/13/2001 with nmh-1.0.4
From: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>
X-emacs-edited: yes
To: Martin Diehl <lists@mdiehl.de>
cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Omnibook PCMCIA slots unusable after suspend. 
In-reply-to: Your message of "Thu, 11 Sep 2003 23:18:43 +0200."
             <Pine.LNX.4.44.0309110828490.16165-100000@notebook.home.mdiehl.de> 
X-Face: H#SM:U1U-/6#NN83s6?Die557~]Dfifz~-|V:wSKGL6T-|!qk{U4/M7+k5Py!-{q=2Q/%0@
        E29yc_kQC&^
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Sat, 13 Sep 2003 17:52:09 +0100
Message-ID: <7839.1063471929@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc me as not subscribed]
On 2003-09-11 at 23:18+0200 Martin Diehl wrote:
> On Wed, 10 Sep 2003, Russell King wrote:
> 
> > On Wed, Sep 10, 2003 at 10:22:32PM +0100, Jon Fairbairn wrote:
> > > In short: I'm using an HP Ombibook 800CT, have started using
> > > a Carbus PCMCIA network card and am losing the card after
> > > suspends.
> 
> I had a similar problem with my OB800. It turned out the
> problem is the BIOS maps the yenta memory window into
> legacy address range below 1MB.

This appears to be the correct diagnosis. I applied your
patch to 2.4.22 and the Omnibook now correctly restarts the
network after a suspend. Vielen dank!

What's the status of a patch like this? It's obviously of
use to more than one person, and it took me a great deal of
time to find you and your solution -- I suspect fainter
hearted folk might just have given up and said "Linux
doesn't work with this combination of hardware" which would
have been a shame.

I haven't tried it with 2.6 yet; I don't normally get into
test kernels, but I might try out of curiosity. I'll post
the result if anyone indicates that it's a worthwhile thing
to do.

> Yep, this is what happens fo me in the sitation above. And
> the next time one inserts/ejects any card the box dies in
> interrupt storm because the irq cannot be acknoledged.

I think I got that too, at least, reinserting the card caused
a lockup.  With the patch applied I can eject and reinsert,
which is fortunate because there seems to be another problem
where the card switches off when I switch VCs, but it's hard
to reproduce. (and inconvenient because /usr is on nfs on
this machine)

  Thanks again,

   Jón


-- 
Jón Fairbairn


