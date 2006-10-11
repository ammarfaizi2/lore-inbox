Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWJKWjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWJKWjp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965228AbWJKWjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:39:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:34245 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965226AbWJKWjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:39:43 -0400
Date: Wed, 11 Oct 2006 15:39:27 -0700
From: Greg KH <greg@kroah.com>
To: Matt Helsley <matthltc@us.ibm.com>, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061011223927.GA29943@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com> <20061010215808.GK7911@ca-server1.us.oracle.com> <1160527799.1674.91.camel@localhost.localdomain> <20061011012851.GR7911@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011012851.GR7911@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 06:28:51PM -0700, Joel Becker wrote:
> On Tue, Oct 10, 2006 at 05:49:59PM -0700, Matt Helsley wrote:
> > 	We want to be able to export a sequence of small (<< 1 page),
> > homogenous, unstructured (scalar), attributes through configfs using the
> > same file. While this is rather specific, I'd guess it would be a common
> > occurrence.
> 
> 	Pray tell, why?  "One attribute per file" is the mantra here.
> You really should think hard before you break it.  Simple heuristic:
> would you have to parse the buffer?  Then it's wrong.

I agree.  You are trying to use configfs for something that it is not
entended to be used for.  If you want to write/read large numbers of
attrbutes like this, use your own filesystem.

configfs has the same "one value per file" rule that sysfs has.  And
because your userspace model doesn't fit that, don't try to change
configfs here.

What happened to your old ckrmfs?  I thought you were handling all of
this in that.

thanks,

greg k-h
