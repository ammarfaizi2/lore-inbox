Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932718AbWCVUxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932718AbWCVUxM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 15:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbWCVUxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 15:53:12 -0500
Received: from mga03.intel.com ([143.182.124.21]:46232 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932718AbWCVUxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 15:53:10 -0500
X-IronPort-AV: i="4.03,119,1141632000"; 
   d="scan'208"; a="14366237:sNHT581205730"
Subject: Re: [patch] add private data to notifier_block
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0603221402070.7453-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0603221402070.7453-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 22 Mar 2006 13:00:11 -0800
Message-Id: <1143061212.8924.10.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 22 Mar 2006 20:53:04.0438 (UTC) FILETIME=[9D600D60:01C64DF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 14:04 -0500, Alan Stern wrote:
> On Tue, 21 Mar 2006, Kristen Accardi wrote:
> 
> > While most current uses of notifier_block use a global struct, I would
> > like to be able to use it on a per device basis for drivers which have
> > multiple device instances.  I would also like to be able to have a
> > private data struct associated with the notifier block so that per
> > device data can be easily accessed.  This patch will modify the
> > notifier_block struct to add a void *, and will require no modifications
> > to any other users of the notifier_block.
> > 
> > Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> > 
> > ---
> >  include/linux/notifier.h |    1 +
> >  1 files changed, 1 insertion(+)
> > 
> > --- 2.6-git-kca.orig/include/linux/notifier.h
> > +++ 2.6-git-kca/include/linux/notifier.h
> > @@ -15,6 +15,7 @@ struct notifier_block
> >  {
> >  	int (*notifier_call)(struct notifier_block *self, unsigned long, void *);
> >  	struct notifier_block *next;
> > +	void *data;
> >  	int priority;
> >  };
> 
> I still think this isn't really needed.  The same effect can be 
> accomplished by embedding a notifier_block struct within a larger 
> structure that also contains the data pointer.
> 

I thought of this, but felt it would make for less easy to read code.
But, that's just my personal style.  

> On the other hand this isn't a terribly big change, so I don't actually 
> object to it.
> 

Thanks.

> Alan Stern
