Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266545AbUG1Bne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUG1Bne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266758AbUG1Bne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:43:34 -0400
Received: from mail.broadpark.no ([217.13.4.2]:26844 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S266545AbUG1Bnc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:43:32 -0400
To: Trent Lloyd <lathiat@bur.st>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Future devfs plans (sorry for previous incomplete message)
References: <200407261737.i6QHbff04878@freya.yggdrasil.com>
	<20040726062435.GA22559@thump.bur.st> <yw1xzn5nrv6o.fsf@kth.se>
	<20040728001217.GC31618@thump.bur.st>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 28 Jul 2004 03:43:29 +0200
In-Reply-To: <20040728001217.GC31618@thump.bur.st> (Trent Lloyd's message of
 "Wed, 28 Jul 2004 08:12:18 +0800")
Message-ID: <yw1x3c3cvrcu.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trent Lloyd <lathiat@bur.st> writes:

>> Trent Lloyd <lathiat@bur.st> writes:
>> 
>> > Wouldn't a possible solution to do this to develop an extension
>> > to tmpfs to catch files accessed that don't exist etc and use
>> > that in conjuction with udev?
>> 
>> There is a problem with that scheme.  Imagine that a program attempts
>> to access a non-existing device.  The special fs would call modprobe
>> or similar which would load the correct module.  Loading this module
>> would cause hotplug events upon which udev would create the device
>> node.  However, all this is asynchronous.  The special fs could wait
>> for a while for the device to appear, but this doesn't quite look like
>> a nice solution.  The exit status of modprobe can't be used, since
>> even if the module loads perfectly it might not cause the requested
>> device to be created.  Even if it does, there will be some delay from
>> the module being loaded to udev creating the device node, so how long
>> should the kernel wait for the device to appear?  I haven't thought
>> about it further, but I smell races here.
>
> I see your point, but I wonder how it differs from the current devfs
> implementation (i don't know how it works in these cases)

I'm speculating somewhat here, but I think the situation with devfs is
different.  Device nodes in devfs are created during module loading,
before modprobe returns.  This means that when modprobe has returned,
the device node will either have been created or never will be.

-- 
Måns Rullgård
mru@kth.se
