Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVAXSQl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVAXSQl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 13:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVAXSQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 13:16:41 -0500
Received: from fmr17.intel.com ([134.134.136.16]:38116 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261542AbVAXSQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 13:16:38 -0500
Date: Mon, 24 Jan 2005 10:16:37 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: Greg KH <greg@kroah.com>
cc: "Williams, Mitch A" <mitch.a.williams@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] disallow seeks and appends on sysfs files
In-Reply-To: <20050122080556.GA6999@kroah.com>
Message-ID: <Pine.CYG.4.58.0501241005070.3748@mawilli1-desk2.amr.corp.intel.com>
References: <Pine.CYG.4.58.0501211441430.3364@mawilli1-desk2.amr.corp.intel.com>
 <20050122080556.GA6999@kroah.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 Jan 2005, Greg KH wrote:

>
> On Fri, Jan 21, 2005 at 02:49:39PM -0800, Mitch Williams wrote:
> > This patch causes sysfs to return errors if the caller attempts to
> append
> > to or seek on a sysfs file.
>
> And what happens to it today if you do either of these?
>
> Also, isn't this two different things?
>
Appending and seeking are obviously two different operations, but the
result is the same to the sysfs file system.  Because the store method
doesn't have an offset argument, it must assume that all writes are based
from the beginning of the buffer.

So if your sysfs file contains "123" and you do
   echo "45" >> mysysfsfile
instead of the expected "12345", you end up with "45" in the file with no
errors.  Opening the file, seeking, and writing gives the same type of
behavior, with no errors.

This patch just sets a few flags to make sure that errors are returned
when this behavior is seen.  Logically then, the two "features" do the
same thing (set flags), and prevent the same behavior (writing wrong
contents without error).  Hence, I grouped them into one patch.

However, if you want two even simpler patches, I'm willing to comply.  Of
the three patches I sent, this is the most important to me.


>
> Please, no {} for one line if statements.  Like the one above it :)

I'll be glad to fix this and resubmit.  I prefer to not have braces
either, but I've seen a bunch of places in the kernel where people do it,
so I really wasn't sure which was right.  It's not really called out in
the coding style doc either.
