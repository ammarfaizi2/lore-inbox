Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTLJXNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTLJXNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:13:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17286 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264246AbTLJXNK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:13:10 -0500
Date: Wed, 10 Dec 2003 23:13:09 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210231309.GH4176@parcelfarce.linux.theplanet.co.uk>
References: <3FD7081D.31093.61FCFA36@localhost> <3FD72F7E.4493.6296CE66@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD72F7E.4493.6296CE66@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 02:36:46PM -0800, Kendall Bennett wrote:
 
> > In 2.7 we need to get the export list back to sanity.  Right now it's a
> > such a junkpile that speaking about even a relative stability for it... 
> > Not funny. 
> 
> You miss my point. I was talking about a single kernel version. For a 
> single kernel version, the ABI is both *published* and *stable*. Sure it 
> may not be what you consider a *clean* or *good* ABI, but it *IS* an ABI. 

The hell it is.  Change CONFIG_SMP or any number of other options and your
binary compatibility is toast.

> Given that it is a stable and published ABI for a single kernel version, 
> then what makes a kernel module different from a user program? The fact 

The utter lack of isolation in the former.  And that's a very practical
consideration - amount of efforts needed to tell whether any given bug is
in kernel or in an application is *way* less than for module vs. kernel.
Ditto for potential impact of changes on one side of "interface" upon the
other side.

Realistically there's no way to keep the module "API" fixed without a major
negative impact on kernel development, security and stability.  If somebody
has business model based on the expectation that this "API" will not be
changed whenever we find that useful - too bad, you can't possibly claim
that you had not been warned.

Again, lack of warranties regarding the module "API" is
	* deliberate
	* well-documented
	* older than binary-only modules
	* based on the very sound technical reasons

Live with it.  It's not going to change.

Of course some parts of the "API" are relatively stable; if nothing else,
we have in-tree drivers to consider whenever we make a change and well-behaving
3rd-party module won't take more efforts to update than a typical in-tree
driver.  But that's it - author of such module basically makes an educated
guess regarding the likeliness of change that would leave him in a bad
situation.  Generally, the deeper in kernel guts you play, the easier it
is to get burned.  And current set of exports goes very deep in said guts -
much deeper than it should have.

Anybody who does out-of-tree kernel work must understand the reality.
Modules are different from userland code in the ways that deeply affect
product cycle.  Pretending that there is no fundamental difference and
complaining about that difference signifies only one thing - lack of
basic research on part of complainers.  Don't pretend that you don't know
what you are getting into.
