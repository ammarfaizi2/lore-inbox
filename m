Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266355AbTGJOSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268602AbTGJOSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:18:14 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:24909 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266355AbTGJOSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:18:13 -0400
Date: Thu, 10 Jul 2003 10:32:10 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Miquel van Smoorenburg <miquels@cistron.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
In-Reply-To: <Pine.LNX.4.53.0307100918410.203@chaos>
Message-ID: <Pine.LNX.4.44.0307101030270.3903-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003, Richard B. Johnson wrote:

> The problem, as I see it, is that you can dirty pages 10-15 times
> faster than they can be written to disk. So, you will always
> have the possibility of an OOM situation as long as you are I/O
> bound.

That's not a problem at all.  I think the VM never starts
pageout IO on a page that doesn't look like it'll become
freeable after the IO is done, so we simply shouldn't go
into the OOM killer as long as there are pages waiting on
pageout IO to finish.

Once we really are OOM we shouldn't have pages in pageout
IO.

This is what I am doing in current 2.4-rmap and it seems
to do the right thing in both the "heavy IO" and the "out
of memory" corner cases.

-- 
Great minds drink alike.

