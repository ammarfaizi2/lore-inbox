Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWECGop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWECGop (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWECGop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:44:45 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:11730 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S965108AbWECGoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:44:44 -0400
Message-ID: <346638681.24899@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Wed, 3 May 2006 14:45:03 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       axboe@suse.de, nickpiggin@yahoo.com.au, pbadari@us.ibm.com,
       arjan@infradead.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060503064503.GA4781@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org, akpm@osdl.org, axboe@suse.de,
	nickpiggin@yahoo.com.au, pbadari@us.ibm.com, arjan@infradead.org
References: <346556235.24875@ustc.edu.cn> <20060502144641.62df9c18.diegocg@gmail.com> <346580906.19175@ustc.edu.cn> <20060502180753.096f8777.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060502180753.096f8777.diegocg@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 06:07:53PM +0200, Diego Calleja wrote:
> > Nope. mincore() only provides info about files that are currently
> > opened, by the process itself. The majority in the file cache are
> > closed files.
> 
> Yes; what I meant was:
> - start listening the process event connector as firsk task on startup
> - get a list of what files are being used (every second or something)
>   by looking at /proc/$PID/* stuff
> - mincore() all those files at the end of the bootup
> 
> > Yes, it can still be useful after booting :) One can get the cache
> > footprint of any task started at any time by taking snapshots of the
> > cache before and after the task, and do a set-subtract on them.
> 
> Although this certainly looks simpler for userspace (and complete, if
> you want to get absolutely all the info about files that get opened and
> closed faster than the profile interval of a prefetcher) 

Thanks, so it's a question of simplicity/completeness :)

> (another useful tool would be a dtrace-like thing)

Lubos Lunak also reminds me of SUSE's preload
(http://en.opensuse.org/index.php?title=SUPER_preloading_internals)
which is a user-land solution using strace to collect the info.

And there's Andrea Arcangeli's "bootcache userspace logging" kernel
patch(http://lkml.org/lkml/2004/8/6/216).

Wu
