Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTIBUov (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTIBUov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:44:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3712 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261482AbTIBUoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:44:38 -0400
Date: Tue, 2 Sep 2003 16:44:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: James Clark <jimwclark@ntlworld.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model
In-Reply-To: <200309021943.15875.jimwclark@ntlworld.com>
Message-ID: <Pine.LNX.4.53.0309021620050.4709@chaos>
References: <200309021943.15875.jimwclark@ntlworld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Sep 2003, James Clark wrote:

> 1. Will the move to a more uniform driver model in 2.6 increase the
> chances of
> a given binary driver working with a 2.6+ kernel.
>

Most changes to the kernel are made without any consideration
of a so-called binary drivers at all. FWIW all drivers are "binary".
If a file is created that was generated for a specific kernel version,
it will work on that kernel version whether or not the driver
sources are available. If the driver does not contain the appropriate
MODULE_LICENSE() string, then several tools will show "tainted" so
that kernel developers will not waste time attempting to find a problem
with a kernel that might be caused by a driver. If the driver has its
source-code released, shown by the appropriate MODULE_LICENSE() string,
then kernel developers may review that driver and fix it if it
is causing a kernel problem.

> 2. Will the new model reduce the use/need for kernel modules. Would this be a
> good thing if functionality could be implemented in a driver instead of a
> module.
>

The current trend is to make all drivers modules. That way, the
kernel will not be bloated with thousands of drivers that are never
used. Basically, the kernel will have just enough hardware-interface
to boot, possibly into a RAM Disk. Then the modules necessary to
support the specific hardware are loaded, the devices initialized
and the boot continues.

> 3. Will the practice of deliberately breaking some binary only 'tainted'
> modules prevent take up of Linux. Isn't this taking things too far?
>
> James
> -

There is no such practice going on at this time. A module must
be compiled using the same interface elements (structure members, etc.)
as the kernel. Therefore it must have the same version number, compiled
against the same kernel headers. If the designer of the module can't
make the source code public (usually because of corporate restrictions)
then, if there is a problem that you need to report to the kernel
development group, you need to make sure that the "secret" module
is not installed at that time.  If the secret module is causing
the kernel problem, which is seldom the case BYW, then you need to
contact the provider of the secret module. They may have a brand-
new version that works perfectly.

A case-in-point: A truly MAJOR screen-card developer has not been
allowed to make the source-code publically available because of
corporate restrictions (A publically-owned company might not be
able to make their intellectual property public. This might cause
a stock-holder revolt). This major company has quickly responded
to failures of their modules to work in the latest kernel versions.
The result is that they have a good working relationship, even though
inserting one of their drivers will cause the OPPS reporting software
to declare that the kernel is "tainted".

You don't get a "tainted" message otherwise. You just get good
screen graphics.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


