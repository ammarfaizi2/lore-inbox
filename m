Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbTELV33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTELV33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:29:29 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:62102 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262763AbTELV3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:29:24 -0400
Message-Id: <200305122140.h4CLedGi030882@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] make clip modular 
In-reply-to: Your message of "Mon, 12 May 2003 13:26:41 PDT."
             <20030512.132641.35021107.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 12 May 2003 17:40:39 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030512.132641.35021107.davem@redhat.com>,"David S. Miller" writes
:
>   +#if defined(CONFIG_ATM_CLIP) || defined(CONFIG_ATM_CLIP_MODULE)
>    		case SIOCMKCLIP:
>    			if (!capable(CAP_NET_ADMIN))
>    				ret_val = -EPERM;
>    			else 
>   -				ret_val = clip_create(arg);
>   +				ret_val = atm_clip_ops->clip_create(arg);
>    			goto done;
>
>Do you know that atm_clip_ops is non-NULL here?  How is that?
>Also how can you legally call into a module without having a reference
>to it or somehow otherwise blocking it's unloading (f.e. by holding
>the ops semaphore)?

the rest of these ioctls need an interface to operate on.  if the
clip module is removed, no clip interfaces.  of course, this doesnt
prevent a malicous user from issuing the ioctl anyway.  i have thought
about it.  i suppose i could fix the rest of the clip troubles.
