Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268082AbUIPOLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268082AbUIPOLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUIPOLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:11:52 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:52959 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268082AbUIPOKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:10:09 -0400
Date: Thu, 16 Sep 2004 16:10:08 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@novell.com>, Tim Hockin <thockin@hockin.org>,
       Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel sysfs events layer
Message-ID: <20040916141008.GA28893@MAIL.13thfloor.at>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Robert Love <rml@novell.com>, Tim Hockin <thockin@hockin.org>,
	Kay Sievers <kay.sievers@vrfy.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <1095280414.23385.108.camel@betsy.boston.ximian.com> <20040915204754.GA19625@hockin.org> <1095281358.23385.109.camel@betsy.boston.ximian.com> <20040915205643.GA19875@hockin.org> <20040915212322.GB25840@kroah.com> <1095283589.23385.117.camel@betsy.boston.ximian.com> <20040915213419.GA21899@hockin.org> <1095284320.23385.123.camel@betsy.boston.ximian.com> <20040916012104.GA21832@MAIL.13thfloor.at> <20040916040820.GA5395@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916040820.GA5395@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:08:21PM -0700, Greg KH wrote:
> On Thu, Sep 16, 2004 at 03:21:04AM +0200, Herbert Poetzl wrote:
> > On Wed, Sep 15, 2004 at 05:38:39PM -0400, Robert Love wrote:
> > > On Wed, 2004-09-15 at 14:34 -0700, Tim Hockin wrote:
> > > 
> > > > It's a can of worms, is what it is.  And I'm not sure what a good fix
> > > > would be.  Would it just be enough to send a generic "mount-table changed"
> > > > event, and let userspace figure out the rest?
> > > 
> > > "Can of worms" is a tough description for something that there is no
> > > practical security issue for, just a lot of hand waving.  No one even
> > > uses name spaces.
> > 
> > ah, sorry, that is wrong, we (linux-vserver)
> > _do_ use namespaces extensively, and probably 
> > other 'jail' solutions will use it too ...
> 
> Great.  
> So, how do you handle the /sbin/hotplug call today?  

most of the time, not at all, but if, then in the
'initial' namespace where other userspace helpers
are handled too (means on the host)

> How would you want to handle this kevent notifier?

if there was a notifier telling about mounts - real
and virtual - then they would make sense _inside_
the respective namespace they happen .. e.g.

usb-device attached: 
  helper is called on host, and does some stuff
  result is a mount of some device, which happens
  on the host/initial namespace, notifier happens
  there ...

process in namespace does --bind mount:
  this might be interesting for the host too, but
  probably it is more useful for the namespace
  where it happened ... 

but keep in mind, that might not be true for the
usual, we put our sendmail in a separate namespace

best,
Herbert

> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
