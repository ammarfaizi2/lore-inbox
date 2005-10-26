Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVJZBIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVJZBIh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVJZBIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:08:37 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:57739 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932509AbVJZBIg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:08:36 -0400
Subject: Re: [PATCH 00/02] Process Events Connector
From: Matt Helsley <matthltc@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <20051026003430.GA27680@kroah.com>
References: <1130285260.10680.194.camel@stark>
	 <20051026003430.GA27680@kroah.com>
Content-Type: text/plain
Date: Tue, 25 Oct 2005 18:00:37 -0700
Message-Id: <1130288437.10680.236.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 17:34 -0700, Greg KH wrote:
> On Tue, Oct 25, 2005 at 05:07:40PM -0700, Matt Helsley wrote:
> > Andrew, all,
> > 
> > 	Is there any reason this patch could not go for a spin in a -mm tree?
> > It's similar to Guillaume's fork connector patch which did appear in -mm
> > at one point. It replaces the fork_advisor patch that ELSA is currently
> > using, can be used by userspace CKRM code, and in general is useful for
> > anything that may wish to monitor changes in all processes.
> 
> Why can't you use a lsm module for this instead?  It looks like you are
> wanting to hook things in pretty much the same places we currently have
> the lsm hooks at.
> 
> thanks,
> 
> greg k-h

	Guillaume apparently tried to use LSM for his fork connector and was
told "this doesn't belong here":

http://www.ussg.iu.edu/hypermail/linux/kernel/0502.2/1000.html

	This patch does not affect whether or not these operations succeed and
hence is a poor match for LSM even though it hooks into the same places
in the kernel.

	There has been some discussion on lse-tech about 'task_notifiers' that
would allow multiple modules to hook into these paths without polluting
the paths themselves. I modified the patch with these proposals in mind.
Then, assuming such an interface developed, I could submit a small patch
which would convert to using the new interface.

	Would you still rather see the patch as an LSM module?

Thanks,
	-Matt Helsley
	< matthltc @ us.ibm.com >

