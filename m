Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWAMQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWAMQEU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWAMQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:04:20 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:49391 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964984AbWAMQET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:04:19 -0500
Subject: RE: Dual core Athlons and unsynced TSCs
From: Steven Rostedt <rostedt@goodmis.org>
To: Roger Heflin <rheflin@atipa.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'Lee Revell'" <rlrevell@joe-job.com>
In-Reply-To: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
References: <EXCHG2003rmTIVvLVKi00000c7b@EXCHG2003.microtech-ks.com>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 11:04:14 -0500
Message-Id: <1137168254.7241.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 09:10 -0600, Roger Heflin wrote:
>  
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org 
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lee Revell
> > Sent: Thursday, January 12, 2006 4:18 PM
> > To: linux-kernel
> > Subject: Dual core Athlons and unsynced TSCs
> > 
> > It's been known for quite some time that the TSCs are not 
> > synced between cores on Athlon X2 machines and this screws up 
> > the kernel's timekeeping, as it still uses the TSC as the 
> > default time source on these machines.
> > 
> > This problem still seems to be present in the latest kernels. 
> >  What is the plan to fix it?  Is the fix simply to make the 
> > kernel use the ACPI PM timer by default on Athlon X2?
> 
> 
> Do we know if this also affects dual-core opterons?
> 
> The symptoms are that the clocks run at 2x the speed, correct?

No, worse.  The monotonic clock can go backwards.  The tscs of the CPUs
are not in sync when one slows down due to idle.  So if you read from
two different CPUs, you may get the second read have an earlier time
than the first.  Breaks the rule of what a monotonic clock is.

-- Steve


