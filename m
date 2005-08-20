Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbVHTDBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbVHTDBh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 23:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbVHTDBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 23:01:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:34951 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932638AbVHTDBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 23:01:36 -0400
Date: Fri, 19 Aug 2005 20:01:17 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
Message-ID: <20050820030117.GA775@kroah.com>
References: <200508201050.51982.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508201050.51982.phillips@istop.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2005 at 10:50:51AM +1000, Daniel Phillips wrote:
> Hi Joel,
> 
> Permissions set on ConfigFS attributes (aka files) do not stick.

The recent changes to sysfs should be ported to configfs to do this.

> So: Integrate with sysfs.

No, don't.  Do you think that Joel would not have already worked with
the sysfs people prior to submitting this?  No, he did, and we all
agreed that it should be kept separate.

> Terminology skew.  It is a very bad idea to call your configfs files 
> "attributes".

That's what sysfs calls its files.  They used the same naming scheme
there.  This is nothing that a user ever cares about or sees.

> Memory requirements.  ConfigFS pins way too much kernel memory for inodes
> and dentries.

configfs is not going to have that many nodes at all in memory (compared
to sysfs), so I don't think this is a big problem.

> Verbose kernel side interfaces.  My kernel-side implementation of a very 
> simple group with single-attribute children is about 150 lines.  If this 
> interface takes off and there are, say, 100 kernel classes exposed via 
> configfs, is 15,000 lines of kernel source an acceptable overhead?  Not in my 
> book.  You need a libconfigfs to encapsulate some of the more common 
> situations so that a kernel-side interface can be just half a dozen lines or 
> so in those cases.  Of course, it would help to use this a while and find out 
> what those common situations really are.

So we wait and evolve the interface over time.  Like always...

thanks,

greg k-h
