Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUDHXCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263084AbUDHXCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:02:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:48514 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263019AbUDHXCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:02:18 -0400
Date: Thu, 8 Apr 2004 15:47:13 -0700
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] call_usermodehelper hang
Message-ID: <20040408224713.GD15125@kroah.com>
References: <4072F2B7.2070605@us.ibm.com> <20040406172903.186dd5f1.akpm@osdl.org> <20040407061146.GA10413@kroah.com> <407487A6.8020904@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407487A6.8020904@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 05:58:46PM -0500, Brian King wrote:
> The following patch fixes a deadlock experienced when devices are
> being added to a bus both from a user process and eventd process.
> The eventd process was hung waiting on dev->bus->subsys.rwsem which
> was held by another process, which was hung since it was calling 
> call_usermodehelper directly which was hung waiting for work scheduled
> on the eventd workqueue to complete. The patch fixes this by delaying
> the kobject_hotplug work, running it from eventd if possible. 

But why?  Will this not still cause the same deadlock eventually?  The
call_usermodehelper function uses keventd, so what about users who call
that function directly?

Also, you gratitously changed some of the whitespace in the file you
were modifying, which isn't a nice thing to do :)

thanks,

greg k-h
