Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319309AbSHQDGm>; Fri, 16 Aug 2002 23:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319321AbSHQDGm>; Fri, 16 Aug 2002 23:06:42 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:45577 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319309AbSHQDGm>;
	Fri, 16 Aug 2002 23:06:42 -0400
Date: Fri, 16 Aug 2002 20:06:04 -0700
From: Greg KH <greg@kroah.com>
To: Adam Belay <ambx1@netscape.net>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
Message-ID: <20020817030604.GB7029@kroah.com>
References: <3D5D7E50.4030307@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5D7E50.4030307@netscape.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 20 Jul 2002 02:01:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 10:36:00PM +0000, Adam Belay wrote:
> Here's the patch as we discussed.

Um, your email client mangled the patch, dropping tabs and wrapped
lines.

> +static ssize_t device_read_driver(struct device * dev, char * buf, 
> size_t count, loff_t off)
> +{
> +    if (dev->driver)
> +        return off ? 0 : sprintf(buf,"%s\n",dev->driver->name);
> +    else
> +        return 0;
> +}

Isn't this info already in the "name" file of a driver?


> +struct device_driver * find_driver_by_name(struct bus_type * bus, char 
> * name)
> +{
> +    struct list_head * pos;
> +    struct device_driver * drv;
> +    list_for_each (pos, &bus->drivers)
> +    {
> +        drv = list_entry(pos, struct device_driver, bus_list);
> +        if (!strncmp(drv->name,name,strlen(name) - 1))
> +            return drv;
> +
> +    }
> +    return NULL;
> +
> +}

Not that I agree with this patch at all, but you might want to go read
Documentation/CodingStyle to fix up your brace placement properly.

thanks,

greg k-h
