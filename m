Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTDWPq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTDWPq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:46:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:57287 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264092AbTDWPq5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:46:57 -0400
Date: Wed, 23 Apr 2003 09:00:40 -0700
From: Greg KH <greg@kroah.com>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org, with@dsl.pipex.com
Subject: Re: [RFC] Device class rework [0/5]
Message-ID: <20030423160040.GA11015@kroah.com>
References: <1051084444.3ea6469c044ef@netmail.pipex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051084444.3ea6469c044ef@netmail.pipex.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 08:54:04AM +0100, Shaheed R. Haque wrote:
> 
> Hi Greg,
> 
> I support the intent of this patch, but would it not be a better idea to rename 
> the struct something like "device_class"? Rationale:

Ok, if I do that, and that was what I originally did, then we end up
with:
	struct device_class;
	struct device_class_device;
	struct device_class_interface;

Um, I don't think "struct device_class_device" is going to be
acceptable...

So I talked to a lot of people, explaining what the structures were, and
what they did, and in the end everyone agreed that dropping the
beginning "device_" is probably the best.

Well, not everyone agreed, but they couldn't come up with a better name,
so I took that as agreement :)

> 2. The word "class" is too generic and conveys no sense that is is to do with 
> devices.

In a way, it is generic.  It doesn't have to refer to a device (if the
pointer to struct device is NULL, then you don't get the "device"
symlink for free, that's it.)  So we can now move block "devices", which
includes partitions, into this model, and also network "devices" if we
want too.  Oh, how about filesystems, they also fit nicely into this
model, and aren't really a "device" at all...

> 3. I know that C++ is never going to make it into the kernel, but...

I know, I'm a stinker, but I honestly couldn't think of a better name,
and am open to ideas from everyone else.

And, I like the way my editor highlights the code, "struct class"...

thanks,

greg k-h
