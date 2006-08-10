Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWHJFOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWHJFOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWHJFOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:14:12 -0400
Received: from 1wt.eu ([62.212.114.60]:47373 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1161034AbWHJFOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:14:08 -0400
Date: Thu, 10 Aug 2006 06:57:11 +0200
From: Willy Tarreau <w@1wt.eu>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: What's the NFS OOM problem?
Message-ID: <20060810045711.GI8776@1wt.eu>
References: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 06:24:47PM -0400, Xin Zhao wrote:
> I often heard of the OOM probelm in NFS, but don't know what it is.
> Now I am developing a NFS based system and found my system memory
> (server side) is used too fast. I checked the code but didn't find
> memory leaking. So I suspect I run into OOM issue.

I simply think that you're cache is filling while your clients access
a lot of files. That's expected. You might also get quite a bunch of
dentries cached which will not be accounted for in meminfo. Check
/proc/meminfo for the cache+buffer size, and check /proc/slabinfo for
the number of dentries. The usual way to ensure this is only cache is
to allocate a large amount of memory (let's say all the system RAM
provided that everything can get swapped), then free it. You'll see
a lot of free memory after that.

> Can someone help me and give me a brief description on OOM issue?

I don't know about any OOM issue related to NFS. At most it might happen
on the client (eg: stating firefox from an NFS root) which might not have
enough memory for new network buffers, but I don't even know if it's
possible at all.

Regards,
Willy

