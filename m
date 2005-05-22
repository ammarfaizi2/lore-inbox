Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVEVB60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVEVB60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 21:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVEVB60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 21:58:26 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:49577 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261291AbVEVB6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 21:58:22 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: lm-sensors@lm-sensors.org, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Date: Sat, 21 May 2005 20:58:14 -0500
User-Agent: KMail/1.8
Cc: Jean Delvare <khali@linux-fr.org>, greg@kroah.com,
       LKML <linux-kernel@vger.kernel.org>
References: <20050519213551.GA806@kroah.com> <v0eBIb5C.1116575188.8501740.khali@localhost> <25381867050520015339f02e9b@mail.gmail.com>
In-Reply-To: <25381867050520015339f02e9b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505212058.14851.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 May 2005 03:53, Yani Ioannou wrote:
> On 5/20/05, Jean Delvare <khali@linux-fr.org> wrote:
> > 
> > Hi Greg,
> > disabled. While this feature was almost not used so far, I think we
> > should have the driver not create interface files for disabled inputs.
> > In the case of temperature channels which can be dynamically enabled and
> > disabled. it would even make sense to dynamically create and delete
> > related sysfs files. Doing so would allow for memory savings and would
> > also be less error-prone for the user (presenting an interface for
> > disabled features is quite confusing IMHO).
> 
> If you think more than a few hwmon/chip drivers will benefit from
> dynamically creating the attributes, then maybe we can create some
> standard method for doing so, bmcsensors of course needs to
> dynamically allocate things, so I'd be using them too.
> 
> An earlier idea was to create a standard sysfs function(s) for
> dynamically creating device_attributes (and others), but now we will
> have custom structures with an embedded device_attribute, it looks to
> me like each attribute type would require it's own function.
>

I really think that as far as I2C subsystem goes instead of creating
arrays of attributes we should move in direction of drivers registering
individual sensor class devices. So for example it87 would register
3 fans, 3 temp, sensors and 8 voltage sensors...
 
-- 
Dmitry
