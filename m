Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUGZJKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUGZJKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 05:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUGZJKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 05:10:10 -0400
Received: from main.gmane.org ([80.91.224.249]:2260 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265086AbUGZJJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 05:09:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Future devfs plans (sorry for previous incomplete message)
Date: Mon, 26 Jul 2004 11:09:51 +0200
Message-ID: <yw1xzn5nrv6o.fsf@kth.se>
References: <200407261737.i6QHbff04878@freya.yggdrasil.com> <20040726062435.GA22559@thump.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:cLZWuGN6VctAtDPRj32kW70CzAw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trent Lloyd <lathiat@bur.st> writes:

> Wouldn't a possible solution to do this to develop an extension to tmpfs to
> catch files accessed that don't exist etc and use that in conjuction
> with udev?

There is a problem with that scheme.  Imagine that a program attempts
to access a non-existing device.  The special fs would call modprobe
or similar which would load the correct module.  Loading this module
would cause hotplug events upon which udev would create the device
node.  However, all this is asynchronous.  The special fs could wait
for a while for the device to appear, but this doesn't quite look like
a nice solution.  The exit status of modprobe can't be used, since
even if the module loads perfectly it might not cause the requested
device to be created.  Even if it does, there will be some delay from
the module being loaded to udev creating the device node, so how long
should the kernel wait for the device to appear?  I haven't thought
about it further, but I smell races here.

-- 
Måns Rullgård
mru@kth.se

