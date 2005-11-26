Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbVKZW0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVKZW0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 17:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKZW0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 17:26:20 -0500
Received: from accolon.hansenpartnership.com ([64.109.89.108]:723 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1750762AbVKZW0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 17:26:19 -0500
Subject: Re: [OOPS] sysfs_hash_and_remove (was Re: What protection ....)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Maneesh Soni <maneesh@in.ibm.com>, Greg KH <greg@kroah.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051124143401.GB1060@elte.hu>
References: <1132695202.13395.15.camel@localhost.localdomain>
	 <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
	 <20051123081845.GA32021@elte.hu> <20051123125212.GD22714@in.ibm.com>
	 <20051124122614.GA16465@in.ibm.com>  <20051124143401.GB1060@elte.hu>
Content-Type: text/plain
Date: Sat, 26 Nov 2005 17:26:04 -0500
Message-Id: <1133043964.3418.17.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 15:34 +0100, Ingo Molnar wrote:
> * Maneesh Soni <maneesh@in.ibm.com> wrote:
> 
> > So, IMO, it is necessary to explicitly remove links before 
> > unregistering the kobject in case of bidirectional cross symlinks.
> > 
> > The patch from James, is working, because it is not creating the cross 
> > symlink itself.
> 
> so, what is your suggestion, what should be done to fix the problem? The 
> patch below:
> isnt fit for upstream inclusion :-)

Well, the patch was just intended to confirm the problem diagnosis.

The solution Maneesh appears to be advocating to the issue is imposing
del ordering, the issue being that device_del is the call that actually
removes the directories and symlinks, so all callers have to make sure
they've called class_device_del for every class on the device before
calling device_del.  Since this trigger point happens regardless of
references, we can't expect references to get us out of this one, so
we'll have to audit the failing code manually.  I did find and fix one
of these issues in SCSI, but there may be more lurking around ...

James


