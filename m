Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWBOHxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWBOHxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422865AbWBOHxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:53:41 -0500
Received: from smtp.net4india.com ([202.71.129.73]:58087 "EHLO
	smx1.net4india.com") by vger.kernel.org with ESMTP id S1422685AbWBOHxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:53:40 -0500
Message-ID: <43F2DE34.60101@designergraphix.com>
Date: Wed, 15 Feb 2006 13:24:28 +0530
From: Kaiwan N Billimoria <kaiwan@designergraphix.com>
Organization: Designer Graphix
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Stuck creating sysfs hooks for a driver..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am in the process of porting a 2.4 temperature sensor device driver (the National 
Semiconductor LM70CILD-3 temperature sensor eval board) to the 2.6 Linux kernel 
(specifically to v 2.6.15.3 <http://2.6.15.3>), with the intention of submitting it for inclusion. 
All ok, except this: am stuck on inserting an entry in /sys instead of /proc for the
driver (as that is suggested as the new "correct" interface to userspace).

I have read some documentation on sysfs and Rubini's lddbus example in
the LDD3 book; however, i am still a little confused: do we really need
to create a new /sys/bus/<driver_name> for each device inserted into
the lernel at runtime? if (probably) not, where _exactly_ do i create
my entry, and of course, _how _ exactly?

FYI, my driver is a char driver and does not require a major/minor pair as the UI is via proc, 
and hopefully now, sysfs.
(For those interested, pl find the source here: http://www.designergraphix.com/kaiwan/projects/lm70CILD3.c )

So i guess what i'm also trying to say is this: as i don't require a major/minor pair, i'm abviously
not using register_chrdev() or the cdev() interface..hence i don't have a kobject and auto-inclusion in
the sysfs tree (isn't that right?). So... how exactly do i get my sysfs hooks in - as the 
device_create_file() API requires struct device and struct device_attribute parameters.

Have any of you come across sample code/howto/tutorial out there that demonstrates just this (creating 
arbitrary sysfs hooks)? Request your help as i'm stuck here...(i also looked through
Documentation/filesystems/sysfs.txt but was unable to properly map it to code...  ). 

Perhaps, as the usual googling did not turn up a full-fledged howto on this topic, it's time for a 
knowledgeable person(s) out there to write one? I feel this would be v useful in the Documentation/ branch..
Just a suggestion..

TIA, kaiwan.


