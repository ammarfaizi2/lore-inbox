Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752102AbWJNGSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbWJNGSP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 02:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbWJNGSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 02:18:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:19150 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752102AbWJNGSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 02:18:14 -0400
Date: Fri, 13 Oct 2006 23:17:23 -0700
From: Greg KH <greg@kroah.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Chandra Seetharaman <sekharan@us.ibm.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061014061723.GA26016@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011223927.GA29943@kroah.com> <1160609160.6389.80.camel@linuxchandra> <20061012235127.GA15767@kroah.com> <1160782808.18766.553.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160782808.18766.553.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 04:40:08PM -0700, Matt Helsley wrote:
> On Thu, 2006-10-12 at 16:51 -0700, Greg KH wrote:
> 
> <snip>
> 
> > > BTW, it it not just CKRM/RG, Paul Menage as recently extracted the
> > > processes aggregation from cpuset to have an independent infrastructure
> > > (http://marc.theaimsgroup.com/?l=ckrm-tech&m=116006307018720&w=2), which
> > > has its own file system. I was advocating him to use configfs. But, he
> > > also has this issue/limitation. 
> > 
> > That's one reason it is so easy to just write your own filesystem then.
> > What is it these days, less than 200 lines of code?  I bet you can even
> 
> For my_school_project_fs perhaps 200 lines is sufficient.
> 
> Paul Menage's patch which Chandra was referring to:
> 
> http://lkml.org/lkml/2006/9/28/104
> 
> is 1700 insertions. RCFS was around 1500 lines -- similar to Paul's
> patch -- before we moved to configfs and reduced that to about 300-400
> lines. This suggests we'd need around 1500 lines of filesystem code --
> 7.5 times your estimate.

Then I suggest that you are doing something extremely wrong here.  The
base filesystem code for both debugfs and securityfs, is around 200
lines of code, including comments.  And they are both not
"my_school_project_fs".

If you want to get a bit fancier, and parse some mount options and
provide a persistant mount state, like usbfs, it grows to about 350
lines of code.

Again, not a "fake" filesystem by any means.

And, for another example, ndevfs was posted to lkml over a year ago as a
bad joke and can be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/bad/ndevfs.patch
and weighs in at a whopping 249 lines for all of inode.c (comments and
whitespace included.)  It was a full-blown filesystem that handled
almost exactly what you will need to handle.

So please, before you critise me for not knowing exactly how much work
it takes to implement a ram-based filesystem for something like this,
take a look at a few of the already published and shipping
implementations, and note who wrote them...

Otherwise you look quite foolish.

> > condence more things to make it 100 lines if you really try.  That seems
> > much more sane than trying to bend configfs into something different.
> 
> 	I don't agree. I think it's insane not to use configfs just because we
> need a list of pids for each group of tasks.

Perhaps because your usage is not what it is intended for?  Yeah, I
know, if all you have is a hammer...

> > Why are people so opposed to creating their own filesystems?
> 
> 	There are lots of reasons not to create your own filesystem. When
> you're not already a kernel maintainer it's no small task to create and
> get a non-trivial filesystem accepted into the kernel. Getting people to
> review whole new filesystems has its own problems:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0610.1/1928.html

There's a world of difference between something as complex as unionfs
and something that merely makes a few calls to the libfs code already in
the kernel.

And if you don't realize this, then yes, I would not recommend that you
should write your own fs.  But I would then recommend that the task then
be passed on to someone else in your group who does have the capability
to do so...

greg k-h
