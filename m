Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbTICVXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTICVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 17:23:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261423AbTICVXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 17:23:44 -0400
Date: Wed, 3 Sep 2003 17:23:46 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Muthian S <muthian_s@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Remote SCSI Emulation 
In-Reply-To: <LAW11-F717fcGuKeddZ000021c9@hotmail.com>
Message-ID: <Pine.LNX.4.53.0309031707001.362@chaos>
References: <LAW11-F717fcGuKeddZ000021c9@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Muthian S wrote:

> Hi,
>
> Certain SCSI adapters like the Adaptec AHA 29160 are reportedly capable of
> acting as a target and can receive SCSI commands from initiators.  Such an
> adapter can be used to facilitate remote SCSI emulation by a PC.
> For instance, if two PCs have the adapter, the two adapters can be
> directly connected by a SCSI bus and the second PC can in effect serve as
> an "emulated SCSI disk".  Such a setup is extremely helpful in various
> scenarios.
>
> However, for this to work, the OS on the second PC (which serves as the
> emulated scsi disk) should be capable of handling incoming SCSI requests and
> directing them to an appropriate software layer.  Apparently, the CAM
> subsystem of FreeBSD has this capability.  I was wondering if there is a
> similar mechanism in linux.
>
> It would be really helpful if people have comments on whether such a setup
> is
> possible in linux, and if yes, are there specific adapters that are known
> to work in this fashion.
>
> thanks,
> Muthian.
>

Many modern SCSI Adapters can receive SCSI commands. They are not,
however, relayed to some "appropriate software layer". Instead, the
driver will handle these commands and provide an appropriate
abstraction layer to user-mode software. Anybody who wants,
can make such a driver. Typically the SCSI 'device' becomes a
"memory device" because this provides the largest possible communications
capability (a memory device can be a DSP (or several), for instance).

Analogic's AP-85, now obsolete was a SCSI "memory device". It
could accumulate high-speed data then it could process it with
code that was uploaded using the SCSI interface as well. It was
quite a machine, now about 15 years out-of-date. The processing
was done with 4 DSPs (TMS320C30) plus a 16-bit controller uP.
This was designed long before anybody heard of SMP.

These kinds of interfaces are quite out-of-date because of the
relatively low speed at which they operate (75 Megabytes/second).
Therefore, there is not much call for such interface drivers.
Everybody wants at least 300 Megabytes/second now-days, preferably
4 times that. A typical high-speed interface to parallel DSP
systems now-days will ... "do an infinite loop in a few hours..."
-- that, from an also-obsolete Gray advertisement --

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


