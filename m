Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVAKCWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVAKCWx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 21:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVAKCWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 21:22:17 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:25144 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262587AbVAKCUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 21:20:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EI1aIWp1hBH+A6qKdgPaBKFa7Kyei+3QJQz5N6wqpYc1gxeOyj0uCLwA06y/tEKVUT2uvWDATWErY/U0h9YY14E3Ktqhyb1CKChkucvXT+kEF11JBXnTuHiGEyocqUztVAM4JnFHDeSGO05XumJ59UMJXHtETGJIGHvCQUXQyH0=
Message-ID: <9e4733910501101820388563bb@mail.gmail.com>
Date: Mon, 10 Jan 2005 21:20:49 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Export symbol from I2C eeprom driver
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050110234726.GE3286@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339105010721347fbeb907@mail.gmail.com>
	 <20050108055315.GC8571@kroah.com>
	 <9e473391050107220875baa32b@mail.gmail.com>
	 <20050108222719.GA3226@kroah.com>
	 <9e473391050108161426b36e4d@mail.gmail.com>
	 <20050110234726.GE3286@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005 15:47:26 -0800, Greg KH <greg@kroah.com> wrote:
> > I don't want to load the driver from the script because the radeon
> > driver is creating a sysfs link into the eeprom directory from the
> > radeon one.
> 
> How are you getting the kobject to the eeprom directory from the radeon
> driver?
> 

I own the private I2C bus and eeprom is the only chip that will attach
to the bus. I need to do the link in the driver since there are four
busses and upto two monitors. The driver knows how to pair the head up
with the right bus.

if (dev_priv->primary_head.connector != ddc_none)
  list_for_each(item,
&dev_priv->i2c[dev_priv->primary_head.connector].adapter.clients) {
    client = list_entry(item, struct i2c_client, list);
    sysfs_create_link(&dev->primary.dev_class->kobj,
&client->dev.kobj, "monitor");
    break;
  }

-- 
Jon Smirl
jonsmirl@gmail.com
