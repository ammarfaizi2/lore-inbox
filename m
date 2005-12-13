Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVLMHXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVLMHXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVLMHXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:23:15 -0500
Received: from smtp109.sbc.mail.re2.yahoo.com ([68.142.229.96]:48754 "HELO
	smtp109.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932519AbVLMHXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:23:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: More platform driver questions
Date: Tue, 13 Dec 2005 02:23:12 -0500
User-Agent: KMail/1.9.1
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Alessandro Zummo <alessandro.zummo@towertech.it>
References: <20051211220023.19820e47.khali@linux-fr.org> <20051211221034.GE22537@flint.arm.linux.org.uk> <20051213081752.5de5eef4.khali@linux-fr.org>
In-Reply-To: <20051213081752.5de5eef4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512130223.13178.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Tuesday 13 December 2005 02:17, Jean Delvare wrote:
> Now the question is, is there actually any race condition there? In my
> case, the only users of the driver data are the sysfs callback
> functions, so I guess that this is all down to whether the driver core
> will unregister them before platform_driver.remove is called, or after
> it is called. If .remove is called first, then yes my code is racy and
> I'll have to fix it.

Remove might be called first if sysfs attributes were open at the time
platform_device_unregister was issued. The only thing that is guaranteed
that ->release() is called only when last reference to kobject was dropped.
 
-- 
Dmitry
