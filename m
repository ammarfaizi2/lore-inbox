Return-Path: <linux-kernel-owner+w=401wt.eu-S1753608AbXAARtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbXAARtp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 12:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbXAARtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 12:49:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:59154 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbXAARtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 12:49:45 -0500
In-Reply-To: <20070101.005714.35017753.davem@davemloft.net>
References: <20061231.024917.59652177.davem@davemloft.net> <20061231154103.GA7409@infradead.org> <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org> <20070101.005714.35017753.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <385664dfd55cfdfb9f9651fc90bf46b0@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, hch@infradead.org, jg@laptop.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Mon, 1 Jan 2007 18:48:33 +0100
To: David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not the same exact thing -- using a text representation for
>> the property contents is a very different thing (and completely
>> braindead).
>
> The filesystem bit is for groveling around and getting information
> from the shell prompt, or shell scripts.  Text processing.
>
> If you want the binary bits, export it with something like
> /dev/openprom.

But we'd have to implement a tree structure on top of that.

If for doing "real" things we have to use some device file with
some helper program, we can do away with the whole filesystem
thing just as well -- *always* use that helper program.

On the PowerPC side of things, we have binary properties in
the device tree filesystem, and have a simple user space
program to make it readable as text.

> We don't generally export binary representation
> files out of /proc or /sys, in fact this rule I believe is layed
> our precisely somewhere at least in the sysfs case.

That only works for sysfs because there is the "one value
per file" rule -- something the OF device tree doesn't do,
and doesn't need to do, since it uses a well-defined binary
format.

If you *really* want (the option of) showing things as text
in the filesystem, you better make it so that there is a
one-to-one translation back to binary.  For example, what
does this mean, is it a text string or two bytes:

01.02

Yes you as a user can guess, but scripts can't (reliably).

>> Every architecture that supports the device tree filesystem,
>> initialises a "struct device_tree_ops" with a bunch of
>> pointers to functions that allow you to traverse the device
>> tree and read its properties (and maybe write properties, or
>> even delete and create new nodes.  The devtree filesystem code
>> simply calls into these functions to do the actual operations
>> on the device tree (access an in-kernel data structure, call
>> the OF, or both -- or something entirely different, who knows).
>
> That's the only key point in my opinion, any clean interface that
> sits in front of this stuff is fine as long as it encompasses
> all of the necessary operations and allows just about any
> implementation underneath.

Yeah.  And I'd like to have it as a collection of function
pointers so the arch code can put in the implementation it
needs at boot time.  Flexibility is good.


Segher

