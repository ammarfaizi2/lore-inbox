Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWC2NAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWC2NAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWC2NAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:00:55 -0500
Received: from mail.cs.umu.se ([130.239.40.25]:21744 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1750723AbWC2NAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:00:55 -0500
Date: Wed, 29 Mar 2006 15:00:39 +0200
From: Peter Hagervall <hager@cs.umu.se>
To: shiva g <shiva@isofttech.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: mark_bh in Linux 2.6.12 kernel
Message-ID: <20060329130039.GA20545@brainysmurf.cs.umu.se>
References: <010801c6531d$8283a3a0$7b01a8c0@shiva> <20060329105600.GA13383@mars.ravnborg.org> <011d01c65320$2d5c2430$7b01a8c0@shiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <011d01c65320$2d5c2430$7b01a8c0@shiva>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 04:31:49PM +0530, shiva g wrote:
> Here is the source
> 
> static __inline__ void usbd_schedule_device_bh(struct usb_device_instance 
> *device)
> {
>    if (device && (device->status != USBD_CLOSING) && 
> !device->device_bh.sync) {
>        queue_task(&device->device_bh, &tq_immediate);
>        mark_bh(IMMEDIATE_BH);
>    }
> }
> 
> Also,in the below code, will replacing "schedule_task" simply by 
> "schedule_work" work?
> static __inline__ void usbd_schedule_function_bh(struct usb_device_instance 
> *device)
> {
>    if (device && (device->status != USBD_CLOSING) && 
> !device->function_bh.sync) {
>    schedule_task(&device->function_bh);
>    }
> 

Have a look at http://lwn.net/images/pdf/LDD3/ch10.pdf

It should answer your questions.

	Peter

-- 
Peter Hagervall......................email: hager@cs.umu.se
Department of Computing Science........tel: +46(0)90 786 7018
University of Umeå, SE-901 87 Umeå.....fax: +46(0)90 786 6126
