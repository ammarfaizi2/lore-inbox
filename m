Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751395AbWJMQ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWJMQ6i (ORCPT <rfc822;akpm@zip.com.au>);
	Fri, 13 Oct 2006 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWJMQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:58:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:11783 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751395AbWJMQ6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:58:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=I2UXg2ah4hQFrar/19OeUb1KfvM7u/UEu1XXxbcA6auR09t0fKzrshJEiccQAimozDIjG7R+M6jTMCj4QijOBkAfjCt4RQ/MvcNBLXqCVh5Mif9sbda9E/Fgs3xJSfut2oKDyh2L6IIu5xVE11zY3WJWrSvuFjTP3gykDrVaMps=
Date: Fri, 13 Oct 2006 18:58:40 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Yan Burman <yan_952@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Remn Yan <yan_952@hotmail.com> ha scritto:
Message-ID: <20061013165840.GA9517@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F24D6EADDDBE9963D7307A4D80A0@phx.gbl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burman Yan <yan_952@hotmail.com> ha scritto:
> I would like to hear your remarks on this version.

A couple of small issues:

> +/* Sysfs stuff */
> +static ssize_t mdps_position_show(struct device *dev,
> +                                  struct device_attribute *attr, char *buf)
> +{
> +	int x, y;
> +	mdps_get_xy(mdps.device->handle, &x, &y);
> +	return sprintf(buf, "(%d, %d)\n", x, y);
> +}

hdaps doesn't have the space between the numbers.

> +static ssize_t mdps_position3d_show(struct device *dev,
> +                                    struct device_attribute *attr, char *buf)
> +{
[...]
> +	return sprintf(buf, "(%d, %d, %d)\n", x, y, z);
> +}

I'd also remove the space here for consistency.
Also sysfs should carry "unformatted" data, I would use:

sprintf(buf, "%d %d %d\n", x, y, z);

Maybe we should take a moment to think about an interface for both hdaps
and this one.

> +static ssize_t mdps_calibrate_store(struct device *dev,
> +                   struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	mdps_calibrate_mouse();
> +	return count;
> +}

No locking here?

> +static ssize_t mdps_rate_show(struct device *dev,
> +                              struct device_attribute *attr, char *buf)
> +{
[...]
> +	return sprintf(buf, "sampling rate:\t%dHz\n", rate);
> +}

Raw value, i.e. sprintf(buf, "%d\n", rate).


Luca
-- 
Colui che sorride quando le cose vanno male ha pensato a qualcuno a cui
dare la colpa.
