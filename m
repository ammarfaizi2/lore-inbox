Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262434AbVESAj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVESAj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 20:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVESAj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 20:39:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46834 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262423AbVESAjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 20:39:19 -0400
Message-ID: <428BE01D.40205@mvista.com>
Date: Wed, 18 May 2005 17:38:53 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernel@wired-net.gr
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 timer and helper functions
References: <20050513215905.GY5914@waste.org>    <1116024419.20646.41.camel@localhost.localdomain>    <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com>    <1116027488.6380.55.camel@mindpipe>    <1116084186.20545.47.camel@localhost.localdomain>    <1116088229.8880.7.camel@mindpipe>    <1116089068.6007.13.camel@laptopd505.fenrus.org>    <1116093396.9141.11.camel@mindpipe>    <1116093694.6007.15.camel@laptopd505.fenrus.org>    <20050515100147.GA72234@muc.de> <32786.62.38.142.220.1116152602.squirrel@webmail.wired-net.gr>
In-Reply-To: <32786.62.38.142.220.1116152602.squirrel@webmail.wired-net.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel@wired-net.gr wrote:
> Hi all,
> i am running a 2.6.4 kernel on my system , and i am playing a little bit
> with kernel time issues and helper functions,just to understand how the
> things really work.
> While doing that on my x86 system and loaded a module from LDD 3rd
> edition,jit.c, which uses a dynamic /proc file to return textual
> information.
> The info that returns is in this format and uses the kernel functions
> ,do_gettimeofday,current_kernel_time and jiffies_to_timespec.
> The output format is:
> 0x0009073c 0x000000010009073c 1116162967.247441
>                               1116162967.246530656        591.586065248
> 0x0009073c 0x000000010009073c 1116162967.247463
>                               1116162967.246530656        591.586065248
> 0x0009073c 0x000000010009073c 1116162967.247476
>                               1116162967.246530656        591.586065248
> 0x0009073c 0x000000010009073c 1116162967.247489
>                               1116162967.246530656        591.586065248
> where the first two values are the jiffies and jiffies_64.The next two are
> the do_gettimeofday and current_kernel_time and the last value is the
> jiffies_to_timespec.This output text is "recorded" after 16 minutes of
> uptime.Shouldnt the last value be the same as uptime.I have attached an
> output file from the boot time until the time the function resets the
> struct and starts count from the beggining.Is this a bug or i am missing
> sth here???

You are assuming that jiffies starts at zero at boot time.  This is clearly not 
so even from your print outs.  (It starts at a value near overflow of the low 
order 32-bits to flush out problems with the roll over.)
> 
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
