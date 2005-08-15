Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbVHOQfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbVHOQfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVHOQfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:35:22 -0400
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:40592 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964834AbVHOQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:35:21 -0400
Subject: Re: [patch] inotify: idr_get_new_above not working?
From: John McCutchan <ttb@tentacle.dhs.org>
To: Robert Love <rml@novell.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jim.houston@ccur.com
In-Reply-To: <1124123274.23297.122.camel@betsy>
References: <1124115406.7369.6.camel@vertex>
	 <1124123274.23297.122.camel@betsy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Aug 2005 12:35:12 -0400
Message-Id: <1124123712.6343.0.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 12:27 -0400, Robert Love wrote:
> On Mon, 2005-08-15 at 10:16 -0400, John McCutchan wrote:
> 
> > Inotify is using idr_get_new_above to make sure that the next watch
> > descriptor is larger/different than any of the previous watch
> > descriptors. We keep track of the largest wd that we get out of
> > idr_get_new_above, and pass that to idr_get_new_above. I have noticed
> > though, that idr_get_new_above always returns the first available id.
> > This causes a serious problem for inotify, because user space will get a
> > IGNORE event for a wd K that might refer to the last holder of the K.
> 
> Turns out that the problem was in our court and not the idr layer.
> idr_get_new_above() seems to work fine.
> 
> One-line patch is attached.  Please merge before 2.6.13.

My bad! Patch looks correct.

Signed-off-by: John McCutchan <ttb@tentacle.dhs.org>


-- 
John McCutchan <ttb@tentacle.dhs.org>
