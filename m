Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129928AbQKEXQJ>; Sun, 5 Nov 2000 18:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbQKEXQA>; Sun, 5 Nov 2000 18:16:00 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:2310 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129928AbQKEXPv>; Sun, 5 Nov 2000 18:15:51 -0500
Date: Sun, 5 Nov 2000 23:15:27 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10) 
In-Reply-To: <6647.973334586@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.21.0011052257130.6733-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2000, Keith Owens wrote:

> Move this to "in progress" and add MTD code breaks with
> CONFIG_MODVERSIONS, for the same reason.  I wrote a patch to replace
> get_module_symbol a week ago and sent it to the DRM/AGP/MTD people for
> testing - no response yet.

Sorry for the delay. I don't actually have any appropriate hardware any
more that doesn't now have a JFFS root filesystem, making it difficult to
test the modular code :)

Your patch looks like it'll work. Although I don't really see any
advantage over {get,put}_module_symbol() in this case, it does look like
it can be used to finally provide module persistent storage, which will be
useful.

However, the easy fix for the MTD code is to use EXPORT_SYMBOL_NOVERS()
for the offending symbols. It's the most appropriate for putting into 2.4.

If the inter_module_{put,get} change is really going into 2.4 at this
late stage, then I'll merge your patch into my CVS tree and look at
updating the MTD code in the 2.4 tree to a more recent version. I was
intending to leave that for later, though.

Also - if it goes into 2.4, please make sure it goes into 2.2 as well.
get_module_symbol() is already broken there because it doesn't increase
the module's use count, and it'll prevent an ugly mess of ifdefs.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
