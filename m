Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265101AbTFRIWP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbTFRIWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:22:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36008 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265101AbTFRIWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:22:14 -0400
Date: Wed, 18 Jun 2003 09:36:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Howells <dhowells@warthog.cambridge.redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support
Message-ID: <20030618083610.GB6754@parcelfarce.linux.theplanet.co.uk>
References: <20030618051031.GZ6754@parcelfarce.linux.theplanet.co.uk> <18851.1055922933@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18851.1055922933@warthog.warthog>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 08:55:33AM +0100, David Howells wrote:

> > We need a light-weight automount.  No arguments here.  But it should
> > be per-namespace - i.e. "I want to have <foo> mounted on /usr/barf on
> > demand and I have no intention to screw somebody else - somebody who
> > might have the same directory seen as /usr/local/debian/barf and want
> > <blah> mounted on demand there".
> 
> I don't have that intention of mucking someone else up either... But consider:
> what happens when a namespace is copied? All the automounter directories for
> autofs/amd/AFS are copied too... With the way I've come up with, this is
> irrelevant; the in-VFS automount will still work exactly the way it did until
> it is removed from that namespace. This is the way _I_ would expect things to
> work.

With your patch automount will happen on every reference to dentry.
Regardless of the namespace we are in.  
 
> I don't see that your argument is a problem... anyone who wants something
> different in their namespace is going to have to change things anyway.

And how would they do it?  You get mount triggered by stepping on dentry.
Period.  Your kern_automount() will then create a new vfsmount and slap
it on the tree.  Again, regardless of the namespace we are in / vfsmount
we are looking at / etc.

I have two namespaces.  One of them has filesystem A mounted on /usr/include.
Another - on /usr/local/include.  The first one wants /usr/include/foo1 trigger
mounting B and /usr/include/foo2 trigger mounting C.  The second one wants
/usr/local/include/foo1 trigger mounting D and /usr/local/include/foo2 not
trigger anything.

Namespaces are completely unrelated - I have them set for two different
users that happen to need some common files, but otherwise have very
different environments.  Could you describe what that "having to change
things" would involve?
