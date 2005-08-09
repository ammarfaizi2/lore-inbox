Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVHISgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVHISgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVHISgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:36:00 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:7876 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964902AbVHISgA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:36:00 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080203163cab015c@mail.gmail.com>
            <20050803063644.GD9812@redhat.com>
            <courier.42F768D5.000046F2@courier.cs.helsinki.fi>
            <42F7A557.3000200@zabbo.net>
            <1123598983.10790.1.camel@haji.ri.fi>
            <42F8E516.7020600@zabbo.net>
In-Reply-To: <42F8E516.7020600@zabbo.net>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Zach Brown <zab@zabbo.net>
Cc: David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       mark.fasheh@oracle.com
Subject: Re: GFS
Date: Tue, 09 Aug 2005 21:35:58 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F8F78E.0000257A@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zach, 

Zach Brown writes:
> I'll try, briefly.

Thanks for the excellent explanation. 

Zach Brown writes:
> And that's the problem. Because they're acquired in ->nopage they can
> be acquired during a fault that is servicing the 'buf' argument to an
> outer file->{read,write} operation which has grabbed a lock for the
> target file. Acquiring multiple locks introduces the risk of ABBA
> deadlocks. It's trivial to construct examples of mmap(), read(), and
> write() on 2 nodes with 2 files that deadlock.

But couldn't we use make_pages_present() to figure which locks we need, sort 
them, and then grab them? 

Zach Brown writes:
> I brought this up with some people at the kernel summit but no one,
> including myself, considers it a high priority.  It wouldn't be too hard
> to construct a patch if people want to take a look.

I guess it's not a problem as long as the kernel has zero or one cluster 
filesystems that support mmap(). After we have two or more, we have a 
problem. 

The GFS2 vma walk needs fixing anyway, I think, as it can lead to buffer 
overflow (if we have more locks during the second walk). 

               Pekka 

