Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbTFSALz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbTFSALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:11:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:19849 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265650AbTFSAK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:10:26 -0400
Date: Wed, 18 Jun 2003 17:25:16 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: greg@kroah.com, oliver@neukum.org, rml@tech9.net, mochel@osdl.org,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-Id: <20030618172516.5ed02221.akpm@digeo.com>
In-Reply-To: <3EF10002.7020308@cox.net>
References: <3EE8D038.7090600@mvista.com>
	<1055459762.662.336.camel@localhost>
	<20030612232523.GA1917@kroah.com>
	<200306132201.47346.oliver@neukum.org>
	<20030618225913.GB2413@kroah.com>
	<3EF10002.7020308@cox.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 00:24:23.0798 (UTC) FILETIME=[2278D960:01C335F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin P. Fleming" <kpfleming@cox.net> wrote:
>
> > Yes, we should add the sequence number last.
>  > 
> 
>  While this is not a bad idea, I don't think you want to make a promise 
>  to userspace that there will never be gaps in the sequence numbers. When 
>  this sequence number was proposed, in my mind it seemed perfect because 
>  then userspace could _order_ multiple events for the same device to 
>  ensure they got processed in the correct order. I don't know that any 
>  hotplug userspace implementation is going to be large and complex enough 
>  to warrant "holding" events until lower-numbered events have been 
>  delivered. That just seems like a very difficult task with little 
>  potential gain, but I could very well be mistaken :-)

The userspace support tools need to be able to handle gaps
in any case, because call_usermodehelper() may fail.

(In practice it won't fail, because the memory allocator is immortal.
But the capability should be there.

(Well actually, it could fail because the VM overcommit code might
refuse the mmap.

(But probably not, because root gets an extra margin.)))


