Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTJVALg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTJVALg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 20:11:36 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:64281 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S263185AbTJVALd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 20:11:33 -0400
Message-ID: <3F95C964.8030200@rackable.com>
Date: Tue, 21 Oct 2003 17:03:48 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gloverge@baldwinlib.org
CC: linux-kernel@vger.kernel.org
Subject: Re: x86_64 aacraid help
References: <35351.68.40.98.164.1066698173.squirrel@mail.baldwinmail.org>
In-Reply-To: <35351.68.40.98.164.1066698173.squirrel@mail.baldwinmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2003 00:11:31.0757 (UTC) FILETIME=[0BEF7DD0:01C39831]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Glover wrote:
> Hello,
> 
> I have a dual opteron machine, running a cross compiled test7 on a 32 bit
> distro.  2 gigs of ram, irqbalanced, everything seems to run very well -
> except for the aacraid driver.
> 
> It's an Adaptec 2200S, with 5 U320 drives connected (seperate channels
> 3/2).  Each drive seems to read ~70MB/s on it's own, both through the
> aacraid driver and through the onboard fusion mpt controller.  Using
> hardware raid 10 with aacraid reads ~100MB/s, it seems to go no faster -
> regardless of raid levels.  However with software raid, I can nearly
> double that (half on aacraid, half onboard)  I am not able to test it with
> all drives using the onboard controller with software raid due to lack of
> cables and not wanting to destroy the boot drive.
> 
> I am wondering if there is a magical go faster button that I'm missing?
> 

   Try doing reads in the same sized chunks as your raid stripe.  Try 
something like this:

-add to /etc/sysctl.conf:
vm.max-readahead = 256
vm.min-readahead = 128

-"sysctl -e -p /etc/sysctl"

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

