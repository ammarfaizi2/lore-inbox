Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263371AbUDUUx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263371AbUDUUx6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbUDUUx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:53:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12476 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263371AbUDUUx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:53:56 -0400
Date: Wed, 21 Apr 2004 17:34:56 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040421203456.GC16891@logos.cnet>
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420163443.7347da48.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 04:34:43PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> > > The major advantage of your work is that we can now remove those limits. 
> > > You'll be needing a 2.4 backport ;)
> > 
> > Yeap. :) 
> > 
> > And we also need to do the userspace part. ulimit is part of bash, so 
> > probably all shell's should be awared of this? I never looked
> > how "ulimit" utility works.
> 
> yup, the shells need to be changed, which is really awkward.  I was wrong
> about how bash and zsh handle `ulimit 4 1024'.
> 
> Really the shells _should_ permit ulimit-by-number for this very reason.
> 
> Adding new ulimits is nice - it's a shame that the shells make it hard to
> use.

I'm thinking about how to do the mqueue "kernel allocated memory" accounting, 
and I have a problem. A user can create an mqueue of given size via sys_mq_open()
using "msg_attr" structure (will be created in do_create). I can account for how much 
memory has been allocated, but I can't at "deaccount" at kfree() time (this memory 
is stored in inode->(mqueue_inode_info *)info->messages), because I dont know how big
it is (its user selectable via "msg_attr" structure). 

What can be done about this?

Creating a data structure to account for "allocation->allocation size" 
sounds overly complicated at first, but might be necessary if correct
accounting is necessary?

Gracias

