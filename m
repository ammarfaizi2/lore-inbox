Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270071AbUJHRbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270071AbUJHRbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270072AbUJHRbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:31:25 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S270071AbUJHR3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:29:51 -0400
Date: Fri, 8 Oct 2004 13:29:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Greg KH <greg@kroah.com>
cc: Stephen Hemminger <shemminger@osdl.org>, linus@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect against buggy drivers
In-Reply-To: <20041008171414.GA28001@kroah.com>
Message-ID: <Pine.LNX.4.61.0410081322110.4031@chaos.analogic.com>
References: <1097254421.16787.27.camel@localhost.localdomain>
 <20041008171414.GA28001@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004, Greg KH wrote:

> On Fri, Oct 08, 2004 at 09:53:41AM -0700, Stephen Hemminger wrote:
>> +	    strlen(name) >= KOBJ_NAME_LEN ||
>
> There's no need for this check, if we fix the other usage of
> cdev->kobj.name in this file to use the proper kobject_name() and
> kobject_set_name() functions.
>
> thanks,
>
> greg k-h

Well the module name is passed in register/unregister_chrdev(). It
was not documented as the allowed length of the name so it was
possible to install a device and then only "partially" uninstall
the device so a subsequent open of the device-file would crash
the kernel.  A device name of :

 	"Octrangle Contrabulator"  23 characters

... in a test program was sufficiently-long to kill the kernel.
I recommend truncating any name to an acceptable length. This
would show up in /proc/iomem, etc., prompting the developer
to shorten the name.

Also, the new length of 20 characters is probably too short.
There was no such limitation on 2.4.x, where many modules
are being ported from.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

