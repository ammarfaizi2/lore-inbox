Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSHFR0F>; Tue, 6 Aug 2002 13:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSHFR0E>; Tue, 6 Aug 2002 13:26:04 -0400
Received: from aleja.bmj.net.pl ([195.82.161.242]:46586 "EHLO nic.bnet.pl")
	by vger.kernel.org with ESMTP id <S314459AbSHFRZ6>;
	Tue, 6 Aug 2002 13:25:58 -0400
Date: Tue, 6 Aug 2002 19:29:21 +0200
From: Jacek Konieczny <jajcus@bnet.pl>
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: "new style" netdevice allocation patch for TUN driver (2.4.18 kernel)
Message-ID: <20020806172921.GC22436@nic.nigdzie>
References: <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com> <20020801133506.GA22073@serwus.bnet.pl> <5.1.0.14.2.20020802164143.04da52f8@mail1.qualcomm.com> <5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020806094253.09734790@mail1.qualcomm.com>
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2002 at 10:07:49AM -0700, Maksim (Max) Krasnyanskiy wrote:
> >I will not see "waiting for" warning, but I will also be able to control
> >all other network devices. Without this "fix" I am not able to shutdown
> >network at all. Every "ip" command just hangs forever.
> Yeah, this should be fixed. unregister_netdevice() sleeps under rtnl_lock().
> Which means that any other activity that needs this lock will be blocked.
I am happy, that someone (smarter than me) seems to be interested in
fixing this bug :-)

> >But it seems it is eventually called. The refcount eventually goes to 0
> >(1 in factm - selfreference). Without this patch it never went to 0, as
> >system shutdown was stopped "waitnig for...".
> It'd be nice to trace what part of the kernel is actually holding refcount.
If I ever find something more precise I'll write.

> >was bug-free. With this patch it is more bug-proof.
> :) No, the point of device destructors is not to hide kernel bugs.
>[...]
> for a long time after deregistration. I may very well be doing it for a 
> good reason but warning is helpful anyway.
I undarstand this. Even with my (now I know - broken) patch kernel warns
that device is in use, and that destruction will be delayed.
But you are right, warning displayed every 3 seconds, when nothing else
works is much easier to notice :-)

> And we should fix sleep in unregister_netdevice() (ie patch above).
I think this would be enough for me. 

Greets,
        Jacek
