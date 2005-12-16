Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVLPDg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVLPDg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVLPDg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:36:28 -0500
Received: from mail.suse.de ([195.135.220.2]:64677 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932095AbVLPDg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:36:27 -0500
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Fri, 16 Dec 2005 14:36:19 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17314.13875.902212.799030@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysfs question:  how to map major:minor to name under /sys
In-Reply-To: message from Greg KH on Thursday December 15
References: <17312.57214.612405.261796@cse.unsw.edu.au>
	<20051216013343.GD23832@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday December 15, greg@kroah.com wrote:
> On Thu, Dec 15, 2005 at 02:14:06PM +1100, Neil Brown wrote:
> > 
> > Hi,
> >  I have a question about sysfs related usage.
> > 
> >  Suppose I have a major:minor number for a block device - maybe from
> >  fstat of a filedescriptor I was given, or stat of a name in /dev.
> >  How do I find the directory in /sys/block that contains relevant
> >  information? 
> > 
> >  It seems to me that there is no direct way, and maybe there should
> >  be. (I can do a find of 'dev' file and compare, which is fine in a
> >  one-off shell script, but sub-optimal in general).
> 
> So you want this info from userspace, not from within the kernel,
> right?

Right.

> 
> >  The most obvious solution would be to have a directory somewhere full
> >  of symlinks:
> >         /sys/block_dev/8:0 -> ../block/sda
> >  or whatever.
> >  Is this reasonable?  Should I try it?
> 
> It seems a bit md specific to add a lot of kernel code for something
> that can be solved with a userspace shell script :)

I don't see it as md specific.  
Suppose I want to change the IO scheduler under the filesystem /foo.
I look that up in mtab and find it is mounted on /dev/blah.
To find the corresponding /sys/block entry I have to search.  That's
fine if I only have a few block devices.  But I keep hearing storing
of people with thousands.  Having to search just feels clumsy.

> 
> But if you want to try it, use a class, and a class_device for this, not
> raw kobjects.  It should be a bit easier that way.

Well, maybe it'll be a good excuse to learn more about 'class' and
'class_device' anyway.
Thanks,
NeilBrown
