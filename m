Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbTFRUpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbTFRUpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 16:45:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34025 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265525AbTFRUps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 16:45:48 -0400
Date: Wed, 18 Jun 2003 21:59:45 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VFS autmounter support v2
Message-ID: <20030618205945.GD6754@parcelfarce.linux.theplanet.co.uk>
References: <27975.1055946015@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27975.1055946015@warthog.warthog>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 03:20:15PM +0100, David Howells wrote:
> 
> Hi Linus, Al,
> 
> I've revised my patch to make sure a process in one namespace doesn't change
> the topology of another namespace (kern_automount() will return an error in
> that case, as does (u)mount). As a bonus, check_mnt() has been simplified to
> take account of the namespace pointer now in vfsmount.

You _still_ don't get it.   OK, the last time: kern_automount() will
always do the same thing, no matter which namespace we are it.  It
might be OK for AFS, but it's definitely unfit for any other use.

No amount of "use of (u)mount to rearrange topology" will help here -
with your code you have dentry marked, and stepping on it (in any
namespace, in any instance of that fs in a namespace) will always do
the same thing.  And that is Wrong(tm).
