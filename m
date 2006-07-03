Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWGCN2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWGCN2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWGCN2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:28:06 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:42644 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751143AbWGCN2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:28:05 -0400
Message-ID: <44A91ABA.8060304@s5r6.in-berlin.de>
Date: Mon, 03 Jul 2006 15:25:14 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Michael Hanselmann <linux-kernel@hansmi.ch>
CC: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org, khali@linux-fr.org,
       linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org,
       johannes@sipsolutions.net, chainsaw@gentoo.org
Subject: Re: [RFC] Apple Motion Sensor driver
References: <20060702222649.GA13411@hansmi.ch> <1151921567.10711.22.camel@localhost.localdomain> <20060703104547.GA25342@hansmi.ch>
In-Reply-To: <20060703104547.GA25342@hansmi.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hanselmann wrote:
> On Mon, Jul 03, 2006 at 12:12:47PM +0200, Stelian Pop wrote:
>> > +
>> > +static DEVICE_ATTR(mouse, S_IRUGO | S_IWUSR,
>> > +	ams_mouse_show_mouse, ams_mouse_store_mouse);

[I think the following discussion is about ams_show_xyz, not
ams_mouse_show_mouse.]

>> I would prefer three different files for x, y and z instead of a single
>> one... 
> 
> Because of the way the values are calculated with orientation, that
> would mean that if a program needs all three, either all values are read
> three times or the ams_sensors function gets much more complicated.
> 
> To prevent it from having to read them three times in a row, I joined
> all three values.

I don't know what a software will be doing with it, but "displacement"
(and its time derivatives "velocity", "acceleration", "jerk") is a
vector. Why not write the component-wise representation of the vector
into a single sysfs attribute? Especially if this keeps the kernel code
simple and small. I suppose even userspace code which evaluates the
attribute is in many cases simpler (and more precise anyway) if only a
single attribute is used.
-- 
Stefan Richter
-=====-=-==- -==- ===--
http://arcgraph.de/sr/
