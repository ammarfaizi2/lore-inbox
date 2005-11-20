Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVKTXma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVKTXma (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVKTXma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:42:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50869 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932131AbVKTXm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:42:29 -0500
Date: Sun, 20 Nov 2005 18:40:55 -0500
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: bcollins@debian.org, dan@dennedy.org,
       linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [2.6 patch] drivers/ieee1394/raw1394.c: fix a NULL pointer dereference
Message-ID: <20051120234055.GF28918@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, bcollins@debian.org, dan@dennedy.org,
	linux1394-devel@lists.sourceforge.net, scjody@steamballoon.com,
	linux-kernel@vger.kernel.org, stable@kernel.org
References: <20051120232009.GH16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120232009.GH16060@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:20:09AM +0100, Adrian Bunk wrote:
 > The coverity checker spotted that this was a NULL pointer dereference in 
 > the "if (copy_from_user(...))" case.
 > 
 > 
 > Signed-off-by: Adrian Bunk <bunk@stusta.de>
 > 
 > --- linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c.old	2005-11-20 22:08:57.000000000 +0100
 > +++ linux-2.6.15-rc1-mm2-full/drivers/ieee1394/raw1394.c	2005-11-20 22:09:34.000000000 +0100
 > @@ -2166,7 +2166,8 @@
 >  			}
 >  		}
 >  	}
 > -	kfree(cache->filled_head);
 > +	if(cache->filled_head)
 > +		kfree(cache->filled_head);
 >  	kfree(cache);
 >  
 >  	if (ret >= 0) {
 > 

How do we get that far with a NULL filled_head ?
If the kmalloc that fills cache->filled_head fails, we bail out early above.

		Dave

