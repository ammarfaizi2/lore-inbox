Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWCQXJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWCQXJM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWCQXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:09:12 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25296
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750998AbWCQXJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:09:09 -0500
Date: Fri, 17 Mar 2006 15:08:10 -0800
From: Greg KH <gregkh@suse.de>
To: Kumar Gala <kumar@kgala.com>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: I2C-virtual and locking?
Message-ID: <20060317230810.GA3192@suse.de>
References: <6CCFFBB4-CDE0-4DC0-A4D7-A3E7398B2494@kernel.crashing.org> <7A19BA6C-6308-4DFC-B70D-A0AE0E144B59@kgala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A19BA6C-6308-4DFC-B70D-A0AE0E144B59@kgala.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 03:16:58PM -0600, Kumar Gala wrote:
> 
> On Mar 17, 2006, at 12:54 PM, Kumar Gala wrote:
> 
> >I'm looking at porting the i2c-virtual code from 2.4 to 2.6.  One  
> >thing I'm not clear on is the use of i2c_add_adapter_nolock() by  
> >the old code.  The only reference I can find related to this is:
> >
> >http://archives.andrew.net.au/lm-sensors/msg31060.html
> >
> >I can't think of a reason why locking would be in issue when adding  
> >or removing of a virtual adapter.  Anyone have an additional ides  
> >on this?
> 
> Ok, so I figured out why the _nolock() versions exist.  In  
> i2c_driver_register we take the core_list lock.  Eventually we will  
> call i2c_probe() which should call driver->attach_adapter().  For a  
> virtual bus the driver's attach_adapter() will end up calling  
> i2c_virt_create_adapter() which will end up calling i2c_add_adapter()  
> which will never get the core_list lock.
> 
> So should we integrate the concept of virtual adapters into the i2c  
> core and have it such that i2c_virt_create_adapter()/ 
> i2c_virt_remove_adapter() expects the caller to have the core_list  
> lock already?

Possibly.  Jean, what do you think?

thanks,

greg k-h
