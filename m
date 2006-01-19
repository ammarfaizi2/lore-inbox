Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161356AbWASThW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161356AbWASThW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWASThV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:37:21 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:4766 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161356AbWASThT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:37:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TeSLgZbeARIiVgH8Ld9sotx+42KJAS7vzL2LlTU/y+qyWlbRrz+DqBPoMg1irpLpNnwJlP6UxtpnuCF/EB+0kMEKDN3ZrwQhSKXUPy85NfopX/V4SPUjxzdpkUzlDwi+wtBOGoEdjLB4rDgbuQVg8Tt7zxWb5PCz1ep7LCWYRHI=
Message-ID: <5c49b0ed0601191137u331a08a3sae8db27aac89d4c5@mail.gmail.com>
Date: Thu, 19 Jan 2006 11:37:18 -0800
From: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Fall back io scheduler for 2.6.15?
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20060116084309.GN3945@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
	 <20060110212551.411a766d.akpm@osdl.org>
	 <1137007032.4395.24.camel@localhost.localdomain>
	 <20060111114303.45540193.akpm@osdl.org>
	 <1137201135.4353.81.camel@localhost.localdomain>
	 <20060113174914.7907bf2c.akpm@osdl.org>
	 <20060116084309.GN3945@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Jens Axboe <axboe@suse.de> wrote:
> On Fri, Jan 13 2006, Andrew Morton wrote:
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > >
> > > On 2.6.14, the
> > > fall back io scheduler (if the chosen io scheduler is not found) is set
> > > to the default io scheduler (anticipatory, in this case), but since
> > > 2.6.15-rc1, this semanistic is changed to fall back to noop.
> >
> > OK.  And I assume that AS wasn't compiled, so that's why it fell back?
> >
> > I actually thought that elevator= got removed, now we have
> > /sys/block/sda/queue/scheduler.  But I guess that's not very useful with
> > CONFIG_SYSFS=n.
> >
> > > Is there any reason to fall back to noop instead of as?  It seems
> > > anticipatory is much better than noop for ext3 with large sequential
> > > write tests (i.e, 1G dd test) ...
> >
> > I suspect that was an accident.  Jens?
>
> It is, it makes more sense to fallback to the default of course.

Not an accident at all, actually, because the original patch i
submitted allowed you to select a scheduler as 'default' even if it
were compiled as a module in kconfig.  Since noop is guaranteed to be
present in any system, it is the obvious choice if the chosen or
default scheduler is not loaded.

If you change it to fall back to the default, it will oops if the
default is not available.

NATE
