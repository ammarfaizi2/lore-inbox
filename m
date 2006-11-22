Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756807AbWKVUKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbWKVUKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756990AbWKVUKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:10:05 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:64929 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1756986AbWKVUKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:10:01 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4564AE86.2020905@s5r6.in-berlin.de>
Date: Wed, 22 Nov 2006 21:09:42 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ieee1394: nodemgr: fix deadlock in shutdown
References: <Pine.LNX.4.44L0.0611212028160.5677-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0611212028160.5677-100000@netrider.rowland.org>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Tue, 21 Nov 2006, Stefan Richter wrote:
>> There is now a /sys/bus/ieee1394/drivers/ieee1394,

(I'll rename it to nodemgr when I commit this patch.)

>> whose "bind" and "unbind" attributes are not welcome.  Is there a way
>> to disable them?
> 
> You can always prevent "bind" from operating by returning an error code
> from the driver's probe routine (although it's not clear why you would
> want to do that).  I don't think there's any way to make the "unbind"
> attribute stop working.
> 
> You could violate the layering and remove the attribute files directly.  
> But that would be a race; there would remain a brief interval between the 
> time the files were created and the time you removed them.

Does this matter if there is no device which can be unbound?

Anyway, I don't think I will go this route unless a real problem with
the attributes turns up.

> Lastly, you could remove source of your deadlock by having the unbind 
> routine for the new driver delete all the child device structures.

Hmm, I won't believe you until I actually try it. :-)

> In fact, just to make things more symmetric and logical you could have 
> the probe routine create those child devices in the first place!

Sounds good. It's on my .plan now.
-- 
Stefan Richter
-=====-=-==- =-== =-==-
http://arcgraph.de/sr/
