Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbUALWnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUALWnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:43:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:40642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262731AbUALWm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:42:58 -0500
Date: Mon, 12 Jan 2004 14:39:43 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: akpm@osdl.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH(s)][RFC] variable size and signedness issues in ldt.c -
 potential problem?
Message-Id: <20040112143943.53719a02.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0401122318160.2130@jju_lnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC074AFBC9@difpst1a.dif.dk>
	<Pine.LNX.4.58.0401090440180.27298@devserv.devel.redhat.com>
	<Pine.LNX.4.56.0401110300080.13633@jju_lnx.backbone.dif.dk>
	<Pine.LNX.4.56.0401122243270.2130@jju_lnx.backbone.dif.dk>
	<20040112141350.085d32dc.akpm@osdl.org>
	<Pine.LNX.4.56.0401122318160.2130@jju_lnx.backbone.dif.dk>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004 23:20:23 +0100 (CET) Jesper Juhl <juhl-lkml@dif.dk> wrote:

| 
| On Mon, 12 Jan 2004, Andrew Morton wrote:
| 
| > Jesper Juhl <juhl-lkml@dif.dk> wrote:
| > >
| > >
| > > >
| > > > -static int read_ldt(void __user * ptr, unsigned long bytecount)
| > > > +static int read_ldt(void __user *ptr, unsigned long bytecount)
| > > >  {
| > > >  	int err, i;
| > > >  	unsigned long size;
| > > > +	unsigned long bytes;
| > > >  	struct mm_struct * mm = current->mm;
| > > >
| > > >  	if (!mm->context.size)
| > > > @@ -144,7 +145,7 @@ static int read_ldt(void __user * ptr, u
| > > >  	__flush_tlb_global();
| > > >
| > > >  	for (i = 0; i < size; i += PAGE_SIZE) {
| > > > -		int nr = i / PAGE_SIZE, bytes;
| > > > +		int nr = i / PAGE_SIZE;
| > > >  		char *kaddr = kmap(mm->context.ldt_pages[nr]);
| > > >
| > > >  		bytes = size - i;
| > > >
| >
| > There is no additional overhead with the original code and it has the
| > advantage that the scope of `bytes' covers the minimum amount of code.  I
| > see no need to change this.
| >
| > Well.  There is a little bit of overhead of the code does:
| >
| > foo()
| > {
| > 	...
| > 	{
| > 		int i;
| > 		...
| > 	}
| > 	...
| > 	{
| > 		int i;
| > 		...
| > 	}
| > 	...
| > }
| >
| > because the compiler (some versions, at least) will use eight bytes of
| > stack rather than four.  But this is rarely a problem.
| >
| 
| Ok, I'll let it go :-)
| 
| 
| > > After creating the initial cleanup patch I've noticed several more
| > > instances of this 'bad style'. If there's any interrest in cleaning them
| > > up I'll be happy to create a patch.  Is this wanted?
| >
| > I'd say that this and the whitespace adjustments are far too trivial to be
| > raising patches at this time.
| >
| You are right, it /is/ trivial - I'll leave it alone for now.  Maybe later
| create a patch that does a more thorough cleanup and send it to the
| trivial patch monkey.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Or I can put it into the KJ patchset and just never send it onward.
That will at least get it some usage time.

BTW, if you want to stick with trivial_Rusty, that's OK with me too.
Rusty does a fine job and I'm not trying to compete with him.

--
~Randy
http://janitor.kernelnewbies.org/
