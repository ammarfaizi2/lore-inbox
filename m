Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265613AbTFRXbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 19:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265614AbTFRXbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 19:31:22 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8834 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265613AbTFRXbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 19:31:21 -0400
Date: Wed, 18 Jun 2003 16:46:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: duplicate entry check in kmem_cache_create
Message-Id: <20030618164611.41ea172d.akpm@digeo.com>
In-Reply-To: <3EF0F0D5.5030504@austin.rr.com>
References: <3EF0F0D5.5030504@austin.rr.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 23:45:18.0922 (UTC) FILETIME=[ACD12AA0:01C335F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> wrote:
>
> Is there a recommended way to check to see if a slab cache with
> a specific name exists before calling kmem_cache_create?
> 
> I was able to force it into the BUG() at about line 1160 of slab.c by 
> removing my
> module (rmmod -f) while some of my slab cache objects (e.g. private inode
> info) were still in use, and then reloading my module which called
> kmem_cache_create with a name that already existed.

errr, why on earth was the filesystem unloadable when it still had live
objects floating about?

At the very least, if the slab code tries to call a destructor it will ruin
your whole day.


