Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWAXPLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWAXPLr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWAXPLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:11:47 -0500
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:58496 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S964987AbWAXPLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:11:46 -0500
Date: Tue, 24 Jan 2006 07:09:12 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] 2.6.16-rc1 perfmon2 patch for review
Message-ID: <20060124150912.GB7130@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200601201520.k0KFKEm2023128@frankl.hpl.hp.com> <1137775645.28944.61.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137775645.28944.61.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan,

On Fri, Jan 20, 2006 at 08:47:24AM -0800, Bryan O'Sullivan wrote:
> On Fri, 2006-01-20 at 07:20 -0800, Stephane Eranian wrote:
> 
> > +static struct pfm_smpl_fmt dfl_fmt={
> > + 	.fmt_name = "default_format2",
> > + 	.fmt_uuid = PFM_DFL_SMPL_UUID,
> 
> What's the point of using a UUID here?
> 

Every sampling buffer format, even the default, needs a name. 
Not all measurements need a kernel level sampling buffer. In that
case they pass the NULL uuid (uuid = all zeroes).

> > +static struct file_system_type pfm_fs_type = {
> > +	.name     = "pfmfs",
> > +	.get_sb   = pfmfs_get_sb,
> > +	.kill_sb  = kill_anon_super,
> > +};
> 
> A comment that describes what pfmfs is for would be useful here, and
> perhaps a warning to hold one's nose, if the code that follows is
> anything to go by :-)
> 
Yes, this is sort of obscure. But any file descriptor must be associated
with a filesystem (and super block). This creates the minimum skeleton
for such filesystem. The same technique is used for pipes, tmpfs,...


> > +static ctl_table pfm_ctl_table[]={
> 
> Why are you using sysctls, and not sysfs?  Why is this in a file that
> claims to be procfs-related?
> 
Because I tried regrouping all the /proc AND related interface into a single
C file.

> Also, it looks like much of the procfs goo is actually not related to
> individual processes, really doesn't belong in /proc at all, and should
> move to some place in sysfs somewhere.
> 
Well, it is not clear to me what criteria is used for /sys vs /proc. Yours
is based on whether the information is process or system-wide based. That 
looks reasonable, yet I can see evidence of just the opposite in /proc
today, such as /proc/meminfo. Is this maintained because of backward compatibility?

-- 

-Stephane
