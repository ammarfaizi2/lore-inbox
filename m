Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWIES0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWIES0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWIES0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:26:11 -0400
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253]:7790 "HELO
	smtp105.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932150AbWIES0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:26:10 -0400
In-Reply-To: <1157441620.24916.5.camel@localhost>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net> <1157441620.24916.5.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <508B6A67-CA5B-4A81-B868-BF8A03D78888@vhugo.net>
Cc: linux-kernel@vger.kernel.org, Victor Castro <victorhugo83@yahoo.com>,
       Jon Masters <jonathan@jonmasters.org>
Content-Transfer-Encoding: 7bit
From: Victor Hugo <victor@vhugo.net>
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
Date: Tue, 5 Sep 2006 11:26:06 -0700
To: Marcel Holtmann <marcel@holtmann.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcel,

On Sep 5, 2006, at 12:33 AM, Marcel Holtmann wrote:
>
> actually it has never been really a filename. It was a simple pattern
> that the initial hotplug script and later the udev script mapped  
> 1:1 to
> a filename on your filesystem. If you check the mailing list  
> archives of
> LKML and linux-hotplug you will see that I always resisted in allowing
> drivers to include a directory path in that call. A couple of people
> tried this and it is not what it was meant to be.
>
> The MODULE_FIRMWARE approach simply makes this pattern visible via
> modinfo, because otherwise you would have to scan the source code to
> find this pattern. And to make it use you have to apply the same  
> policy
> the firmware script is applying when choosing the file. Currently this
> is a 1:1 mapping.
>
> Regards
>
> Marcel

You're right, I should have been more specific when I said  
"filename", I really meant a 1:1 mapping to a file in /lib/firmware.

My question is, should we have a generic 1:1 mapping and make it  
visible through MODULE_FIRMWARE.

  Or like Jon Masters suggested have specific version numbers in the  
pattern and have them map to specific versions in /lib/firmware and  
make them all visible through MODULE_FIRMWARE.  I believe the  
reasoning behind this was to make packaging drivers easier.


I believe that we should have a generic mapping in the driver (i.e,  
"firmware.bin") and let the admin or the userspace hotplug scripts  
take care of filename policy with a link to the correct firmware  
version.

example :

firmware.bin -> firmware-xyz.bin

The main reason for not including speciic mapping in the driver is  
that everytime a new firmware version is released the driver has to  
be updated and recompiled.  Its much easier to change a hotplug script.


-Victor
