Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbRDYS4K>; Wed, 25 Apr 2001 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131307AbRDYSz7>; Wed, 25 Apr 2001 14:55:59 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:2736 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S131244AbRDYSzq>; Wed, 25 Apr 2001 14:55:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Dan Kegel <dank@kegel.com>
Subject: /proc format (was Device Registry (DevReg) Patch 0.2.0)
Date: Wed, 25 Apr 2001 20:55:56 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3AE704FA.DCF1BEC6@kegel.com>
In-Reply-To: <3AE704FA.DCF1BEC6@kegel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01042520555600.00849@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 April 2001 19:10, you wrote:
> The command
>   more foo/* foo/*/*
> will display the values in the foo subtree nicely, I think.

Unfortunately it displays only the values. Dumping numbers and strings 
without knowing their meaning (and probably not even the order) is not very 
useful.

> Better to factor the XML part out to a userspace library...

But the one-value per file approach is MORE work. It would be less work to 
create XML and factor out the directory structure in user-space :)
Devreg collects its data from the drivers, each driver should contribute the 
information that it can provide about the device.
Printing a few values in XML format using the functions from xmlprocfs is as 
easy as writing
proc_printf(fragment, "<usb:topology port=\"%d\" portnum=\"%d\"/>\n",
                get_portnum(usbdev), usbdev->maxchild);

Extending the devreg output with driver-specific data means registering a 
callback function that prints the driver's data. The driver should use its 
own XML namespace, so whatever the driver adds will not break any 
(well-written) user-space applications. The data is created on-demand, so the 
values can be dynamic and do not waste any space when devreg is not used. 

The code is easy to read and not larger than a solution that creates static 
/proc entries, and holding the data completely static would take much more 
memory. And it takes less code than a solution that would create the values 
in /proc dynamically because this would mean one callback per file or a 
complicated way to specify several values with a single callback. 

bye...

 
