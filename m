Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWFUGYA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWFUGYA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWFUGYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:24:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12002 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751127AbWFUGX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:23:59 -0400
Date: Wed, 21 Jun 2006 02:23:46 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm1
Message-ID: <20060621062346.GA10637@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060608050047.GB16729@redhat.com> <1150825349.2891.219.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150825349.2891.219.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 07:42:29PM +0200, Arjan van de Ven wrote:
 > On Thu, 2006-06-08 at 01:00 -0400, Dave Jones wrote:
 > > On Wed, Jun 07, 2006 at 10:47:24AM -0700, Andrew Morton wrote:
 > >  > 
 > >  > ftp://ftp.kernel.org/pub/linux/kernel/peopleD/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
 > >  > 
 > >  > - Many more lockdep updates
 > > 
 > > Needs more.
 > > 
 > > ====================================
 > > [ BUG: possible deadlock detected! ]
 > > ------------------------------------
 > > nfsd/11429 is trying to acquire lock:
 > >  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24
 > > 
 > > but task is already holding lock:
 > >  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24
 > > 
 > > which could potentially lead to deadlocks!
 > 
 > Does this fix it for you? (it fixes the case for me)

Hmm. This makes things drastically worse for me. Now it hangs during NFS startup.

$ sudo service nfs start
Starting NFS services:                                     [  OK  ]
Starting NFS quotas:

and that's all she wrote.

ps axf..

 2757 pts/0    S+     0:00  |           \_ /bin/sh /sbin/service nfs start
 2760 pts/0    S+     0:00  |               \_ /bin/sh /etc/init.d/nfs start
 2771 pts/0    S+     0:00  |                   \_ /bin/bash -c ulimit -S -c 0 >/dev/null 2>&1 ; rpc.rquotad
 2772 pts/0    S+     0:00  |                       \_ rpc.rquotad
	

If I ssh into the box, and get sysrq-t output, I see..
http://people.redhat.com/davej/nfs

I've kicked off a clean build that I'll leave running overnight, as I'm not
100% sure that was a clean tree I built from. Odd behaviour for a miscompile though.

		Dave

-- 
http://www.codemonkey.org.uk
