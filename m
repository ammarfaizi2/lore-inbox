Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265998AbUA1SGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUA1SGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:06:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29108 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265998AbUA1SFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:05:11 -0500
Date: Wed, 28 Jan 2004 10:05:07 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Cc: laroche@redhat.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Cset 1.1490.4.201 - dasd naming
Message-Id: <20040128100507.7b3dfeed.zaitcev@redhat.com>
In-Reply-To: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com>
References: <OFCE30A640.024A04A1-ONC1256E28.003023EA-C1256E28.0030BF4E@de.ibm.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 09:52:27 +0100
"Martin Schwidefsky" <schwidefsky@de.ibm.com> wrote:

> >  - Change dasd names from "dasdx" to "dasd_<busid>_".

> > This breaks mkinitrd, nash, and mount by label (not to mention every
> > zipl.conf out there, because root= aliases to /sys/block/%s).
> > Would you please explain what exactly you were thinking when you
> > submitted that patch?

> The reason for this change is the requirement to have persistent device
> names. The /dev/dasdxyz naming schema heavily depends on the order in
> which the device are added. Not good for persistent names. This change
> affects four things: 1) the internal name, 2) the name of the sysfs
> directory, 3) the root= parameter and 4) the hotplug events for dasd
> devices.

Martin, it is your architecture to break as you wish, but my gut feeling
is that you'd never get away with this if you did it on anything using
common use peripherals. This is a return to times of UNIX v6 and /dev/rk1a.
The chief penguin repeatedly stated that he wanted to see /dev/diskN
or similar (defined by a userland policy).

Considering Fedora Core 2, I do not know if we have time to repair the
damage. For the moment, I am patching a reverse patch.

Running a statically built dasd and having root=/dev/dasd_0.0.0202_1
in zipl.conf works fine. I am considering if we can get away with just
that and fixing mount by label to work. It's not the end of the world,
but it's annoying.

Is there a story of a real world deployment where the 2.4 scheme was
a hindrance which you could share? Honestly, I'm surprised you bring
the matter of "persistent names" instead of, say, exhaustion of
address range and majors.

-- Pete
