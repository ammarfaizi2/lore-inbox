Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVD1UKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVD1UKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVD1UK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:10:27 -0400
Received: from alog0137.analogic.com ([208.224.220.152]:54164 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262258AbVD1UJe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:09:34 -0400
Date: Thu, 28 Apr 2005 16:06:43 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Xin Zhao <uszhaoxin@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: dumb question: How to create your own log files in a kernel
 module?
In-Reply-To: <4ae3c14050428111073283bd3@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0504281557510.29750@chaos.analogic.com>
References: <4ae3c14050428111073283bd3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Xin Zhao wrote:

> Can anyone give me a hand? or point me to somewhere I can find related
> information?
>
> Thanks in advance!
>
> Xin


printk(KERN_XXX"whatever") was designed for this.

#define	KERN_EMERG	"<0>"	/* system is unusable			*/
#define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
#define	KERN_CRIT	"<2>"	/* critical conditions			*/
#define	KERN_ERR	"<3>"	/* error conditions			*/
#define	KERN_WARNING	"<4>"	/* warning conditions			*/
#define	KERN_NOTICE	"<5>"	/* normal but significant condition	*/
#define	KERN_INFO	"<6>"	/* informational			*/
#define	KERN_DEBUG	"<7>"	/* debug-level messages			*/
 	printk(KERN_DEBUG fmt,##arg)
 	printk(KERN_INFO fmt,##arg)

You could define your own, KERN_PRIVATE "<8>" and have the syslog
facility filter on that.

Other ways are to write stuff to a buffer or linked-list and
read it out using an ioctl() or read() in your module. If you
do this, make sure that your module code doesn't wait forever
if the buffer gets full.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
