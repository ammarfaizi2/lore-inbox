Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUG0G4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUG0G4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 02:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUG0G4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 02:56:38 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:36343 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265410AbUG0G4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 02:56:37 -0400
Date: Tue, 27 Jul 2004 12:25:29 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, dipankar@in.ibm.com
Subject: Re: [patch] Use kref for struct file.f_count refcounter
Message-ID: <20040727065528.GB1270@obelix.in.ibm.com>
References: <20040726150312.GJ1231@obelix.in.ibm.com> <20040726223036.281106c5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726223036.281106c5.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:30:36PM -0700, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> >
> > This patch makes use of the kref api for the 
> >  struct file.f_count refcounter.  This depends
> >  on the new kref apis kref_read and kref_put_last
> >  added by means of my earlier patch today.
> 
> Sorry, but I can't really see how this improves anything.  It'll slow
> things down infinitesimally and it forces the reader to look elsewhere in
> the tree to see what's going on.
> 

It doesn't improve anything in terms of performance or anything.  It just
makes use of the kref api for refcounting.  My next patchset will be to
extend the kref api to do lockfree refcounting, and eliminate
use of files_struct.file_lock on the reader side (lock free fd lookup) .  
That improves performance for fd lookups -- for threaded workloads which 
do lot of io.  This was the step by step approach I am following to do 
lockfree refcounting as was agreed earlier.

I can do a patch to just extend kref api for lockfree refcounting and
use them for for the lock free fd lookup patch directly if you like to see
it that way.

Thanks,
Kiran

