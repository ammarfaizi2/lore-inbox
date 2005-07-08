Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVGHRyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVGHRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 13:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVGHRyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 13:54:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:36329 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262735AbVGHRyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 13:54:07 -0400
Date: Fri, 8 Jul 2005 10:48:52 -0700
From: Greg KH <greg@kroah.com>
To: Steve Grubb <sgrubb@redhat.com>
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050708174852.GF30908@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507071449.10271.sgrubb@redhat.com> <20050707190455.GA19570@kroah.com> <200507071548.37996.sgrubb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071548.37996.sgrubb@redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 03:48:37PM -0400, Steve Grubb wrote:
> On Thursday 07 July 2005 15:04, Greg KH wrote:
> > You are adding auditfs, a new userspace access, right?
> 
> Not sure what you mean. This is using the same netlink interface that all the 
> rest of the audit system is using for command and control. Nothing has 
> changed here. What is different is the message I send into the kernel. The 
> audit system dispatches it into Tim's code which in turn sets up the watch. 

What is auditfs for then?

> > His email provided no documentation that I could see.  Am I just missing
> > something?
> 
> The auditfs code is programmed by filling out the watch_transport structure 
> and sending a AUDIT_WATCH_INS message type. The perms, pathlen, & keylen are 
> all that's filled out. The path & key are stored back to back in the payload 
> section. To delete, you do the same thing and send AUDIT_WATCH_REM message. 
> Yes, this should be added to the documentation.

So how does userspace interact with auditfs?

> Tim's code lets you say I want change notification to this file only. The 
> notification follows the audit format with all relavant pieces of information 
> gathered at the time of the event and serialized with all other events.

That's great, and I understand the need for it.  I just see all the
duplication between this effort and inotify, and know of Tim's
reluctance to want to work with inotify, and am objecting to that.

> > Am I correct in thinking that you all need to split this patch into two
> > pieces, the new inode stuff, and auditfs, as neither one has anything to
> > do with the other?
> 
> It could be split to make it easier to read, but one's useless without the 
> other.

Ok, some documentation about auditfs would go a long way toward
understanding this...

thanks,

greg k-h
