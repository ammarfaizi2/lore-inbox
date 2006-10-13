Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWJMScv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWJMScv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWJMScv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:32:51 -0400
Received: from bay0-omc1-s28.bay0.hotmail.com ([65.54.246.100]:63448 "EHLO
	bay0-omc1-s28.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751308AbWJMScu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:32:50 -0400
Message-ID: <BAY20-F2590BB342DED17F10A6783D80A0@phx.gbl>
X-Originating-IP: [80.178.105.199]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <20061013165840.GA9517@dreamland.darkstar.lan>
From: "Burman Yan" <yan_952@hotmail.com>
To: kronos.it@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Remn Yan <yan_952@hotmail.com> ha scritto:
Date: Fri, 13 Oct 2006 20:32:48 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Oct 2006 18:32:50.0192 (UTC) FILETIME=[FCC6C100:01C6EEF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>From: Luca Tettamanti <kronos.it@gmail.com>
>To: Yan Burman <yan_952@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Remn Yan <yan_952@hotmail.com> ha scritto:
>Date: Fri, 13 Oct 2006 18:58:40 +0200
>
>Burman Yan <yan_952@hotmail.com> ha scritto:
> > I would like to hear your remarks on this version.
>
>A couple of small issues:
>
> > +/* Sysfs stuff */
> > +static ssize_t mdps_position_show(struct device *dev,
> > +                                  struct device_attribute *attr, char 
>*buf)
> > +{
> > +	int x, y;
> > +	mdps_get_xy(mdps.device->handle, &x, &y);
> > +	return sprintf(buf, "(%d, %d)\n", x, y);
> > +}
>
>hdaps doesn't have the space between the numbers.
>

Point taken and fixed. I missed that. I looked at calibrate and saw that 
there are no spaces :)

> > +static ssize_t mdps_position3d_show(struct device *dev,
> > +                                    struct device_attribute *attr, char 
>*buf)
> > +{
>[...]
> > +	return sprintf(buf, "(%d, %d, %d)\n", x, y, z);
> > +}
>
>I'd also remove the space here for consistency.
>Also sysfs should carry "unformatted" data, I would use:
>
>sprintf(buf, "%d %d %d\n", x, y, z);
>

Removed the spaces, but the brackets are there for consistency with the 2d 
version and hdaps.

>Maybe we should take a moment to think about an interface for both hdaps
>and this one.
>
> > +static ssize_t mdps_calibrate_store(struct device *dev,
> > +                   struct device_attribute *attr, const char *buf, 
>size_t count)
> > +{
> > +	mdps_calibrate_mouse();
> > +	return count;
> > +}
>
>No locking here?
>


I don't want to lock it here, since the mouse polling kthread is heavy as it 
is.
I'd rather report a wrong value of mouse position while recalibrating.
The way I see it, if you're recalibrating your mouse, chances are you're not 
playing at the same precise millisecond. In my opinion it's worth more 
battery life.


> > +static ssize_t mdps_rate_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
>[...]
> > +	return sprintf(buf, "sampling rate:\t%dHz\n", rate);
> > +}
>
>Raw value, i.e. sprintf(buf, "%d\n", rate).
>
>

Point taken and fixed.

I also found that I missed a comment in Kconfig after switching from proc to 
sysfs, but
I'll post the corrected version after I have more fixes to it.

Thanks for noticing.

Yan

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

