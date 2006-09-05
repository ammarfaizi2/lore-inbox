Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWIEHdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWIEHdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWIEHdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:33:22 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:991 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751496AbWIEHdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:33:21 -0400
Subject: Re: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
From: Marcel Holtmann <marcel@holtmann.org>
To: Victor Hugo <victor@vhugo.net>
Cc: linux-kernel@vger.kernel.org, Victor Castro <victorhugo83@yahoo.com>
In-Reply-To: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
References: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 09:33:40 +0200
Message-Id: <1157441620.24916.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Victor,

> Also, I'd like to comment on Jon Masters push to include the  
> MODULE_FIRMWARE api addition.  I strongly believe that policy should  
> not be included in driver code, in this case it's in the form of a  
> filename.
> 
> The firmware loader currently needs a filename passed to it so it can  
> then pass the $FIRMWARE environment variable to the hotplug script.   
> This is ok if you provide a generic filename like "firmware.bin" and  
> then let the hotplug script worry about version numbers, i.e.  
> "firmware-x.y.z.bin"
> 
> MODULE_FIRMWARE should be used to provide the generic filenames and  
> which order the files should be loaded (request_firmware can be  
> called various times), but I think its bad to have to change the  
> driver everytime a new firmware version is released.

actually it has never been really a filename. It was a simple pattern
that the initial hotplug script and later the udev script mapped 1:1 to
a filename on your filesystem. If you check the mailing list archives of
LKML and linux-hotplug you will see that I always resisted in allowing
drivers to include a directory path in that call. A couple of people
tried this and it is not what it was meant to be.

The MODULE_FIRMWARE approach simply makes this pattern visible via
modinfo, because otherwise you would have to scan the source code to
find this pattern. And to make it use you have to apply the same policy
the firmware script is applying when choosing the file. Currently this
is a 1:1 mapping.

Regards

Marcel


