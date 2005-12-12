Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVLLJgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVLLJgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVLLJgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:36:16 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:10978 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751164AbVLLJgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:36:15 -0500
Subject: Re: [patch 3/17] s390: move s390_root_dev_* out of the cio layer.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, cotte@de.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051210075016.GA21423@kroah.com>
References: <20051209152345.GD6532@skybase.boeblingen.de.ibm.com>
	 <20051209165150.GD23349@stusta.de>
	 <1134147283.5576.1.camel@localhost.localdomain>
	 <20051210075016.GA21423@kroah.com>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 10:36:14 +0100
Message-Id: <1134380174.5472.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 23:50 -0800, Greg KH wrote:
> On Fri, Dec 09, 2005 at 05:54:43PM +0100, Martin Schwidefsky wrote:
> > On Fri, 2005-12-09 at 17:51 +0100, Adrian Bunk wrote:
> > > On Fri, Dec 09, 2005 at 04:23:45PM +0100, Martin Schwidefsky wrote:
> > > > +extern struct device *s390_root_dev_register(const char *);
> > > > +extern void s390_root_dev_unregister(struct device *);
> > > >...
> > > 
> > > If you do _really_ need these wrappers, simply make them
> > > "static inline"'s in the header file.
> > 
> > We can't. The point here is that we need an external release function
> > that is still available after the module has been unloaded that uses
> > these wrappers.
> 
> release is find and understandable.  But the unregister one is just
> pretty foolish :)

Well, the alternative is to only have a release function somewhere that
calls kfree. Which would be general-purpose "struct device"-kfree
wrapper and would be callable by any piece of code. Where is the
difference to calling kfree directly then? The additional indirection?

No, the release function should be related to a specific object and then
you need the register/unregister functions as well.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


