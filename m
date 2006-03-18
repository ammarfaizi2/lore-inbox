Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWCRElY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWCRElY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 23:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCRElY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 23:41:24 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:11621 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751292AbWCRElX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 23:41:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=U6BsGbLDvL4z/D+sr39qpYb4UrdX3y7lu54aLNqT//PRu0lygG2+s1tzqxeVRpAI6QZKCjF3yfupFsnYFkV/DUti/PaunQalxm99c2pa6R+6H0ObDhEbmGJti2oRxQ4+RfOQ+13mB+6ZZbHZXA6xWE9l/6W7plR9fQ42t+j40SA=  ;
Message-ID: <441B8F6E.7010802@yahoo.com.au>
Date: Sat, 18 Mar 2006 15:41:18 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, ck@vds.kolivas.org,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Stefan Seyfried <seife@suse.de>
Subject: Re: [PATCH][RFC] mm: swsusp shrink_all_memory tweaks
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200603171717.23288.kernel@kolivas.org> <200603171831.46811.rjw@sisk.pl> <200603181514.27455.kernel@kolivas.org>
In-Reply-To: <200603181514.27455.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> @@ -1567,7 +1546,7 @@ loop_again:
>  		zone->temp_priority = DEF_PRIORITY;
>  	}
>  
> -	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
> +	for_each_priority_reverse(priority) {

What's this for? The for loop is simple and easy to read, after
the change, you have to look somewhere else to see what it does.

> Index: linux-2.6.16-rc6-mm1/include/linux/swap.h
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/include/linux/swap.h	2006-03-18 13:29:38.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/include/linux/swap.h	2006-03-18 14:50:11.000000000 +1100
> @@ -66,6 +66,51 @@ typedef struct {
>  	unsigned long val;
>  } swp_entry_t;
>  
> +struct scan_control {

Why did you put this here? scan_control really can't go outside vmscan.c,
it is meant only to ease the passing of lots of parameters, and not as a
consistent interface.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
