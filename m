Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbUISSoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbUISSoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 14:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUISSoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 14:44:10 -0400
Received: from [217.79.151.115] ([217.79.151.115]:9349 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262062AbUISSn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 14:43:56 -0400
Date: Sun, 19 Sep 2004 20:43:50 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
In-Reply-To: <20040919173221.GB2345@kroah.com>
Message-ID: <Pine.LNX.4.60.0409192004020.30139@alpha.polcom.net>
References: <414C9003.9070707@softhome.net> <1095568704.6545.17.camel@gaston>
 <414D42F6.5010609@softhome.net> <cijrui$g9s$1@sea.gmane.org>
 <20040919173221.GB2345@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am fascinated about udev and others, but have some questions.

On Sun, 19 Sep 2004, Greg KH wrote:
> On Sun, Sep 19, 2004 at 05:53:05PM +0600, Alexander E. Patrakov wrote:
>>
>> What we currently see is that distros either ignore the race or (like
>> LFS) say something like:
>
> I don't see distros ignoring the race issues.  Look at Gentoo's init
> scripts, it handles this properly (if not, please let me know.)

I have Gentoo with udev (with 100% modular kernel). And I have speedtouch 
USB ADSL modem. I am using paralell startup scripts feature. And 
speedtouch tries to initialize itself (load firmware and so on) before USB 
bus (or how to call it) is discovered. I can imagine moving firmware 
loader to udev.d scripts but where should I place pppd launching (for 
example I might have pppd or ifconfig binary on nfs mounted /usr from 
my LAN...).

I understand that for messages like "xxx was just plugged in" there is 
(masked) HAL and DBUS. But don't we need something where we can check if 
particular part of the system (not only device but also removable media or 
filesystem mount or some daemon) was initialized (or is currently plugged 
and initialized) or not? And we should be able to locate device file or 
mount point or controll socket of this part of the system... And don't 
we need some multi-event script launcher: "Launch this when xxx was 
plugged and initialized but not before yyy was initialized"? Gentoo has 
dependency-based startup scripts but dependiencies are resolved statically 
not dynamically... There should be also some inteligent way to 
shut down device _and_ all things that depend on it when device is 
unplugged and then reinitialize _everything_ when device is plugged 
back... Not only device itself as it is in udev.d. Script in udev.d should 
not know about services that depend on this device and services that 
depend on these services...

And how udev, hotlpug and the rest of the system should hadle SATA disk 
unpluggged in the middle of writing? And what if it will be plugged back?


Thanks,

Grzegorz Kulewski

