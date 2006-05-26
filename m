Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWEZRF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWEZRF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 13:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWEZRF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 13:05:29 -0400
Received: from bayc1-pasmtp09.bayc1.hotmail.com ([65.54.191.169]:31035 "EHLO
	BAYC1-PASMTP09.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751160AbWEZRF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 13:05:28 -0400
Message-ID: <BAYC1-PASMTP09B12D11BE4D74DD6A06E3B99E0@CEZ.ICE>
X-Originating-IP: [69.156.47.88]
X-Originating-Email: [johnmccuthan@sympatico.ca]
Subject: Re: [PATCH] inotify kernel API
From: John McCutchan <john@johnmccutchan.com>
Reply-To: john@johnmccutchan.com
To: Amy Griffis <amy.griffis@hp.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>
In-Reply-To: <20060526021030.GA4936@zk3.dec.com>
References: <20060526021030.GA4936@zk3.dec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 May 2006 12:12:26 -0400
Message-Id: <1148659946.7612.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 26 May 2006 17:07:12.0750 (UTC) FILETIME=[D4CA50E0:01C680E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 22:10 -0400, Amy Griffis wrote:
> After stress testing and completing audit patches to use this API,
> I've made the following changes:
> 
>     (*) Allow callers to share the refcounting for an inotify_watch.
>         If the caller has embedded the inotify_watch in one of its own
>         structs, both inotify and the caller may need to use refcounts
>         for that data.  Since the caller is ultimately responsible for
>         freeing the inotify_watch data, they must register a destroy
>         function to be called on the last put_inotify_watch.  Also
>         provide inotify_init_watch() to enable a caller to use
>         refcounts before calling inotify_add_watch().
> 

Seems sane

> 	
>     (*) Allow callers to remove watches from their event handler.
>         Audit uses this feature to remove a watch after an
>         IN_MOVE_SELF event.  Another similar use could be to have
>         functionality similar to IN_ONESHOT, but have it apply to a
>         subset of events in the mask.
>     (*) Fixed a deadlock in inotify_dev_queue_event().
> 
>     (*) Fixed memleaks in inotify_destroy() and with IN_ONESHOT masks.
> 
>     (*) Re-ordered calls to event handler with IN_IGNORED events.
>         Since caller may do final put here, this must be the last
>         thing inotify does with an inotify_watch.
> 
> I did some stress tests and performance comparisons on inotify with
> and without this patch.  The tests I used and some results are posted
> here:


Having only glanced at your latest code, all of your changes and bug
fixes look good. Thanks very much for putting the effort into auditing
and testing inotify. 

-- 
John McCutchan <john@johnmccutchan.com>
