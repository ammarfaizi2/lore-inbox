Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTFRE4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 00:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFRE4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 00:56:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46752 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265073AbTFRE4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 00:56:36 -0400
Date: Wed, 18 Jun 2003 06:10:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support
Message-ID: <20030618051031.GZ6754@parcelfarce.linux.theplanet.co.uk>
References: <6516.1055861757@warthog.warthog> <Pine.LNX.4.44.0306172154200.5369-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306172154200.5369-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17, 2003 at 09:55:17PM -0700, Linus Torvalds wrote:
> 
> On Tue, 17 Jun 2003, David Howells wrote:
> > 
> > The attached patch adds automounting support and mountpount expiry support to
> > the VFS.
> 
> I don't think this is evil, but it looks a bit non-appropriate for now. 
> But I'd like to see Al's (and others) comments on it..

I'm not too happy with it.  If nothing else, IMO it's the wrong way to
solve the problem - if you want a bunch of filesystems look like a
single object (i.e. go together wherever we mount it, etc.), make it
a filesystem.  That would make a lot of sense, and not only for AFS.

We need a light-weight automount.  No arguments here.  But it should
be per-namespace - i.e. "I want to have <foo> mounted on /usr/barf on
demand and I have no intention to screw somebody else - somebody who
might have the same directory seen as /usr/local/debian/barf and want
<blah> mounted on demand there".

Namespace is controled by owner of that namespace.  It is a security
boundary, among other things.  And events in one namespace should not
cause mounts in another.  Yes, AFS wants an illusion of single filesystem
composed in fixed way from many pieces.  But if you want to do that,
do it right - make sure that it acts as a single chunk in mount tree.
IOW, make it look like a single filesystem.
