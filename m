Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWJMAEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWJMAEr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 20:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWJMAEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 20:04:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:31905 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751352AbWJMAEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 20:04:46 -0400
Date: Thu, 12 Oct 2006 16:51:27 -0700
From: Greg KH <greg@kroah.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061012235127.GA15767@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com> <20061011223927.GA29943@kroah.com> <1160609160.6389.80.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160609160.6389.80.camel@linuxchandra>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 04:26:00PM -0700, Chandra Seetharaman wrote:
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
> > attrbutes like this, use your own filesystem.
> 
> I would say it is a "large attribute" not "large numbers of attributes".

That attribute seems to violate the rule of "only one thing" and needs
to be parsed.  That does not seem like a good fit for configfs or sysfs.

> > configfs has the same "one value per file" rule that sysfs has.  And
> > because your userspace model doesn't fit that, don't try to change
> > configfs here.
> > 
> > What happened to your old ckrmfs?  I thought you were handling all of
> > this in that.
> 
> We decided to use an existing infrastructure instead of having our own
> file system.
> 
> configfs is a perfect fit for us, except the size limitation.

Then it's not a perfect fit, sorry, as you are trying to get it to do
things it is not supposed to, or designed to, do.

> BTW, it it not just CKRM/RG, Paul Menage as recently extracted the
> processes aggregation from cpuset to have an independent infrastructure
> (http://marc.theaimsgroup.com/?l=ckrm-tech&m=116006307018720&w=2), which
> has its own file system. I was advocating him to use configfs. But, he
> also has this issue/limitation. 

That's one reason it is so easy to just write your own filesystem then.
What is it these days, less than 200 lines of code?  I bet you can even
condence more things to make it 100 lines if you really try.  That seems
much more sane than trying to bend configfs into something different.

Why are people so opposed to creating their own filesystems?

thanks,

greg k-h
