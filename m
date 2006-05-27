Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWE0HYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWE0HYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 03:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWE0HYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 03:24:25 -0400
Received: from relay.rinet.ru ([195.54.192.35]:40132 "EHLO relay.rinet.ru")
	by vger.kernel.org with ESMTP id S1751437AbWE0HYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 03:24:25 -0400
Message-ID: <4477FEE2.7080401@mail.ru>
Date: Sat, 27 May 2006 11:25:22 +0400
From: Michael Raskin <a1d23ab4@mail.ru>
User-Agent: Mail/News 3.0a1 (X11/20060409)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intercept write to disk
References: <E1Fjjke-0000EV-00@calista.inka.de> <1148679612.2094.16.camel@localhost>
In-Reply-To: <1148679612.2094.16.camel@localhost>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (relay.rinet.ru [195.54.192.35]); Sat, 27 May 2006 11:24:23 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mishael A Sibiryakov wrote:
> Hm, i need a somthing transparent, this tool is for make image of entire
> disk/partition on fly. Because tool is get some time for work i need to
> store changes between start and end of the process for append it to
> image. Probably i thinking in wrong way and i need a something else.

Maybe you want to back up a partition as it was at some moment in the 
past (exactly)? Then you have to make a device-mapper-snapshot out of 
it. You  need to install device-mapper module and userspace tools, and 
make the following:  original device is never used directly; instead a 
snapshot-origin mapping is made of it and is always used. When you need 
snapshot, you create a file (on another partition, of course; maybe even 
in the memory if you are sure you will do everything quickly enough), 
make it a loopback device, and make a snapshot out of snapshot-origin 
you have and this loopback for changes rollback. Maybe it is also better 
  to mount -o remount,sync the device for the time of creating snapshot 
device in order to have less problems with consistency. And remount it 
back when you start copying.
