Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTLJVPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTLJVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:15:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11240 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263956AbTLJVPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:15:43 -0500
Date: Wed, 10 Dec 2003 21:15:41 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210211541.GF4176@parcelfarce.linux.theplanet.co.uk>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com> <3FD7081D.31093.61FCFA36@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD7081D.31093.61FCFA36@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:48:45AM -0800, Kendall Bennett wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > In fact, a user program written in 1991 is actually still likely
> > to run, if it doesn't do a lot of special things. So user programs
> > really are a hell of a lot more insulated than kernel modules,
> > which have been known to break weekly. 
> 
> IMHO (and IANAL of course), it seems a bit tenuous to me the argument 
> that just because you deliberating break compatibility at the module 
> level on a regular basis, that they are automatically derived works. 
> Clearly the module interfaces could be stabilised and published, and if 
> you consider the instance of a single kernel version in time, that module 
> ABI *is* published and *is* stable *for that version*. Just because you 
> make an active effort to change things and actively *not* document the 
> ABI other than in the source code across kernel versions, doesn't 
> automatically make a module a derived work. 

Oh, for crying out loud!  Had you ever looked at that "API"?

At least 90% of it are random functions exposing random details of internals.
Most of them are there only because some in-tree piece of code had been
"modularized".  Badly.

Due to the dumb mechanism used to export symbols, each of those layering
violations automatically becomes available to all modules.  And they outnumber
the things that could be reasonably considered as something resembling an
API.  Outnumber by order of magnitude.

The problem had been festering for almost a decade now, and external modules
also didn't help things - a lot of them contained layering violations of their
own and asked to export this, this and that.  With no explanation offered and
too little resistance met.

In 2.7 we need to get the export list back to sanity.  Right now it's a such
a junkpile that speaking about even a relative stability for it...  Not funny.
