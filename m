Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUDHXRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUDHXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:17:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:44494 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261300AbUDHXRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:17:09 -0400
Date: Thu, 8 Apr 2004 16:17:07 -0700
From: Chris Wright <chrisw@osdl.org>
To: Brian King <brking@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call_usermodehelper hang
Message-ID: <20040408161707.J22989@build.pdx.osdl.net>
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <407487A6.8020904@us.ibm.com>; from brking@us.ibm.com on Wed, Apr 07, 2004 at 05:58:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Brian King (brking@us.ibm.com) wrote:
> The following patch fixes a deadlock experienced when devices are
> being added to a bus both from a user process and eventd process.
> The eventd process was hung waiting on dev->bus->subsys.rwsem which
> was held by another process, which was hung since it was calling 
> call_usermodehelper directly which was hung waiting for work scheduled
> on the eventd workqueue to complete. The patch fixes this by delaying
> the kobject_hotplug work, running it from eventd if possible. 

Couple of gratuitous formatting changes.

> -	   failure, no hotplug event is required. */
> +	 failure, no hotplug event is required. */

here

> -				  &envp[i], NUM_ENVP - i, scratch,
> -				  BUFFER_SIZE - (scratch - buffer));
> +						     &envp[i], NUM_ENVP - i, scratch,
> +						     BUFFER_SIZE - (scratch - buffer));

and here.

Overall, why does it seem to just be pushing the problem around?
Similarly, if you did your work in a child of keventd the problem would
move away.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
