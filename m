Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbVLLAmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVLLAmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVLLAmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:42:09 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:43660 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750958AbVLLAmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:42:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: More platform driver questions
Date: Sun, 11 Dec 2005 19:41:56 -0500
User-Agent: KMail/1.8.3
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <20051211220023.19820e47.khali@linux-fr.org> <20051211221034.GE22537@flint.arm.linux.org.uk>
In-Reply-To: <20051211221034.GE22537@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111941.57216.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 17:10, Russell King wrote:
> > 2* Is it OK to tag platform_driver.probe and .remove __devinit and
> > __devexit, respectively?
> 
> Yes, provided that you only have one platform device which is never
> removed independently of being a module or hotplug.

It just occured to me - every platform driver should rely on ->probe()
and ->remove() because now we have "bind" and "unbind" attributes and
there are talks about providing a method to disable automatic binding
of drivers across bus or even entire system. So even without hotplug
there possibility that user might want to disable device by unbinding
driver.

I think it pretty safe to mark them __devinit and __devexit because they
become noops if CONFIG_HOTPLUG is set. There is trouble with "bind" and
"unbind" sysfs attributes when CONFIG_HOTPLUG=N but Greg promised to fix
that.
  
-- 
Dmitry
