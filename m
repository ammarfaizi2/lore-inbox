Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVDVVNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVDVVNU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDVVNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:13:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1774 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262134AbVDVVNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:13:15 -0400
Date: Fri, 22 Apr 2005 22:13:24 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Robert Love <rml@novell.com>, linux-kernel@vger.kernel.org,
       Mr Morton <akpm@osdl.org>
Subject: Re: [patch] updated inotify for 2.6.12-rc3.
Message-ID: <20050422211324.GF13052@parcelfarce.linux.theplanet.co.uk>
References: <1114060434.6913.26.camel@jenny.boston.ximian.com> <1114146110.6973.101.camel@jenny.boston.ximian.com> <20050422085614.GE13052@parcelfarce.linux.theplanet.co.uk> <1114182273.13886.17.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114182273.13886.17.camel@vertex>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 11:04:33AM -0400, John McCutchan wrote:
> On Fri, 2005-04-22 at 09:56 +0100, Al Viro wrote:
> > So what happens if
> > 	* something is holding inotify_sem right now
> > 	* ten threads call that on the same watch
> > 	* all of them get to down(&inode->inotify_sem); and block there,
> > having acquired ten references to the watch
> > 	* after whatever had been holding ->inotify_sem in the first place
> > releases it, they will one by one go through the rest of function.  And
> > drop _20_ references to the watch.  9 of those - after we kfree() the
> > watch...
> 
> In create_watch () we call get_inotify_watch (), which maps to the
> put_inotify_watch() in remove_watch(). As far as I can tell the ref
> counting is 1 for 1.

Or it would, if remove_watch() had been called only once.  In the scenario
above that will not be true.
