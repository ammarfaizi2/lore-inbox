Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265165AbUELSyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbUELSyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUELSyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:54:03 -0400
Received: from fmr05.intel.com ([134.134.136.6]:52694 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265165AbUELSxU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:53:20 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Hotplug events for system suspend/resume
Date: Wed, 12 May 2004 11:52:51 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A84702C9343C@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hotplug events for system suspend/resume
Thread-Index: AcQ31ckAs6JTKMFXTaK/t4ykd/MbrAAe22TA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: <ncunningham@linuxmail.org>, "Todd Poynor" <tpoynor@mvista.com>
Cc: "Greg KH" <greg@kroah.com>, <mochel@digitalimplant.org>,
       <linux-hotplug-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 May 2004 18:52:51.0763 (UTC) FILETIME=[53CCF030:01C43852]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > In my mind, this approach is simpler and makes more 
> sense: userspace
> > > should worry about userspace actions related to 
> suspending before calling
> > > kernelspace. Kernel space should then only worry about saving and
> > > restoring driver states and should be transparent to user 
> space. ...
> >
> > Agreed, with the minor reservations listed in a previous 
> email (suspend
> > initiated by drivers must coordinate ad-hoc with userspace, etc.).
> 
> You're thinking ACPI drivers initiating a suspend? They would 
> do it through 
> acpid, wouldn't they? At least that's the glue I use to get 
> my sleep button 
> to initiate a suspend. I would assume thermal events 
> would/should work the 
> same.

Yeah. There definitely is a need for userspace apps to be power-aware,
and have the ability to prevent suspend, but I think this should all be
done via the daemon (talking to apps via D-BUS?) and then the daemon
pulls the trigger if all power-aware apps in userspace agree it's OK. I
don't think ACPI kernel code should do anything without being told to.

The kernel sleep interface should only ever be used by the daemon. If
the user decides to use it from the cmdline then things aren't going to
work right.

My 2c,

-- Andy
