Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUHEVTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUHEVTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUHEVSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:18:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:43656 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267989AbUHEVRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:17:16 -0400
Date: Thu, 5 Aug 2004 14:20:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: davidsen@tmr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
Message-Id: <20040805142019.712c678a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0408051647440.8229-100000@dhcp83-102.boston.redhat.com>
References: <411299D4.5060001@tmr.com>
	<Pine.LNX.4.44.0408051647440.8229-100000@dhcp83-102.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
> On Thu, 5 Aug 2004, Bill Davidsen wrote:
> > Rik van Riel wrote:
> > > The patch below implements RSS ulimit enforcement for 2.6.8-rc3-mm1.
> 
> > Wish there was something like RSS for cache, so that one process reading 
> > every inode on the planet, or doing an md5 on an 11GB file wouldn't push 
> > every damn process out if it's waiting for me to finish typing a line...
> 
> I guess that's beyond the scope of a simple patch

It might not be.  We could come up with some dopey per-process flag,
inherited across fork which means "invalidate each file's pagecache when I
close it".  get/set that flag with a new syscall, or sys_prctl().  That
way, people could do:

	/bin/run-cache-friendly tar cf /dev/tape /huge-filesystem

and not have their pagecache trodden all over.  Extra points for nuking
dentries and inodes too.

It's not particularly pretty, but it would be effective for the most
commonly complained about scenarios.

