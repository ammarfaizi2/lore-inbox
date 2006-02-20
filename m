Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbWBTVqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbWBTVqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWBTVqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:46:21 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:33056 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932622AbWBTVqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:46:20 -0500
Message-ID: <43FA3866.20709@cfl.rr.com>
Date: Mon, 20 Feb 2006 16:45:10 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net> <200602181251.09865.david-b@pacbell.net> <43F80ACC.20704@cfl.rr.com> <200602192150.05567.david-b@pacbell.net> <43F9E95A.6080103@cfl.rr.com> <20060220165153.GA33155@dspnet.fr.eu.org> <43FA0867.5060001@cfl.rr.com> <20060220184419.GF33155@dspnet.fr.eu.org>
In-Reply-To: <20060220184419.GF33155@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Feb 2006 21:47:21.0929 (UTC) FILETIME=[3A993B90:01C63667]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14280.000
X-TM-AS-Result: No--20.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> 
> If I understand USB correctly, it's all point-to-point, there is no
> broadcast going on.  For enumeration purposes hubs are not
> transparent, and ports are separated.  But I wouldn't rely on the
> ports numbers on hubs to stay constant w.r.t the physical ports.  I
> don't think it's required.
> 

Hrm... that last part is crucial I think.  If the kernel can tell there 
is a device still physically connected to the same port after the 
suspend, then it could reconnect that device to the existing node, and 
maybe notify the filesystem that the disk may have changed, so it should 
attempt to verify it, the way windows does.

As for the heuristics, don't most filesystems keep a mount count in the 
superblock?  What better way to decide if things are changed than having 
the filesystem check that the superblock looks to be the same and 
specifically that it's mount count has not increased.  I don't think the 
tests need to be that complex to get rather reasonably accurate results, 
and trying to put them in user space is asking for a lot of race 
conditions that would be solved by having the filesystem handle it.

> Since it's an hotplug bus, enumeration before suspend happened as the
> devices were plugged in.  So the order a reboot enumeration will see
> them is unknown in practice.
> 

Ahh, right... I didn't think of that; the bus may have changed since the 
initial enumeration, so a re-enumeration will be different.  I was just 
thinking of the case where it didn't change while suspended.

> It may be fixable by storing some kind of physical address in the
> tree, but losing a filesystem because you replugged the usb drive in
> the wrong physical port between suspend and resume would be annoying.
> And I don't know how stable the "physical" positions are in the first
> place.


