Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265955AbUGEFKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265955AbUGEFKf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 01:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265956AbUGEFKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 01:10:35 -0400
Received: from nevyn.them.org ([66.93.172.17]:12699 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265955AbUGEFKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 01:10:32 -0400
Date: Mon, 5 Jul 2004 01:10:10 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Joel Soete <soete.joel@tiscali.be>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com
Subject: Re: Some cleanup patches for: '...lvalues is deprecated'
Message-ID: <20040705051010.GA24583@nevyn.them.org>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	Joel Soete <soete.joel@tiscali.be>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
References: <40E6AC41.4050804@tiscali.be> <20040703205621.GA1640@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703205621.GA1640@ucw.cz>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 10:56:21PM +0200, Vojtech Pavlik wrote:
> On Sat, Jul 03, 2004 at 12:53:21PM +0000, Joel Soete wrote:
> > Hi Marcelo,
> > 
> > Please appolgies first for wrong presentation of previous post (that was 
> > the first and certainly the last time that I used the 'forwarding' option 
> > of this webmail interface :( ).
> > 
> > Here are some backport to clean up some warning of type: use of cast 
> > experssion
> > as lvalues is deprecated.
> > --- linux-2.4.27-rc2-pa4mm/kernel/sysctl.c.Orig	2004-06-29 
> > 09:03:42.000000000 +0200
> > +++ linux-2.4.27-rc2-pa4mm/kernel/sysctl.c	2004-06-29 
> > 10:10:31.588030256 +0200
> > @@ -890,7 +890,7 @@
> >  				if (!isspace(c))
> >  					break;
> >  				left--;
> > -				((char *) buffer)++;
> > +				buffer += sizeof(char);
> 
> This (although correct in the end) is a wrong thing to do.
> 
> It seems to look like the intention is to move the pointer by a char's
> size, however your change is equivalent to:
> 
> 	buffer += 1;
> 
> And if buffer wasn't void*, which it fortunately is, it would, unlike
> the older construction, move the pointer by a different size.
> 
> So just use
> 
> 	buffer++;
> 
> here, and the intent is then clear.

Except C does not actually allow incrementing a void pointer, since
void does not have a size.  You can't do arithmetic on one either.  GNU
C allows this as an extension.

It's actually this, IIRC:
  buffer = ((char *) buffer) + 1;

-- 
Daniel Jacobowitz
