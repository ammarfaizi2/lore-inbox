Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317343AbSGIIvo>; Tue, 9 Jul 2002 04:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317342AbSGIIvn>; Tue, 9 Jul 2002 04:51:43 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:27296 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317341AbSGIIvm> convert rfc822-to-8bit; Tue, 9 Jul 2002 04:51:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Thunder from the hill <thunder@ngforever.de>,
       Keith Owens <kaos@ocs.com.au>
Subject: Re: Driverfs updates
Date: Tue, 9 Jul 2002 10:30:17 +0200
User-Agent: KMail/1.4.1
Cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207081745150.10105-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0207081745150.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207091030.17096.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I suggest you add a global driverfs_lock.
>
> Better than locking all kernel threads, isn't it?

No, it is not, not by far.

-It means that modules are not transparent.
-Everybody is punished, module or no module.
-It limits modules to providing open/use/close APIs.
-It is slow.
-Modules can only be used on APIs that provide for them.

By freezing, which happens only on module removal,
only users of modules are punished. Handling of
module usage counts can be encapsulated in the modules
themselves. And alternative methods of determining removability
are possible.

Face it, SMP and module unloading have some fundamental problems.
Therefore you switch the box to pseudo-UP for unloading,
that's what freeze effectively does. You just have to disable preempt
on all CPUs and wait for the tasks running to leave kernel.

Cleanly killing a kernel thread of a module is duty of the module's
cleanup function. Independent kernel threads which use a module
must be allowed to sleep voluntarily before they are frozen.
In this case the old rule of "INC before you sleep" is valid again.

	Regards
		Oliver

