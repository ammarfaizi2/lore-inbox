Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTJFMfM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTJFMfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:35:12 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:64445 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261824AbTJFMfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:35:04 -0400
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <gregkh@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/6] Backing Store for sysfs
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Message-ID: <OFA1638426.A058DCAD-ONC1256DB7.0042BE32-C1256DB7.0045176B@de.ibm.com>
Date: Mon, 6 Oct 2003 14:34:39 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 14:34:41,
	Serialize complete at 06/10/2003 14:34:41
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> The following patch set(mailed separately) provides a prototype for a 
backing 
> store mechanism for sysfs. Currently sysfs pins all its dentries and 
inodes in 
> memory there by wasting kernel lowmem even when it is not mounted. 
> 
> With this patch set we create sysfs dentry whenever it is required like 
> other real filesystems and, age and free it as per the dcache rules. We
> now save significant amount of Lowmem by avoiding un-necessary pinning. 

A more mature patch could be a possible solution of some problems we faced 
with sysfs.
I have s390 test system with ~ 20000 devices. Memory consumption _without_ 
this
patch is horribly high.
Slab uses 346028 kB of memory, most of it is dentry and inode cache. 
I tried the patch, its boots, memory usage is much better,  but it is 
somewhat 
broken with our ccw devices as I cannot bring up our ccwgroup network 
devices. 
Therefore I dont have reliable memory results.
Almost nobody would use 20000 devices on a S390, but with some shared 
OSA-card
100 or 200 devices is realistic. Even in this case, memory consumption is 
much higher
than with 2.4.

I still have to look closer on this patch, if there are some deeper 
problems. 
Until I find something, I think this patch could be really helpful for 
computers with lots of devices.

-- 
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49  7031 16 1975

