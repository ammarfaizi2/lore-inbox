Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268722AbTCCTFV>; Mon, 3 Mar 2003 14:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268724AbTCCTFV>; Mon, 3 Mar 2003 14:05:21 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:20930
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S268722AbTCCTFS>; Mon, 3 Mar 2003 14:05:18 -0500
Date: Mon, 3 Mar 2003 14:15:32 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] small tty irq race fix
In-Reply-To: <1046721965.7320.9.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303031410190.31566-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Mar 2003, Alan Cox wrote:

> 
> > 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
> > -		tty->flip.buf_num = 0;
> >  
> >  		local_irq_save(flags); // FIXME: is this safe?
> > +		tty->flip.buf_num = 0;
> 
> The other CPU can be touching these fields too surely. Its a
> useful note that the spinlocks need putting in the right spot
> but its still broken 8(

Well I only care about UP at the moment and the patch makes it right for UP
at least.  Someone with his brain around the tty locking requirements can
look at replacing the local_irq_save() (there and elsewhere as well), which
is sort of a different issue.


Nicolas

