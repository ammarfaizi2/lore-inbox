Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWC2LCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWC2LCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 06:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWC2LCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 06:02:17 -0500
Received: from illchn-static-203.199.202.17.vsnl.net.in ([203.199.202.17]:2015
	"EHLO pub.isofttechindia.com") by vger.kernel.org with ESMTP
	id S1750950AbWC2LCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 06:02:17 -0500
Message-ID: <011d01c65320$2d5c2430$7b01a8c0@shiva>
From: "shiva g" <shiva@isofttech.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
References: <010801c6531d$8283a3a0$7b01a8c0@shiva> <20060329105600.GA13383@mars.ravnborg.org>
Subject: Re: mark_bh in Linux 2.6.12 kernel
Date: Wed, 29 Mar 2006 16:31:49 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-MailScanner-From: shiva@isofttech.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the source

static __inline__ void usbd_schedule_device_bh(struct usb_device_instance 
*device)
{
    if (device && (device->status != USBD_CLOSING) && 
!device->device_bh.sync) {
        queue_task(&device->device_bh, &tq_immediate);
        mark_bh(IMMEDIATE_BH);
    }
}

Also,in the below code, will replacing "schedule_task" simply by 
"schedule_work" work?
static __inline__ void usbd_schedule_function_bh(struct usb_device_instance 
*device)
{
    if (device && (device->status != USBD_CLOSING) && 
!device->function_bh.sync) {
    schedule_task(&device->function_bh);
    }

---- Original Message ----- 
From: "Sam Ravnborg" <sam@ravnborg.org>
To: "shiva g" <shiva@isofttech.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, March 29, 2006 4:26 PM
Subject: Re: mark_bh in Linux 2.6.12 kernel


> On Wed, Mar 29, 2006 at 04:12:43PM +0530, shiva g wrote:
>> Hi all,
>>    We are porting a usb host controller driver from 2.4.18 kernel to 
>> 2.6.12
>> kernel. We face some issues with
>> mark_bh( ) call. Can anyone suggest us how we proceed in porting 
>> mark_bh( )
>> in the 2.6.12 kernel.
> Posting the source may give you more/better feedback...
>
> Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

