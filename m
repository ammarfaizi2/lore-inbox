Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUCJVYK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCJVYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:24:10 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:17929 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262705AbUCJVXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:23:19 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Davis, Todd C" <todd.c.davis@intel.com>,
       "Corey Minyard" <minyard@acm.org>, "Adrian Bunk" <bunk@fs.tum.de>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Date: Wed, 10 Mar 2004 23:20:20 +0200
User-Agent: KMail/1.5.4
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <greg@kroah.com>, <sensors@stimpy.netroedge.com>,
       "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
References: <F274AE5A8F65A848906BEB9DDFC7674C0E83DD@hdsmsx403.hd.intel.com>
In-Reply-To: <F274AE5A8F65A848906BEB9DDFC7674C0E83DD@hdsmsx403.hd.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403102320.20474.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 21:50, Davis, Todd C wrote:
> The problem that is being addressed here is the need to avoid process
> switching when sending IPMI messages over the SMBus/I2C bus. When the
> kernel has panic'ed or is shutting down bus transactions need to
> complete so the i2c bus drivers need to spin rather than calling
> schedule.
>
> The i2c_spin_delay is a flag that supports a revised inline function
> i2c_delay() that was in i2c.h at one time.
>
> static inline void i2c_delay(signed long timeout)
>  {
> 	if( i2c_spin_delay ) {
> 		int i;
> 		for( i=0 ; i<100 ; i++ )
> 			udelay(timeout*(1000000/HZ/100));
> 	} else {
> 		set_current_state(TASK_INTERRUPTIBLE);
> 		schedule_timeout(timeout);
> 	}
>  }

too big for inline keyword
--
vda

