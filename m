Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263438AbVGATZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263438AbVGATZD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 15:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263437AbVGATZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 15:25:03 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:21651 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263438AbVGATYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 15:24:52 -0400
Date: Fri, 1 Jul 2005 14:24:25 -0500
From: serge@hallyn.com
To: greg@kroah.com, James Morris <jmorris@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050701192425.GA13916@vino.hallyn.com>
References: <20050630195043.GE23538@serge.austin.ibm.com> <Xine.LNX.4.44.0506302228390.18881-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0506302228390.18881-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morris (jmorris@redhat.com):
> On Thu, 30 Jun 2005 serue@us.ibm.com wrote:
> 
> > +/* list modules */
> > +static ssize_t listmodules_read (struct stacker_kobj *obj, char *buff)
> > +{
> > +	ssize_t len = 0;
> > +	struct module_entry *m;
> > +
> > +	rcu_read_lock();
> > +	stack_for_each_entry(m, &stacked_modules, lsm_list) {
> > +		len += snprintf(buff+len, PAGE_SIZE - len, "%s\n",
> > +			m->module_name);
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	return len;
> > +}
> > +
> 
> As far as I'm aware, sysfs nodes are supposed to contain one entity per 
> file.  Not sure what the alternative here is, though.

Thanks James, good point.

Documentation/filesystems/sysfs.txt seems a little soft on the issue,
saying it's "preferable".  So just to make sure:

Greg, should stacker be using its own filesystem?  There are 4
files:

	stop_responding: takes one input ("1")
	unload: takes one string
	lockdown: takes one input ("1")
	list_modules: outputs a list of strings, ie
		selinux
		cap_stack
	under a patched fedora kernel.

thanks,
-serge
