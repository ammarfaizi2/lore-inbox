Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbWA0Ka2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbWA0Ka2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWA0Ka2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:30:28 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:33668 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750725AbWA0Ka1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:30:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FW01v4D28+tW8/eFeUABz+E9T3VYVvRnhuNAacE2CNsuH8EJe/PNtz0kkjxZIHBg51dLeANbhWRgmhw8fDX+SEyD3mXZpjT5AUbjgnrGYfp2oKphalOC0NVBE7BNTY0h77JamYzkEiNcaoM5RSNNU8RPTWfal9UXVDZUf+SJAsE=
Message-ID: <7d40d7190601270230u850604av@mail.gmail.com>
Date: Fri, 27 Jan 2006 11:30:26 +0100
From: Aritz Bastida <aritzbastida@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Right way to configure a driver? (sysfs, ioctl, proc, configfs,....)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060127050109.GA23063@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7d40d7190601261206wdb22ccck@mail.gmail.com>
	 <20060127050109.GA23063@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hope this helps,
>
> greg k-h
>

Yes, it helped me much. I'll move all the configuration/statistics to
sysfs. I will read carefully the corresponding chapter in LDD3 :)
But before that, I've got a few questions with what I know:

1.- In what directory should I do all this configuration? I guess as,
I'm writing a module it should be in /sys/module/<my_module>, right?
Or would your recommend /sys/class/net or anything?

2.- In my sysfs directory I would create two subdirectories: "config"
and "stats". In the first I would place read/write files used for
configuration. For example "config/flags" for the flags variable. In
the second read-only files with the statistics. Is this approach
correct?

3.- Actually the most difficult config I must do is to pass three
values from userspace to my module. Specifically two integers and a
long (it's an offset to a memory zone I've previously defined)

struct meminfo {
        unsigned int      id;         /* segment identifier */
        unsigned int      size;     /* size of the memory area */
        unsigned long   offset;   /* offset to the information */
};

How would you pass this information in sysfs? Three values in the same
file? Note that using three different files wouldn't be atomic, and I
need atomicity.

4.- Last, you suggested that I had three files for the rx_packets count:
      rx_packets_cpu0
      rx_packets_cpu1
      rx_packets_total

     I have quite a few counters, and if that number of files is multiplied by
     the number of cpus, the number of files could be very large (imagine a
     8-cpu box), don't you think so? And after all reading a file with three
     values could be done very easily with awk...



That's all. Thank you for your help
Regards
Aritz
