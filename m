Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUBJTqZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUBJTqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:46:25 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:28397 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266186AbUBJTqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:46:23 -0500
Message-ID: <40293508.1040803@nortelnetworks.com>
Date: Tue, 10 Feb 2004 14:46:16 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Bell <kernel@mikebell.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca>
In-Reply-To: <20040210192456.GB4814@tinyvaio.nome.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell wrote:

> Why does it make management easier to have no predictable name for a
> device?

I believe this is a misconception.

Udev uses standard rules by default.  If the end-user (or their distro) 
wants to add additional rules or override these rules, they can do that.

> I think the space savings are a pretty good reason alone. Add to that
> the fact I think devfs would be a good idea even if it cost MORE
> memory... You can mount a devfs on your RO root instead of needing to
> mount a tmpfs on /dev and then run udev on that.

Don't you have to explicitly mount /dev as type devfs?  How is this 
different than mounting it as tmpfs?

> A devfs gives
> consistant names for devices in addition to the user's preferred
> user-space dictated naming scheme. 

Udev gives consistant names unless you explicitly override it.

> A devfs means even with dynamic
> majors/minors, even if you have new hardware in your system, your /dev
> at least has the devices it needs.

So does udev.

The real gain with devfs is that you don't need to have any userspace 
intervention to get /dev/ populated with a baseline set of device nodes. 
  As long as the udev code is sufficiently robust and compact, I don't 
have a problem with needing a userspace daemon.  Anyone that *really* 
cares about compactness (embedded people, for instance) is going to use 
a static /dev tree pruned down to the bare minimum.  For everyone else, 
the overhead of having udev running should be unnoticeable.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
