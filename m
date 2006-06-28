Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWF1Fxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWF1Fxc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWF1Fxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:53:32 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:4811 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964864AbWF1Fxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:53:31 -0400
Date: Wed, 28 Jun 2006 09:53:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [RFC][PATCH 3/3] Process events biarch bug: New process events connector value
Message-ID: <20060628055326.GB12276@2ka.mipt.ru>
References: <20060627112644.804066367@localhost.localdomain> <1151408975.21787.1815.camel@stark> <1151435679.1412.16.camel@linuxchandra> <1151444382.21787.1858.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1151444382.21787.1858.camel@stark>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 28 Jun 2006 09:53:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 02:39:42PM -0700, Matt Helsley (matthltc@us.ibm.com) wrote:
> > Is there a reason why the # of listeners part is removed (basically the
> > LISTEN/IGNORE) ? and why as part of this patch ?
> 
> 	Michael Kerrisk had some objections to LISTEN/IGNORE and I've been
> looking into making a connector function that would replace them. They
> exist primarily to improve performance by avoiding the memory allocation
> in cn_netlink_send() when there are no listeners.

Connector supports check for listeners before allocation quite long ago.

> > > +	err = cn_add_callback(&cn_proc_event_id, "cn_proc", NULL);
> > 
> > is this needed if you are not going to have the callback ?
> 
> I believe so. Evgeniy?

Depending on how are you going to use it.
It is obviously required for receiving data from userspace, but if you
only want to send data from kernelspace you can use cn_netlink_send()
without registering callback, but in that case you must provide group
number to cn_netlink_send().
 
> Thanks,
> 	-Matt Helsley

-- 
	Evgeniy Polyakov
