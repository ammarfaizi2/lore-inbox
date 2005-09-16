Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbVIPPoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbVIPPoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbVIPPoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:44:38 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:28372 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161163AbVIPPoh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 11:44:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=reUAV1elmENiI/BbgxGWRMEwQdDk2uj53RlHXx7VMJ1mn+QmHaVQJa/knpQbbbMX6qiNMpPrks6pd7Q6H3jfRuMB4j+j4bhn1Yolw+AejZgV7dlzfYzOu977qNUvnxSbeHTaqbkX0lWzLqt1sIgZlf6vPMhKrOP7fuu5Y3Y7snw=
Message-ID: <d120d50005091608447d816585@mail.gmail.com>
Date: Fri, 16 Sep 2005 10:44:36 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFC] subclasses in sysfs to solve world peace
Cc: Kay Sievers <kay.sievers@vrfy.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
       Patrick Mochel <mochel@digitalimplant.org>, airlied@linux.ie
In-Reply-To: <20050916080237.GD10007@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916002036.GA6149@suse.de> <20050916010438.GA12759@vrfy.org>
	 <200509152023.44003.dtor_core@ameritech.net>
	 <20050916080237.GD10007@midnight.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Thu, Sep 15, 2005 at 08:23:43PM -0500, Dmitry Torokhov wrote:
> > On Thursday 15 September 2005 20:04, Kay Sievers wrote:
> > > I like that the child devices are actually below the parent device
> > > and represent the logical structure. I prefer that compared to the
> > > symlink-representation between the classes at the same directory
> > > level which the input patches propose.
> >
> > Why don't we take it a step further and abandon classes altogether?
> > This way everything will grow from their respective hardware devices.
> 
> That'd seem like a quite a good idea to me. ;)
> 

You just saying that ;)

Look at I2C/sensors people. They are moving from having every sensor
crampled into I2C bus to hwmon class so all the sensors can be easily
located (by some program or what's not).

> > Class represent a set of objects with similar characteristics. In
> > this regard event0 is no "lesser" than input0.
> 
> Well, input0 itself can't be accessed from userspace, so it's different.
> 

Why is this a factor? We are not talking about /dev here. We have a
lot of things in sysfs that are not directly accessible from
userspace.

> > Although they are
> > linked they are objects of the same importance. I do want to see
> > all input interfaces without scanning bunch of directories.
> 
> A directory with symlinks to all the interfaces of the class might make
> sense.
>

I'll try fix the patch I posted last night (that implements the above,
or at least what Kay described with sub-devices residing under their
parent devices and symlinked into their classes), I believe it could
also be used for block, so it will be like:

.../block/
|-- devices
|   |-- sda
|   |   |-- device -> ../../../../
|   |   |-- sda1
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../block/partitions/sda1
|   |   |-- sda2
|   |   |   |-- dev
|   |   |   `-- device -> ../../../../../block/partitions/sda2
...
`-- partitions
   |-- sda1 -> ../../../class/block/devices/sda/sda1
   |-- sda2 -> ../../../class/block/devices/sda/sda2

-- 
Dmitry
