Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030182AbWIESRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWIESRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 14:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWIESRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 14:17:10 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:26987 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030182AbWIESRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 14:17:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vjx96awe3i8y95PrgqPmC8wK1nOf5Tmk+KQY1dUAqM4BDOmxBNfetpKZd05YJaz8BusHjUtopI4nDpGStpTwKzrjOZ0jMNo2PtJi7VsWVbbxFSGvtWtgTCP8z/7+vPkgXRo7COnOuVtEBXb3Knb49Dvx4YE7O8rMWHo0jMZyAXc=
Message-ID: <a44ae5cd0609051116k6c236ba6xa2fd0119708a6950@mail.gmail.com>
Date: Tue, 5 Sep 2006 11:16:59 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking detected
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Herbert Xu" <herbert@gondor.apana.org.au>,
       linux1394-devel@lists.sourceforge.net
In-Reply-To: <20060905111306.80398394.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
	 <20060905111306.80398394.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 5 Sep 2006 10:37:51 -0700
> "Miles Lane" <miles.lane@gmail.com> wrote:
>
> > ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> > ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> > ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> >
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > 2.6.18-rc5-mm1 #2
> > ---------------------------------------------
> > knodemgrd_0/2321 is trying to acquire lock:
> >  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >
> > but task is already holding lock:
> >  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]
> >
> > other info that might help us debug this:
> > 2 locks held by knodemgrd_0/2321:
> >  #0:  (nodemgr_serialize){--..}, at: [<c11e76cd>]
> > mutex_lock_interruptible+0x1c/0x21
> >  #1:  (&s->rwsem){----}, at: [<f8959078>]
> > nodemgr_host_thread+0x717/0x883 [ieee1394]
> >
> > stack backtrace:
> >  [<c1003c97>] dump_trace+0x69/0x1b7
> >  [<c1003dfa>] show_trace_log_lvl+0x15/0x28
> >  [<c10040f5>] show_trace+0x16/0x19
> >  [<c1004110>] dump_stack+0x18/0x1d
> >  [<c102f1e1>] __lock_acquire+0x7a2/0x9f8
> >  [<c102f70a>] lock_acquire+0x56/0x74
> >  [<c102b805>] down_write+0x27/0x41
> >  [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >  [<f8959098>] nodemgr_host_thread+0x737/0x883 [ieee1394]
> >  [<c1028c19>] kthread+0xaf/0xde
> >  [<c100397b>] kernel_thread_helper+0x7/0x10
> > DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
> >
> > Leftover inexact backtrace:
> >
> >  [<c1003dfa>] show_trace_log_lvl+0x15/0x28
> >  [<c10040f5>] show_trace+0x16/0x19
> >  [<c1004110>] dump_stack+0x18/0x1d
> >  [<c102f1e1>] __lock_acquire+0x7a2/0x9f8
> >  [<c102f70a>] lock_acquire+0x56/0x74
> >  [<c102b805>] down_write+0x27/0x41
> >  [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >  [<f8959098>] nodemgr_host_thread+0x737/0x883 [ieee1394]
> >  [<c1028c19>] kthread+0xaf/0xde
> >  [<c100397b>] kernel_thread_helper+0x7/0x10
> >  =======================
> > ieee1394: Node resumed: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> > ieee1394: Node changed: 0-00:1023 -> 0-01:1023
> > ieee1394: Node changed: 0-01:1023 -> 0-02:1023
>
> That's a 1394 glitch, possibly introduced by git-ieee1394.patch.

Would you like me to verify that removing the patch fixes it, or
should I wait for the 2.6.18-rc6-mm1 tree?

Thanks,
      Miles
