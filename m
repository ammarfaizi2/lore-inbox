Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSHQNsN>; Sat, 17 Aug 2002 09:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317997AbSHQNsN>; Sat, 17 Aug 2002 09:48:13 -0400
Received: from oak.sktc.net ([208.46.69.4]:57092 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S317994AbSHQNsN>;
	Sat, 17 Aug 2002 09:48:13 -0400
Message-ID: <3D5E5503.9000705@sktc.net>
Date: Sat, 17 Aug 2002 08:52:03 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020714
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@netscape.net>
CC: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
References: <3D5D7E50.4030307@netscape.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

> +static ssize_t device_read_driver(struct device * dev, char * buf, 
> size_t count, loff_t off)
> +{
> +    if (dev->driver)
> +        return off ? 0 : sprintf(buf,"%s\n",dev->driver->name);

You aren't checking that the name will fit in the supplied buffer - what 
is there isn't enough space? Shouldn't you either use snprintf, a 
strncpy, or a maximum field width in the sprintf?


