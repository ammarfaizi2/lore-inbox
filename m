Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965251AbWJLCRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965251AbWJLCRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 22:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965252AbWJLCRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 22:17:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:64467 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965251AbWJLCRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 22:17:49 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Matt Helsley <matthltc@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Joel Becker <Joel.Becker@oracle.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20061011223927.GA29943@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Wed, 11 Oct 2006 19:17:44 -0700
Message-Id: <1160619464.18766.207.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
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

	I disagree with your assertion that we're abusing configfs. "one value
per file" is not the purpose of configfs.

	The purpose of configfs is to allow userspace to create and manipulate
kernel objects whose lifetime is under the control of userspace. That
perfectly matches the idea of being able to create, manipulate, and
destroy a resource group from userspace.

	"one value per file" is a phrase describing what configfs and sysfs
files should normally look like. However it's not a rule since there is
precedent for sysfs files that require parsing:
/sys/devices/pciXXXX:XX/XXXX:XX:XX.X/resource
/sys/block/hda/stat
/sys/block/hda/dev

	These are counterexamples to your assertion below that "one value per
file" is a rule.

> attrbutes like this, use your own filesystem.

	This conflicts with the idea of reusing kernel code that was made to be
reused. Except for this 1 page limit configfs is nearly a perfect match.
I doubt we'd get a favorable reaction if we said:
	"OK, let's copy configfs then remove the page size limit."

> configfs has the same "one value per file" rule that sysfs has.  And
> because your userspace model doesn't fit that, don't try to change
> configfs here.

Please see my counterexample above.

> What happened to your old ckrmfs?  I thought you were handling all of
> this in that.

	We dropped RCFS more than 1 year ago after feedback suggested we should
try to share as much kernel code as possible. Other than the 1 page
limit to the list of pids, configfs is a perfect match for what we need.

Cheers,
	-Matt Helsley

