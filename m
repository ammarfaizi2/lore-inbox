Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSLMJ3y>; Fri, 13 Dec 2002 04:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSLMJ3y>; Fri, 13 Dec 2002 04:29:54 -0500
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:56332 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261724AbSLMJ3x>; Fri, 13 Dec 2002 04:29:53 -0500
Date: Fri, 13 Dec 2002 09:37:45 +0000
To: Greg KH <greg@kroah.com>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: dmfs for 2.5.51
Message-ID: <20021213093745.GB1117@reti>
References: <20021213012618.GH23509@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021213012618.GH23509@kroah.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Thu, Dec 12, 2002 at 05:26:19PM -0800, Greg KH wrote:
> Here's a patch against 2.5.51 with a updated dmfs.

I've split out your two changes into seperate patches (patches 21 and
22) and made them available here:

http://people.sistina.com/~thornber/patches/2.5-unstable/2.5.51/2.5.51-dmfs-1/

> with the following modifications:
> 	- fixed compile time warnings with the dbg() macro (something
> 	  better should be used here, I just commented it out...)

I'm not seeing any warnings, which compiler version are you using ?

> 	- changed the dev file to print out the kdev value, not be the
> 	  actual block device.

Should we really be exporting a kdev_t to userland, why not just print out

<major>:<minor>

?

> With regards to the last change, I didn't follow the way the other files
> operate with their complex page creation structure, as this is only a
> simple one line file.  If the lvm developers want me to change this, I
> will.

What you've done looks fine to me, though allocating a whole page to
hold a single number seems overkill.  Why don't you just snprintf into
a char[] held on the stack ?

> If not, I would argue that a number of the other files created
> should be changed to use this simpler format.  Or is there some reason
> for creating these lists of pages that I'm missing?

The files can be larger than a single page, which complicates things
somewhat.

- Joe
