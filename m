Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbVIRQ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbVIRQ0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 12:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVIRQ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 12:26:34 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14266 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932110AbVIRQ0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 12:26:33 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: p = kmalloc(sizeof(*p), )
Date: Sun, 18 Sep 2005 19:25:24 +0300
User-Agent: KMail/1.8.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127041474.8932.4.camel@localhost.localdomain> <20050918143907.GK19626@ftp.linux.org.uk>
In-Reply-To: <20050918143907.GK19626@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181925.25112.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 September 2005 17:39, Al Viro wrote:
> On Sun, Sep 18, 2005 at 12:04:34PM +0100, Alan Cox wrote:
>  
> > Other good practice in many cases is a single routine which allocates
> > and initialises the structure and is used by all allocators of that
> > object. That removes duplicate initialisers, stops people forgetting to
> > update all cases, allows better debug and far more.
> 
> Indeed.  IMO, argument for sizeof(*p) is bullshit - "I've changed a pointer
> type and forgot to update the allocation and initialization, but this will
> magically save my arse" is missing "except that initialization will remain
> bogus" part.
> 
> I've seen a lot of bugs around bogus kmalloc+initialization, but I can't
> recall a single case when such bug would be prevented by using that form.
> If somebody has a different experience, please post pointers to changesets
> in question.

Do these qualify?

http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.1/0579.html
o Fix wrong kmalloc sizes in ixj/emu10k1 (David Chan) 

http://www.mail-archive.com/alsa-cvslog@lists.sourceforge.net/msg02483.html
Update of /cvsroot/alsa/alsa-kernel/isa
In directory sc8-pr-cvs1:/tmp/cvs-serv4034

Modified Files:
        es18xx.c cmi8330.c 
Log Message:
Fixed wrong kmalloc


After looking at output of grep -r -C10 'malloc.*sizeof' .
(epic picture) I think that maybe Alan's typechecking kmalloc
would be useful:

On Sunday 18 September 2005 14:04, Alan Cox wrote:
> If it bugs people add a kmalloc_object macro that is
> 
> #define new_object(foo, gfp) (foo *)kmalloc(sizeof(foo), (gfp))
> 
> then you can
> 
> 	x = new_object(struct frob, GFP_KERNEL)

This will emit a warning if x is not a struct frob*,
which plain kmalloc doesn't do.
--
vda
