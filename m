Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUDQXpe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264076AbUDQXpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:45:34 -0400
Received: from ozlabs.org ([203.10.76.45]:34766 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264073AbUDQXpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:45:32 -0400
Subject: Re: [RFC] fix sysfs symlinks
From: Rusty Russell <rusty@rustcorp.com.au>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Greg KH <greg@kroah.com>, Maneesh Soni <maneesh@in.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040417193942.GA17014@parcelfarce.linux.theplanet.co.uk>
References: <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk>
	 <20040414064015.GA4505@in.ibm.com>
	 <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk>
	 <20040415091752.A24815@flint.arm.linux.org.uk>
	 <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk>
	 <20040415161942.A7909@flint.arm.linux.org.uk>
	 <20040415161011.GB2965@kroah.com>
	 <20040415161332.GC24997@parcelfarce.linux.theplanet.co.uk>
	 <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk>
	 <1082179555.1390.102.camel@bach>
	 <20040417193942.GA17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1082245527.14093.23.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 09:45:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-18 at 05:39, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Sat, Apr 17, 2004 at 04:15:34PM +1000, Rusty Russell wrote:
> > > to these objects are gone, we get the section freed.  That can happen
> > > way after the completion of rmmod - as the matter of fact we could have
> > > the same module loaded again by that time.
> > 
> > Or you could skip the extra section, and keep all the module memory
> > until later.  Instead of a section marker, you then set the release of
> > those static things to "static_release" which does the put on the module
> > memory kref:
> 
> That will keep too much allocated after rmmod - it's OK to have one or
> two fixed-sized structures pinned down for a while, but entire .data can
> be too large to treat it that way.

I disagree.  Removal is rare, modules are usually small, it usually
won't be pinned down for long, and the implementation is simple.

But that's an implementation detail.  You didn't answer my question, on
how you initialize the reference count on this memory.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

