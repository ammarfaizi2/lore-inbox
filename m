Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277282AbRKAMRW>; Thu, 1 Nov 2001 07:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278358AbRKAMRM>; Thu, 1 Nov 2001 07:17:12 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:39115 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277282AbRKAMRK>; Thu, 1 Nov 2001 07:17:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Thu, 1 Nov 2001 13:06:00 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15zF9H-0000NL-00@wagner>
In-Reply-To: <E15zF9H-0000NL-00@wagner>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15zGYm-1gibkeC@fmrl05.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 November 2001 11:32, Rusty Russell wrote:
> I believe that rewriting /proc (and /proc/sys should simply die) is a
> better solution than extending the interface, or avoiding it
> altogether by using a new filesystem.

I am currently working on something like this, too. It's using Patrick 
Mochel's driverfs patch 
(http://www.kernel.org/pub/linux/kernel/people/mochel/device/driverfs.diff-1030) 
as a base and adds the functionality of the extensions that I did to proc fs 
for my device registry patch 
(http://www.tjansen.de/devreg/proc_ov-2.4.7.diff). 

You can get an idea of the API in the proc_ov patch: every file in the 
filesystem is typed and either a string, integer, unsigned long or an enum. 
The intention is that you have a single value per file, like in /proc/sys, 
and not more. The API does not even allow you to have more complex files (I 
plan to add a blob type though).  
Unlike comparable APIs it also supports 'dynamic directories'. So you can, 
for example, create a directory for each device without registering a 
directory for each device. You only need a single dynamic directory with a 
couple of callbacks that specify the number of directories, their names and 
their contexts. Contexts are void pointers that are given to the callbacks of 
the content files, in this example you would probably use the pointer to the 
device's struct device as context. 

bye...
 
