Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWGEEUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWGEEUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 00:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWGEEUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 00:20:10 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:18069 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932399AbWGEEUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 00:20:09 -0400
Message-ID: <44AB3DF7.8080107@drzeus.cx>
Date: Wed, 05 Jul 2006 06:20:07 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resource_size_t and printk()
References: <44AAD59E.7010206@drzeus.cx> <20060704214508.GA23607@kroah.com>
In-Reply-To: <20060704214508.GA23607@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Jul 04, 2006 at 10:54:54PM +0200, Pierre Ossman wrote:
>   
>> Hi there!
>>
>> Your commit b60ba8343b78b182c03cf239d4342785376c1ad1 has been causing me
>> a bit of confusion and I thought I'd point out the problem so that you
>> can resolve it. :)
>>
>> resource_size_t is not guaranteed to be a long long, but might be a u64
>> or u32 depending on your .config. So you need an explicit cast in the
>> printk:s or you get a lot of junk on the output.
>>     
>
> That is exactly correct.  Is there somewhere in that patch that I forgot
> to fix this up properly?
>
>   

In drivers/pnp/interface.c, theres a couple of these:

@@ -264,7 +264,7 @@ static ssize_t pnp_show_current_resource
 			if (pnp_port_flags(dev, i) & IORESOURCE_DISABLED)
 				pnp_printf(buffer," disabled\n");
 			else
-				pnp_printf(buffer," 0x%lx-0x%lx\n",
+				pnp_printf(buffer," 0x%llx-0x%llx\n",
 						pnp_port_start(dev, i),
 						pnp_port_end(dev, i));
 		}


Rgds
Pierre

