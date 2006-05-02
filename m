Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWEBQIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWEBQIf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWEBQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:08:35 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:34131 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964874AbWEBQIe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:08:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Cp0MjrsVvgRhDsObB97olB36qa91fNl1wj7xz8KymzGSa9Mcr3pYGl8T63KA6FwD7DAmBJ17vZOruinbInyjiBmZtry6zg5bh0KbHxRNu124jhkNuG/WIutsdyGJ7OwennVtxQRiwasxjNcS5vJdTKljFkhhWVNTQiFKboBLchg=
Date: Tue, 2 May 2006 18:07:53 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       axboe@suse.de, nickpiggin@yahoo.com.au, pbadari@us.ibm.com,
       arjan@infradead.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-Id: <20060502180753.096f8777.diegocg@gmail.com>
In-Reply-To: <346580906.19175@ustc.edu.cn>
References: <346556235.24875@ustc.edu.cn>
	<20060502144641.62df9c18.diegocg@gmail.com>
	<346580906.19175@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 2 May 2006 22:42:03 +0800,
Wu Fengguang <wfg@mail.ustc.edu.cn> escribió:

> Nope. mincore() only provides info about files that are currently
> opened, by the process itself. The majority in the file cache are
> closed files.

Yes; what I meant was:
- start listening the process event connector as firsk task on startup
- get a list of what files are being used (every second or something)
  by looking at /proc/$PID/* stuff
- mincore() all those files at the end of the bootup

> Yes, it can still be useful after booting :) One can get the cache
> footprint of any task started at any time by taking snapshots of the
> cache before and after the task, and do a set-subtract on them.

Although this certainly looks simpler for userspace (and complete, if
you want to get absolutely all the info about files that get opened and
closed faster than the profile interval of a prefetcher) 

(another useful tool would be a dtrace-like thing)
