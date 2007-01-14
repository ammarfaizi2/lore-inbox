Return-Path: <linux-kernel-owner+w=401wt.eu-S1751278AbXANNG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbXANNG1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 08:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbXANNG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 08:06:27 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:47800 "EHLO mta2.cl.cam.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbXANNG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 08:06:26 -0500
X-Greylist: delayed 1604 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jan 2007 08:06:25 EST
User-Agent: Microsoft-Entourage/11.3.2.061213
Date: Sun, 14 Jan 2007 12:37:46 +0000
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device
 driver.
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>, <virtualization@lists.osdl.org>,
       <xen-devel@lists.xensource.com>, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, <linux-kernel@vger.kernel.org>
Message-ID: <C1CFD49A.7286%Keir.Fraser@cl.cam.ac.uk>
Thread-Topic: [patch 20/20] XEN-paravirt: Add Xen virtual block device
 driver.
Thread-Index: Acc32MrnCbWgRqPMEdur9wANk04WTA==
In-Reply-To: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/1/07 11:05 am, "Jan Engelhardt" <jengelh@linux01.gwdg.de> wrote:

>> The block device frontend driver allows the kernel to access block
>> devices exported exported by a virtual machine containing a physical
>> block device driver.
> 
> Is this significantly different from ubd/hostfs that it actually warrants a
> reinvention?

It is certainly unlike hostfs because hostfs provides file-level access to
host storage, not block-level. It's unlike both ubd and hostfs in that both
of those (I believe) make significant use of the syscall interface (and so
assume they run in a process on a Linux host). Also our driver appears to be
lower level, pushing more responsibility for features like CoW into the VMM.
Arguably that's a more generically reusable and flexible strategy although
it requires more VMM run-time support (which a Xen system provides).

>> + (void)xenbus_switch_state(info->xbdev, XenbusStateConnected);
> 
> Cast remove, if xenbus_switch_state does not have __must_check.
> Also elsewhere.

Okay, we should certainly follow the general rule here.

 Thanks,
 Keir


