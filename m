Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWBSSw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWBSSw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWBSSw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:52:56 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:59095 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932207AbWBSSw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:52:56 -0500
Date: Sun, 19 Feb 2006 20:52:54 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060219185254.GA13391@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219175623.GA2674@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 09:56:23AM -0800, Greg KH wrote:
> Note that Pat isn't the sysfs maintainer anymore :)
> 
My mistake, I'll check MAINTAINERS instead of the file comments next
time.

> On Sun, Feb 19, 2006 at 07:17:48PM +0200, Paul Mundt wrote:
> > Now with relayfs integrated and the relay_file_operations exported for
> > use by other file systems, I wonder what people think about adding in a
> > sysfs attribute for setting up channel buffers.
> 
> Looks good, I like it.  This properly handles the module owner stuff,
> too, right?
> 
Could you elaborate on which module owner issue you're referring to?
struct relay_attribute encapsulates a struct attribute, and it's handled
the same way as the other attribute types (I modelled it after
struct bin_attribute), and I don't see any places that I missed.

When setting up the relay attribute, it's just a matter of:

	static struct relay_attribute dev_relay_attr = {
		.attr	= {
			.owner	= THIS_MODULE,
			...
		},
		...
	};

Let me know if I've missed anything.

> And I agree with Christoph, with this change, you don't need a separate
> relayfs mount anymore.
> 
Yes, that's where I was going with this, but I figured I'd give the
relayfs people a chance to object to it going away first.

If with this in sysfs and simple handling through debugfs people are
content with the relay interface for whatever need, then getting rid of
relayfs entirely is certainly the best option. We certainly don't need
more pointless virtual file systems.

I'll work up a patch set for doing this as per Cristoph's kernel/relay.c
suggestion. Thanks for the feedback.
