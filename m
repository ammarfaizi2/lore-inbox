Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264017AbUDQTjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264024AbUDQTjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:39:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46287 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264017AbUDQTjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:39:43 -0400
Date: Sat, 17 Apr 2004 20:39:42 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>, Maneesh Soni <maneesh@in.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] fix sysfs symlinks
Message-ID: <20040417193942.GA17014@parcelfarce.linux.theplanet.co.uk>
References: <20040413133615.GZ31500@parcelfarce.linux.theplanet.co.uk> <20040414064015.GA4505@in.ibm.com> <20040414070227.GA31500@parcelfarce.linux.theplanet.co.uk> <20040415091752.A24815@flint.arm.linux.org.uk> <20040415103849.GA24997@parcelfarce.linux.theplanet.co.uk> <20040415161942.A7909@flint.arm.linux.org.uk> <20040415161011.GB2965@kroah.com> <20040415161332.GC24997@parcelfarce.linux.theplanet.co.uk> <20040415191447.GE24997@parcelfarce.linux.theplanet.co.uk> <1082179555.1390.102.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082179555.1390.102.camel@bach>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 04:15:34PM +1000, Rusty Russell wrote:
> > to these objects are gone, we get the section freed.  That can happen
> > way after the completion of rmmod - as the matter of fact we could have
> > the same module loaded again by that time.
> 
> Or you could skip the extra section, and keep all the module memory
> until later.  Instead of a section marker, you then set the release of
> those static things to "static_release" which does the put on the module
> memory kref:

That will keep too much allocated after rmmod - it's OK to have one or
two fixed-sized structures pinned down for a while, but entire .data can
be too large to treat it that way.
