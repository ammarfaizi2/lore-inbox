Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKLAWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKLAWk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 19:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKLAWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 19:22:40 -0500
Received: from c-67-177-11-17.hsd1.ut.comcast.net ([67.177.11.17]:8576 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1750723AbVKLAWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 19:22:39 -0500
Message-ID: <437521FB.6040000@soleranetworks.com>
Date: Fri, 11 Nov 2005 15:58:03 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.9 reporting 1 Gigabyte/second throughput on bio's, timer skew
 possible?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running one of our 3U appliances with dual 9500 Series 3Ware 
Controllers.  The unit is an online demo system accessible from
the internet via SSH to the public for solera networks Linux appliance 
demos running the DSFS file system:

(ncurses)
demo.soleranetworks.com
Account:  demo
password:  demo

(text ncurses)
demo.soleranetworks.com
Account: demo-text
password: demo

I have allocated 393,216 bio buffers I statically maintain in a chain 
and am running the dsfs file system with 3 x gigabit links fully 
saturated.  meta-data
increases the write sizes to 720 MB/Second on dual 9500 controllers with 
8 drives each (total of 16) 7200 RPM Drives.  I am seeing some 
congestion and bursting on the bio chains as they are submitted.  I am 
not aware of anyone pushing 2.6 to these limits at present with this 
type of architecture.  I have split
the kernel address space 3GB/1GB 3-kernel 1-user space in order to 
create enough memory to run this file system with 2GB of cache.

DSFS dynamically generates html status files form within the file 
system.  When the system gets somewhat behind, I am seeing bursts > 1 
GB/Second which exceeds the theoretical limit of the bus.   I have a 
timer function that runs every second and profiles the I/O throughput 
created by DSFS with bio submissions and captured packets.  I am asking 
if there is clock skew at these data rates with use of the timer 
functions.  The system appears to be sustaining 1GB/Second throughput on 
dual controllers.  I have verified through data rates the system is 
sustaining 800 megabytes/second with these 1GB/S bursts.  I am curious 
if there is potentially timer skew at these higher rates since I am 
having a hard time accepting that I can push 1GB/S through a bus rated 
at only 850 MB/S for DMA based transfers.   The unit is accessible by 
the general public, since its a demo unit andwe are unconcerned about 
folks getting on the system.  Folks are welcome to look and if anyone 
has any thoughts on this, please let me know.  I am concerned that the 
timer functions are not always ending on second boundries, which would 
explain the higher reported numbers.  Windows 2003 does not approach 
these performance numbers, BTW, so Linux appears to win on raw 
performance for vertical File System Apps.

dsfs file system mounted at /var/ftp can be viewed:
ftp://demo.soleranetworks.com/

Stats pages generated from dsfs:

capture stats:
ftp://demo.soleranetworks.com/stats/capture.html
storage stats:
ftp://demo.soleranetworks.com/stats/storage.html
dsfs cache stats:
ftp://demo.soleranetworks.com/stats/cache.html
network interface stats:
ftp://demo.soleranetworks.com/stats/network.html
virtual network interface maps:
ftp://demo.soleranetworks.com/stats/virtual.html

Jeff

