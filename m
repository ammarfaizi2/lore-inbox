Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751958AbWCJTZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbWCJTZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 14:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCJTZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 14:25:27 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:57734
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751958AbWCJTZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 14:25:27 -0500
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
From: Paul Fulghum <paulkf@microgate.com>
To: Bob Copeland <email@bobcopeland.com>
Cc: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <1142011340.3220.4.camel@amdx2.microgate.com>
	 <b6c5339f0603101048l1c362582xc4d2570bc9d569b@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 13:25:09 -0600
Message-Id: <1142018709.26063.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 13:48 -0500, Bob Copeland wrote:
> > > Call Trace:
> > >  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
> > >  [<c01e756e>] class_device_del+0xa0/0x11c
> > >  [<c01e75f5>] class_device_unregister+0xb/0x16
> > >  [<d01f81f3>] acm_tty_unregister+0x1d/0x63 [cdc_acm]
> >
> > This looks more like
> > http://bugzilla.kernel.org/show_bug.cgi?id=5876
> 
> Hmm... it looks different from that bug - in that case the root cause
> was sysfs_make_dirent failing, presumably when the sysfs node for the
> device was being set up, by unplugging and re-plugging the device a
> lot.  Here it's oopsing when the node is being removed, after it's
> been in use a while and unplugged only once.  But yes ppp may not have
> anything to do with it.  I'll try it on an older kernel to see if I
> can reproduce there...

The i_sem to i_mutex change started in the 2.6.16 series.
Running against 2.6.15 would be interesting. Being able
to repeat every time is a plus. I'm not that familiar
with the sysfs stuff, but the slab poisoning is pretty
damning. The dentry was released and then accessed.

I looked at cdc_acm for disconnect and close and
did not see any problems (such as trying to call
tty_unregister_device twice for a device).

-- 
Paul Fulghum
Microgate Systems, Ltd

