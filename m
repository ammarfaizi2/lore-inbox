Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTH0O4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263411AbTH0O4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:56:51 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:40160 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S263401AbTH0O4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:56:50 -0400
Date: Wed, 27 Aug 2003 17:56:30 +0300
Subject: Re: Lockless file reading
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Martin Konold <martin.konold@erfrakon.de>, linux-kernel@vger.kernel.org
To: root@chaos.analogic.com
From: Timo Sirainen <tss@iki.fi>
In-Reply-To: <Pine.LNX.4.53.0308270925550.278@chaos>
Message-Id: <A43789CE-D89E-11D7-9D97-000393CC2E90@iki.fi>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, Aug 27, 2003, at 16:40 Europe/Helsinki, Richard B. 
Johnson wrote:

> So I don't see how you could ever have a sequence of 123 written,
> with both '1' and '3' written, but not '2'. It is only the stuff
> on the 'ends' that can be incomplete.

That's pretty much what I was assuming without knowing how the kernel 
internally really works.

> Anyway, if you want two (or more) processes to access the file,
> you should mmap it. You can configure a mmap'ed file so that
> updates appear to all readers. However, just like any shared-memory
> access, you need some kind of synchronization, perhaps a semaphore,
> so that you always read valid data. Usually one only needs
> __valid__ data, not necessarily __current__ data.

Right, that's why I don't really need read locking. The 
double-writing/reading with memcmp() checking was supposed to check 
that the data is valid.

I'm already using shared mmaps, but I was thinking that supporting NFS 
would be nice as well. That'd work pretty much the same as write()s.

Maybe it would be possible to use some kind of error detection 
checksums which would guarantee that the data either is valid or isn't, 
regardless of the order in which it is written. I don't really know how 
that could be done though.

