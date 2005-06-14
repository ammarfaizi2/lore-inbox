Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVFNP6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVFNP6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVFNP6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:58:38 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:61051 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261177AbVFNP6g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:58:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ATwwvdvBAfFTZv+HjCk0TEr74ScjVrCdrnRSbXf+LDIWfa1A1E1E2MsASDa5RRCwKmlWTPgacWJlUpVTh9gr/AdTJ80LttBxq81Z9PzNavH/zgNERkD7DLW+m7B8eEwadDIsYsQ0Gmlm5QkqnM+Ohi56U9sRtPje/r0T33HYQTA=
Message-ID: <9a87484905061408585c52f96b@mail.gmail.com>
Date: Tue, 14 Jun 2005 17:58:36 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: Why is one sync() not enough?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050614125828.GM446@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050614094141.GE1467@schottelius.org>
	 <20050614125828.GM446@admingilde.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/05, Martin Waitz <tali@admingilde.org> wrote:
> hoi :)
> 
> On Tue, Jun 14, 2005 at 11:41:41AM +0200, Nico Schottelius wrote:
> > When my system shuts down and init calls sync() and after that
> > umount and then reboot, the filesystem is left in an unclean state.
> >
> > If I do sync() two times (one before umount, one after umount) it
> > seems to work.
> 
> unmounting the filesystem writes to the disk.
> If you don't wait for those writes to reach the disk, then
> you still have a dirty filesystem.
> 

If I remember correctly, sync (at least in the past) schedules the
dumping of buffers to disk, but may return before everything is
actually written. Thus it was common in ages past to run  sync ; sync
; halt  when shutting down a system since even though the first sync
might return before writing was done, the second sync wouldn't start
before the first was really done, thus when the second sync returned
you'd know that at least the first one had completed.
I believe sync in recent Linux's actually waits for the data to be
written and never returns early, so I don't think this is relevant any
more - and everyone uses shutdown these days anyway. But go read the
implementation of sync if you really want to know.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
