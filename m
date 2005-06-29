Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVF2USX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVF2USX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 16:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVF2USW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 16:18:22 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:52891 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262592AbVF2USD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 16:18:03 -0400
Message-ID: <42C301F7.4010309@free.fr>
Date: Wed, 29 Jun 2005 22:17:59 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: device_remove_file and disconnect
References: <42C2D354.6060607@free.fr> <20050629184621.GA28447@kroah.com>
In-Reply-To: <20050629184621.GA28447@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Greg KH wrote:
> On Wed, Jun 29, 2005 at 06:59:00PM +0200, matthieu castet wrote:
> 
>>Hi,
>>
>>I have a question about sysfs interface.
>>
>>If you open a sysfs file created by a module, then remove it (rmmoding 
>>the module that create this sysfs file), then try to read the opened 
>>file, you often get strange result (segdefault or oppps).
> 
> 
> What file did you do this for?  The module count should be incremented
> if you do this, to prevent the module from being unloaded.
> 
Ok, but if we unplug a device, then disconnect will be called even if we 
opened a sysfs file.

Couldn't be a race between the moment we read our private data and check 
it is valid and the moment we use it :

Process A (read/write sysfs file) 		Process B (disconnect)
recover our private data from struct device
check it is valid
						free our private data
do operation on private data


>>If it is the first case, I fear that lot's of modules are broken.
> 
> 
> Remember, only root can unload modules, so it really isn't _that_ big of
> a deal (I can do a lot more damage as root than just oopsing the
> kernel...)
> 
Yes I know, but fewer possible opps won't hurt ;)

thanks

Matthieu
