Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVGCSM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVGCSM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 14:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGCSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 14:12:57 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:51871 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261490AbVGCSLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 14:11:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=YYJaV9Ca3cqQZ8YNmar/gSkvpubW8Qs+e8ytjcoFRLwr1guGeu4b2xCs7FAppbO7Ep9ukjTvlV5V51ATUB2dkYlOtFdoFpDKN0o7zZcgtnWI6s+dwTTj8UfbF0gBZoGPSgCWlxPK8xOvNrdClL2EQCefNv/7FL5dQC2WxCcJZjs=
Message-ID: <42C82BBB.9090008@gmail.com>
Date: Sun, 03 Jul 2005 20:17:31 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <abonilla@linuxwireless.org>
CC: Vojtech Pavlik <vojtech@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <1119559367.20628.5.camel@mindpipe>	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz> <9a8748490507030407547fa29b@mail.gmail.com>
In-Reply-To: <9a8748490507030407547fa29b@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------010600020604020205040509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010600020604020205040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jesper Juhl wrote:
> On 7/3/05, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
>>On Sun, Jul 03, 2005 at 03:37:06AM -0500, Alejandro Bonilla wrote:
>>
>>
>>>Guys,
>>>
>>>   We might have something here. If you are a driver writer, developer
>>>or want to help us, this is when.
>>>
>>>PLEASE read the following article, it has the data of a guy that made a
>>>driver in IBM for Linux and he described the driver he made. He cannot
>>>release it, but he explained it and someone can write one. Believe me,
>>>that I would do it, if I would have any knowledge. ;-)
>>>http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
>>
>>This should indeed be enough to write a Linux driver.
>>
> 
> I'll give it a shot. I've got the day off today so I'll try a simple
> module and test it on my T42. I'll post whatever I come up with
> tonight.
> 
Ok, just to show you people what I've done so far.
This doesn't work yet, but it should be resonably close (at least it
builds ;)

Stuff the two (attached) files into some directory, then build with
     make -C /path/to/kernel/source SUBDIRS=$PWD modules

it may blow up, it may do anything, I take no responsability for it in
its current state - play with it at your own risk.


-- 
Jesper Juhl


--------------010600020604020205040509
Content-Type: text/plain;
 name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Makefile"

obj-m := ibm_hdaps.o


--------------010600020604020205040509
Content-Type: text/x-csrc;
 name="ibm_hdaps.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibm_hdaps.c"

/*
 * Driver for IBM HDAPS (HardDisk Active Protection system)
 *
 * Based on the document by Mark A. Smith available at
 * http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
 *
 * Copyright (c) 2005  Jesper Juhl <jesper.juhl@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */



#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/config.h>
#include <linux/compiler.h>
#include <linux/ioport.h>
#include <linux/timer.h>
#include <linux/delay.h>
#include <asm/io.h>



#define HDAPS_LOW_PORT	0x1600	/* first port used by accelerometer */
#define HDAPS_NR_PORTS	0x30	/* nr of ports total - 0x1600 through 0x162f */

#define STATE_STALE	0x00	/* accelerometer data is stale */
#define STATE_FRESH	0x50	/* accelerometer data fresh fresh */

#define REFRESH_ASYNC	0x00	/* do asynchronous refresh */
#define REFRESH_SYNC	0x01	/* do synchronous refresh */

/* 
 * where to find the various accelerometer data
 * these map to the members of struct hdaps_accel_data
 */
#define HDAPS_PORT_STATE	0x1611
#define	HDAPS_PORT_XACCEL	0x1612
#define HDAPS_PORT_YACCEL	0x1614
#define HDAPS_PORT_TEMP		0x1616
#define HDAPS_PORT_XVAR		0x1617
#define HDAPS_PORT_YVAR		0x1619
#define HDAPS_PORT_TEMP2	0x161b
#define HDAPS_PORT_UNKNOWN	0x161c
#define HDAPS_PORT_KMACCT	0x161d

/* structure to hold data from the accelerometer */
struct hdaps_accel_data {
	unsigned char	state;		/* accelerometer state */
	unsigned short	x_accel;	/* X acceleration value */
	unsigned short	y_accel;	/* Y acceleration value */
	unsigned char	temp;		/* accelerometer temp (in celcius) */
	unsigned short	x_variation;	/* this might hold something else */
	unsigned short	y_variation;	/* this might hold something else */
	unsigned char	temp2;		/* really the temperature again? */
	unsigned char	unknown;	/* we don't know what this holds */
	unsigned char	km_activity;	/* any keyboard/mouse activity */
};

/* check a port latch for a given value */
static unsigned int check_latch(unsigned short port, unsigned char val)
{
	unsigned read;
	read = inb(port & 0xff);
	if (read == val)
		return 1;

	return 0;
}

/* wait for a latch to get a certain value for up to 50 microseconds */
static unsigned int wait_latch(unsigned short port, unsigned char val)
{
	unsigned char i;
	
	for (i = 0; i < 10; i++) {
		if (check_latch(port, val))
			return 1;
		udelay(5);
	}

	return 0;
}

/* check the refresh state of the accelerometer */
unsigned int check_state(void)
{
	unsigned state;

	state = inb(0x1604);
	if (state != STATE_FRESH)
		state = STATE_STALE;

	return state;
}

/* request a refresh from accelerometer */
static int request_refresh(int sync)
{
	unsigned state;
	
	state = check_state();
	if (state == STATE_FRESH) {
		return 1;
	} else {
		outb(0x1610, 0x11);
		outb(0x161f, 0x01);
		if (sync)
			return wait_latch(0x1604, STATE_FRESH);
	}

	/* if we get here we didn't do a synchronous wait and all we can say
	 * is that we initiated the refresh request, so the state *ought* to
	 * be fresh when read next time - but no guarantees.
	 * Do a synchronous wait if you need to be sure you read fresh data.
	 */
	return 1;
}

/* indicate to the accelerometer that we are done reading data */
static void tell_accelerometer_done(void)
{
	inb(0x161f);
	inb(0x1604);
}

/* read accelerometer data into provided struct, return success or failure */
unsigned int accelerometer_read(struct hdaps_accel_data *data) {
	/* do a sync refresh - we need to be sure we read fresh data */
	if (!request_refresh(REFRESH_SYNC))
		return 0;
	
	data->state = inb(HDAPS_PORT_STATE);
	data->x_accel = inw(HDAPS_PORT_XACCEL);
	data->y_accel = inw(HDAPS_PORT_YACCEL);
	data->temp = inb(HDAPS_PORT_TEMP);
	data->x_variation = inw(HDAPS_PORT_XVAR);
	data->y_variation = inw(HDAPS_PORT_YVAR);
	data->temp2 = inb(HDAPS_PORT_TEMP2);
	data->unknown = inb(HDAPS_PORT_UNKNOWN);
	data->km_activity = inb(HDAPS_PORT_KMACCT);

	tell_accelerometer_done();
	return request_refresh(REFRESH_ASYNC);
}

/* initialize the accelerometer, wait up to `timeout' seconds for success */
int accelerometer_init(unsigned int timeout)
{
	unsigned long wait_until = jiffies + timeout * HZ;
	
	outb(0x13, 0x1610);
	outb(0x01, 0x161f);
 	if (!wait_latch(0x00, 0x161f))
		return -EIO;
	if (!wait_latch(0x03, 0x1611))
		return -EIO;
	outb(0x17, 0x1610);
	outb(0x81, 0x1611);
	outb(0x01, 0x161f);
	if (!wait_latch(0x00, 0x161f))
		return -EIO;
	if (!wait_latch(0x00, 0x1611))
		return -EIO;
	if (!wait_latch(0x60, 0x1612))
		return -EIO;
	if (!wait_latch(0x00, 0x1613))
		return -EIO;
	outb(0x14, 0x1610);
	outb(0x01, 0x1611);
	outb(0x01, 0x161f);
	if (!wait_latch(0x00, 0x161f))
		return -EIO;
	outb(0x10, 0x1610);
	outb(0xc8, 0x1611);
	outb(0x00, 0x1612);
	outb(0x02, 0x1613);
	outb(0x01, 0x161f);
	if (!wait_latch(0x00, 0x161f))
		return -EIO;
	if (!request_refresh(REFRESH_SYNC))
		return -EIO;
	if (!wait_latch(0x00, 0x1611))
		return -EIO;

	while (1) {
		if (wait_latch(0x02, 0x1611)) {
			struct hdaps_accel_data data;
			/* 
			 * accelerometer initialized, do an initial read and
			 * return success.
			 */
			 accelerometer_read(&data);
			return 0;
		} else if (time_before(jiffies, wait_until)) {
			set_current_state(TASK_INTERRUPTIBLE);
			schedule_timeout(HZ);
		} else {
			/* we timed out, return failure */
			return -ENXIO;
		}
	}
}

static int ibm_hdaps_init(void)
{
	int i;
	int retval;
	struct hdaps_accel_data data;

	printk(KERN_WARNING "init 1\n");
	if (!request_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS, "ibm_hdaps"))
		return -ENXIO;

	printk(KERN_WARNING "init 2\n");
	retval = accelerometer_init(10);
	if (retval)
		return retval;

	printk(KERN_WARNING "init 3\n");
	for (i = 0; i < 5; i++) {
		accelerometer_read(&data);
		printk(KERN_WARNING "state = %d\n", data.state);
		printk(KERN_WARNING "x_accel = %d\n", data.x_accel);
		printk(KERN_WARNING "y_accel = %d\n", data.y_accel);
		printk(KERN_WARNING "temp = %d\n", data.temp);
		printk(KERN_WARNING "x_variation = %d\n", data.x_variation);
		printk(KERN_WARNING "y_variation = %d\n", data.y_variation);
		printk(KERN_WARNING "temp2 = %d\n", data.temp2);
		printk(KERN_WARNING "unknown = %d\n", data.unknown);
		printk(KERN_WARNING "km_activity = %d\n", data.km_activity);
		printk(KERN_WARNING "\n");
	}

	printk(KERN_WARNING "init 4\n");
	return 0;
}

static void ibm_hdaps_exit(void)
{
	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
}

module_init(ibm_hdaps_init);
module_exit(ibm_hdaps_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Jesper Juhl");


--------------010600020604020205040509--
