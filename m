Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbULBWla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbULBWla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbULBWla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:41:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261795AbULBWka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:40:30 -0500
Message-ID: <41AF99D1.80105@pobox.com>
Date: Thu, 02 Dec 2004 17:40:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6] via-rhine: WOL band-aid
References: <20041130224014.GD29947@k3.hellgate.ch> <41ACFFA0.2030904@pobox.com> <20041130234526.GA32741@k3.hellgate.ch>
In-Reply-To: <20041130234526.GA32741@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Tue, 30 Nov 2004 18:17:52 -0500, Jeff Garzik wrote:
> 
>>I don't object to the patch, but I wonder if anything can be done to 
>>reduce the usage of "magic numbers" (numeric rather than named constants)?
> 
> 
> That's a non-trivial task if you want to do it properly. There be dragons.
> Magic numbers may be evil but at least they are honest and convenient.

The reason why they are evil is that I have no clue what a change like

-         iowrite8(ioread8(ioaddr + ConfigA) & 0xFE, ioaddr + ConfigA);
+         iowrite8(ioread8(ioaddr + ConfigA) & 0xFC, ioaddr + ConfigA);

does.

So two main points:

1) Linux is "evolution not revolution".  I'm not asking for you to 
change every magic number in the driver immediately to named constants. 
  Do it over time as you patch the driver.  Add a couple WOL constants 
now, a few more constants later, ...

2) Avoiding magic numbers is important to "reviewability" and long term 
maintenance.  Five years from now, changing "0xFE" to "0xFC" is just as 
indecipherable as it is today, but without the memory of the current WOL 
  discussions and experiences to guide us.  Source code needs to be 
_readable_.

As I said in the other email though, I applied your patch to the 
internal via-rhine queue, inside the netdev-2.6 queue.  I simply ask 
that you consider some remove-magic-numbers patches in the future.

	Jeff


