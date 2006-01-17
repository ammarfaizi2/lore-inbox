Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWAQEVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWAQEVD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 23:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAQEVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 23:21:03 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:13646 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750770AbWAQEVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 23:21:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lJt9czjx0PwkORqzsewkM0ISJEOgnzjAjt3H8iW4cL4PjfYtpYVlCDVdEJe0pvYluMEvWzsjx/8xpEcnWZ7oYwf0FyfkPsc4uzH12/wjthGQHprOebWTmpkGupDBvYXn+0UufdTVUgBwCaOh+OKlR0O1nuortoxRJcuXM9yaS00=  ;
Message-ID: <43CC7094.9040404@yahoo.com.au>
Date: Tue, 17 Jan 2006 15:20:36 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
References: <20060116191556.bd3f551c.diegocg@gmail.com>
In-Reply-To: <20060116191556.bd3f551c.diegocg@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> I'm having two noticeable problems with the current linus' tree
> 
> 1) Oops while watching a DVD with kaffeine (kde based video player),
>    oops pasted below.
> 

 From your oops it looks as though the radix_tree_lookup in find_get_page
has returned 0x40. It could be a flipped bit - is your memory OK?

Can you apply the attached patch and try to reproduce the oops?

> 2) This is a dual p3 machine, but only one CPU is being used to
>    run processes on it. CPU #1 is detected etc, but processes will
>    be scheduled only in CPU #0. /proc/interrupts shows that CPU #1 is
>    still used to service interrupts. I'm able to force processes to run
>    on that CPU with taskset but it won't happen automatically like it
>    usually does. dmesg here: http://terra.es/personal/diegocg/dmesg
> 

What happens if you run several infinite loops to increase the load?
Does everything still stay on CPU0?

> 
> Jan 16 18:04:07 estel kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000040

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
