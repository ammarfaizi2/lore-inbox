Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWJMAEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWJMAEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWJMAEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:04:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:34209 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751350AbWJMAEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:04:52 -0400
Date: Thu, 12 Oct 2006 16:54:34 -0700
From: Greg KH <greg@kroah.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061012235434.GB15767@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011223927.GA29943@kroah.com> <1160619464.18766.207.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160619464.18766.207.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 07:17:44PM -0700, Matt Helsley wrote:
> On Wed, 2006-10-11 at 15:39 -0700, Greg KH wrote:
> > On Tue, Oct 10, 2006 at 06:28:51PM -0700, Joel Becker wrote:
> > > On Tue, Oct 10, 2006 at 05:49:59PM -0700, Matt Helsley wrote:
> > > > 	We want to be able to export a sequence of small (<< 1 page),
> > > > homogenous, unstructured (scalar), attributes through configfs using the
> > > > same file. While this is rather specific, I'd guess it would be a common
> > > > occurrence.
> > > 
> > > 	Pray tell, why?  "One attribute per file" is the mantra here.
> > > You really should think hard before you break it.  Simple heuristic:
> > > would you have to parse the buffer?  Then it's wrong.
> > 
> > I agree.  You are trying to use configfs for something that it is not
> > entended to be used for.  If you want to write/read large numbers of
> 
> 	I disagree with your assertion that we're abusing configfs. "one value
> per file" is not the purpose of configfs.
> 
> 	The purpose of configfs is to allow userspace to create and manipulate
> kernel objects whose lifetime is under the control of userspace. That
> perfectly matches the idea of being able to create, manipulate, and
> destroy a resource group from userspace.
> 
> 	"one value per file" is a phrase describing what configfs and sysfs
> files should normally look like. However it's not a rule since there is
> precedent for sysfs files that require parsing:
> /sys/devices/pciXXXX:XX/XXXX:XX:XX.X/resource

Hold over from old procfs use of pci resources.  And now a requirement
that X uses this, after it was pointed out to me.

> /sys/block/hda/stat

I never have liked that, it belongs somewhere else.  Please move it.

> /sys/block/hda/dev

That is merely a dev_t, a single value.

Come on, there are way worse violators[1] of the "one value per file"
rule in sysfs that you could have found if you wanted to try to declare
how much it is not being followed in places.  But if you look, the ratio
of good vs. bad usage is still very high, and keeping it high is my
goal.

> > What happened to your old ckrmfs?  I thought you were handling all of
> > this in that.
> 
> 	We dropped RCFS more than 1 year ago after feedback suggested we should
> try to share as much kernel code as possible. Other than the 1 page
> limit to the list of pids, configfs is a perfect match for what we need.

Feedback from whom?  I know I sure liked the fact that you did your own
filesystem, despite the bugs that were found in it at times :)

thanks,

greg k-h
