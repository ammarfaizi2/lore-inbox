Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSFXL60>; Mon, 24 Jun 2002 07:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSFXL6Z>; Mon, 24 Jun 2002 07:58:25 -0400
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:34467 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S312590AbSFXL6Y>; Mon, 24 Jun 2002 07:58:24 -0400
Message-Id: <200206241158.g5OBwLn23710@d06relay02.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Andrew <andrew.grover@intel.com>
Subject: Re: driverfs is not for everything! (was: [PATCH] /proc/scsi/map)
Date: Mon, 24 Jun 2002 15:54:28 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew <Andrew.grover@intel.com> wrote on Sun Jun 23 2002:

> I know this is one of those things that has more and more cool
> possibilities the more you think about it but... 
>
> Is the device PHYSICALLY hooked up to the computer? If not, it shouldn't
> be in devicefs. 

So what do you do when none of the devices you are using is physically
attached :-) ?
On s390, we have an abstraction layer that allows us to use virtual 
devices without knowing the true hardware behind it. All we see is
an 'i/o subchannel' that typically equals a device (disk, tape, console
etc.).

I decided not to care about virtualization and have a device node in 
driverfs for each subchannel. Unfortunately, there are some devices (e.g. 
ethernet controllers) that are made up by multiple (two or three) 
subchannels, because some hardware engineers decided that it was a good 
idea to do that (for a good reason).

Now I have an extra bus type for those devices. They often do exist
physically (and I don't care if they are only virtual), so they need
a place in the device tree. Currently, each such device is a child node of 
one of the subchannels. This is not how it is meant to be in driverfs (there 
is no network device connected to a subchannel device, the network device
_is_ two subchannels), but what else should I do there?

Other drivers are purely virtual. The Inter-User Communication Vehicle
(iucv) lets me set up a network interface between two virtual machines.
I don't need a driverfs interface for it, but why shouldn't I have it 
anyway? It even fits the driver model better that my physical network
devices!

	Arnd <><
