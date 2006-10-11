Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWJKX0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWJKX0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWJKX0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:26:07 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:9371 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965231AbWJKX0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:26:04 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Greg KH <greg@kroah.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
In-Reply-To: <20061011223927.GA29943@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 11 Oct 2006 16:26:00 -0700
Message-Id: <1160609160.6389.80.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 15:39 -0700, Greg KH wrote:
> On Tue, Oct 10, 2006 at 06:28:51PM -0700, Joel Becker wrote:
> > On Tue, Oct 10, 2006 at 05:49:59PM -0700, Matt Helsley wrote:
> > > 	We want to be able to export a sequence of small (<< 1 page),
> > > homogenous, unstructured (scalar), attributes through configfs using the
> > > same file. While this is rather specific, I'd guess it would be a common
> > > occurrence.
> > 
> > 	Pray tell, why?  "One attribute per file" is the mantra here.
> > You really should think hard before you break it.  Simple heuristic:
> > would you have to parse the buffer?  Then it's wrong.
> 
> I agree.  You are trying to use configfs for something that it is not
> entended to be used for.  If you want to write/read large numbers of
> attrbutes like this, use your own filesystem.

I would say it is a "large attribute" not "large numbers of attributes".

> 
> configfs has the same "one value per file" rule that sysfs has.  And
> because your userspace model doesn't fit that, don't try to change
> configfs here.
> 
> What happened to your old ckrmfs?  I thought you were handling all of
> this in that.

We decided to use an existing infrastructure instead of having our own
file system.

configfs is a perfect fit for us, except the size limitation.

BTW, it it not just CKRM/RG, Paul Menage as recently extracted the
processes aggregation from cpuset to have an independent infrastructure
(http://marc.theaimsgroup.com/?l=ckrm-tech&m=116006307018720&w=2), which
has its own file system. I was advocating him to use configfs. But, he
also has this issue/limitation. 

> 
> thanks,
> 
> greg k-h
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


