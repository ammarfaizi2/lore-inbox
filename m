Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVHULZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVHULZK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 07:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbVHULZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 07:25:10 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:17821 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750951AbVHULZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 07:25:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Bw8sUcS63ns6OQ8GfhsfRxweDX+7brpDDS1QxiaVGtduz6Gt6BBlfvTt0LRzSlrO4cyWyWBX7ZO6PyULNm2YnSaQ4ONrYWMzIwBI95rMJO4tr/dHD9PG88C7NzgUDuu3s9uxrxHdtovUVPaWvpxTsipUG6VhyhsiJIXIKIEDukk=  ;
Message-ID: <4308649D.7060008@yahoo.com.au>
Date: Sun, 21 Aug 2005 21:25:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: tony.luck@intel.com, linux-kernel@vger.kernel.org, jasonuhl@sgi.com
Subject: Re: CONFIG_PRINTK_TIME woes
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C7DA7@scsmsx401.amr.corp.intel.com>	<20050821021322.3986dd4a.akpm@osdl.org>	<20050821021616.6bbf2a14.akpm@osdl.org>	<430848F5.3040308@yahoo.com.au> <20050821023249.0e143030.akpm@osdl.org>
In-Reply-To: <20050821023249.0e143030.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> yup.
> 
> 
>>Why not use something like do_gettimeofday? (or I'm sure one
>>of our time keepers can suggest the right thing to use).
> 
> 
> do_gettimeofday() takes locks, so a) we can't do printk from inside it and

Dang, yeah maybe this is the showstopper.

> b) if you do a printk-from-interupt and the interrupted code was running
> do_gettimeofday(), deadlock.
> 

What about just using jiffies, then?

Really, sched_clock() is very broken for this (I know you're
not arguing against that).

It can go backwards when called twice from the same CPU, and the
number returned by one CPU need have no correlation with that
returned by another.

However, I understand you probably just want something quick and
dirty for 2.6.13 and would be happy just if it isn't more broken
than before ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
