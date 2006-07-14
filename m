Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWGNS2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWGNS2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422704AbWGNS2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:28:51 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:23222 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422699AbWGNS2u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:28:50 -0400
Subject: Re: [RFC][PATCH 3/6] SLIM main patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1152900398.23584.18.camel@localhost.localdomain>
References: <1152897878.23584.6.camel@localhost.localdomain>
	 <1152899070.314.11.camel@localhost.localdomain>
	 <1152900398.23584.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 11:28:46 -0700
Message-Id: <1152901726.314.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 11:06 -0700, Kylene Jo Hall wrote:
> Thanks it will be fixed in the next revision.
> 
> On Fri, 2006-07-14 at 10:44 -0700, Dave Hansen wrote:
> > On Fri, 2006-07-14 at 10:24 -0700, Kylene Jo Hall wrote:
> > > +static void revoke_mmap_wperm(struct slm_file_xattr *cur_level)
> > > +{
> > > +       struct vm_area_struct *mpnt;
> > > +       struct file *file;
> > > +       struct dentry *dentry;
> > > +       struct slm_isec_data *isec;
> > > +
> > > +       flush_cache_mm(current->mm);
> > > +
> > > +       for (mpnt = current->mm->mmap; mpnt; mpnt = mpnt->vm_next) {
> > > +               file = mpnt->vm_file;
> > > +               if (!file)
> > > +                       continue; 
> > 
> > You need to hold the mmap_sem for read while walking this list.

It gets a _bit_ sticky because mprotect() wants it as well.  And, if you
decide to drop the lock to make that call the vmas can go out from
underneath you.  Be careful.

-- Dave

