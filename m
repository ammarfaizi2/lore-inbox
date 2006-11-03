Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753245AbWKCPWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbWKCPWj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbWKCPWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:22:39 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:3612 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1753245AbWKCPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:22:38 -0500
Subject: Re: [PATCH 1/9] Task Watchers v2: Task watchers v2
From: Daniel Walker <dwalker@mvista.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
       Steve Grubb <sgrubb@redhat.com>, linux-audit@redhat.com,
       Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061103042748.438619000@us.ibm.com>
References: <20061103042257.274316000@us.ibm.com>
	 <20061103042748.438619000@us.ibm.com>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 08:22:34 -0500
Message-Id: <1162560154.2801.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 20:22 -0800, Matt Helsley wrote:
> +/*
> + * Watch for events occuring within a task and call the supplied
> function
> + * when (and only when) the given event happens.
> + * Only non-modular kernel code may register functions as
> task_watchers.
> + */
> +#define task_watcher_func(ev, fn) \
> +static task_watcher_fn __task_watcher_##ev##_##fn __attribute_used__
> \
> +       __attribute__ ((__section__ (".task_watchers." #ev))) = fn
> +#else
> +#error "task_watcher() macro may not be used in modules."
> +#endif 

You should make this TASK_WATCHER_FUNC() or even just TASK_WATCHER(). It
looks a little goofy in the code that uses it.

Looking at it now could you do something like,

static int __task_watcher_init 
audit_alloc(unsigned long val, struct task_struct *tsk)

Instead of a macro? Might be a little less invasive.

Daniel 


