Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273121AbRIOXpl>; Sat, 15 Sep 2001 19:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273123AbRIOXpa>; Sat, 15 Sep 2001 19:45:30 -0400
Received: from dsl-64135210.acton.ma.internetconnect.net ([64.13.5.210]:16818
	"EHLO alliance.centerclick.org") by vger.kernel.org with ESMTP
	id <S273121AbRIOXpU>; Sat, 15 Sep 2001 19:45:20 -0400
Mime-Version: 1.0
Message-Id: <v04210100b7c9939ad124@[10.0.2.30]>
In-Reply-To: <F349BC4F5799D411ACE100D0B706B3BB7690AE@umr-mail03.cc.umr.edu>
In-Reply-To: <F349BC4F5799D411ACE100D0B706B3BB7690AE@umr-mail03.cc.umr.edu>
Date: Sat, 15 Sep 2001 19:45:37 -0400
To: "Neulinger, Nathan" <nneul@umr.edu>, linux-kernel@vger.kernel.org
From: David Johnson <dave-kernel-list2@centerclick.org>
Subject: Re: Problems with 3ware error event notification in kernel
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/01, Neulinger, Nathan wrote:
>I've got a situation with the 3ware driver and 3dm monitor where it appears
>to stop receiving notification of status changes from the kernel.
>
>I've seen this with 2.2.19+variouspatches and 2.4.7-ac3. (On some other
>machines, it appears to work fine.)
>
>Basically, all of the real-time monitoring and instantaneous status request,
>as well as configuration change, etc. stuff all works fine, but after a
>while, the 3dm monitor no longer gets messages talking about drive failure
>(pulling a drive on hot-swap tray) or when the rebuilds start/stop. Even
>restarting the 3dm monitor doesn't seem to help this.

I've noticed this problem several times.  It's not just the email 
notification.  The 'alarms' section of 3dm as well as the syslog 
entries just stop happening.

>Strace doesn't seem to work on the 3dm executable since it's threaded... (Is
>there a way to get that to work?)

Have you tried '-f -F' ?  I haven't tried it since my controller is 
on a production system.

>Anyone have any ideas on this or have you seen this? The important thing is,
>if I reboot the server it's on, I'll generally be able to get a few alert
>messages, but after some time period (I think it's time based and not
>#-of-alerts based) it no longer receives new alert messages.
>
>3ware tech support doesn't have any idea on what could be wrong and didn't
>have any suggestions of what to try other than harping about what version of
>sendmail I'm running, etc. (Turning off the mail support didn't have any
>effect on the alert processing.)
>
>----
>
>On a side note - is anyone aware of any effort to reverse engineer the
>status probing code so that we could monitor the raid arrays using something
>other than 3wares 3dm tool? I presume it's just a matter of knowing the
>right ioctl's and parms to issue, but there is no info on this, and 3ware
>has no plans (according to tech support) to release any documentation or
>source for the monitoring code/protocols. Being able to strace the 3dmd
>would likely make this alot easier, but haven't been able to get strace to
>work against it.
>

On another note something (I assume 3dm) loves to look for eth 
interfaces just prior to every event:

Sep  4 15:30:20 alliance modprobe: modprobe: Can't locate module eth3
Sep  4 15:30:20 alliance modprobe: modprobe: Can't locate module eth1
Sep  4 15:30:20 alliance 3w-xxxx[874]: Drive error encountered on 
port 2 on controller ID:1. Check cables and drives for media errors. 
(0xa)

somewhat annoying, and very unnerving as it shouldn't be do anything 
with the networking setup.  Anyone else seen this?


