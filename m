Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268292AbUHFUwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268292AbUHFUwg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268284AbUHFUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:51:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:17796 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268292AbUHFUuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:50:40 -0400
Date: Fri, 6 Aug 2004 13:50:22 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@ximian.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] add kobject_get_path
Message-ID: <20040806205022.GA26135@kroah.com>
References: <1091824013.7939.66.camel@betsy> <1091824903.7939.80.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091824903.7939.80.camel@betsy>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 04:41:43PM -0400, Robert Love wrote:
> Greg -
> 
> Hey, here is an alternative to exporting those two functions.

Ah, good timing, I was just about to apply your other patch :)

> 
> This patch, in lieu, creates a new function that performs the same steps
> as in kset_hotplug() and presumably what every single user of the
> previously exported functions would do: get the length, allocate memory,
> and then build the path.
> 
> So just export a single function to do it right.  And use it in
> kset_hotplug().  The function is prototyped as
> 
> 	char * kobject_get_path(struct kset *kset, struct kobject *kobj,
> 				int gfp_mask)
> 
> I like this approach better.

I do too.  One problem though, get_kobj_path_length and fill_kobj_path
are only built if CONFIG_HOTPLUG is enabled.  Care to respin this patch
by moving the functions outside of that #define?

thanks,

greg k-h
