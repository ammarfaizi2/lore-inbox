Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWJLEba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWJLEba (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 00:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWJLEba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 00:31:30 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:14092 "EHLO
	asav12.insightbb.com") by vger.kernel.org with ESMTP
	id S965260AbWJLEba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 00:31:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAJNiLUWBSopPLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
Date: Thu, 12 Oct 2006 00:31:17 -0400
User-Agent: KMail/1.9.3
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061010065359.GA21576@havoc.gtf.org> <452B6569.7050404@hhs.nl> <20061010113441.24b19b99.khali@linux-fr.org>
In-Reply-To: <20061010113441.24b19b99.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610120031.20097.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 October 2006 05:34, Jean Delvare wrote:
> Hans,
> 
> > > * We want to delete all the device files at regular cleanup time (after
> > >   unregistering with the hwmon class).
> > 
> > Is this really nescesarry? AFAIK the files get deleted when the device
> > gets deleted.
> 
> The point is that the device shouldn't be deleted if we were following
> the device driver model. After all the uGuru device exists in your
> system before the abituguru driver is loaded, and is still there after
> the driver is unloaded.
> 
> Now I agree that for now it won't make a difference, be we are
> preparing for the future, and all other hardware monitoring drivers
> were updated that way already.
> 
> > > * It's OK to call device_create_file() on a non-existent file, so the
> > >   error path can be simplified.
> > 
> > ?? You mean device_remove_file I assume?
> 
> Oops, yes, that was a typo, sorry.
> 

I know I sound like a roken record but this driver would benefit from
using attribute_group.

-- 
Dmitry
