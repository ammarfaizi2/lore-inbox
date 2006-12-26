Return-Path: <linux-kernel-owner+w=401wt.eu-S932847AbWL0AKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbWL0AKP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 19:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbWL0AKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 19:10:15 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:55536 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932847AbWL0AKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 19:10:13 -0500
X-Greylist: delayed 784 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Dec 2006 19:10:13 EST
Date: Tue, 26 Dec 2006 15:55:27 -0800 (PST)
From: David Lang <david.lang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
Subject: Re: Feature request: exec self for NOMMU.
In-Reply-To: <200612261823.07927.rob@landley.net>
Message-ID: <Pine.LNX.4.63.0612261549050.24795@qynat.qvtvafvgr.pbz>
References: <200612261823.07927.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2006, Rob Landley wrote:

> I'm trying to make some nommu-friendly busybox-like tools, which means using
> vfork() instead of fork().  This means that after I fork I have to exec in
> the child to unblock the parent, and if I want to exec my current executable
> I have to find out where it lives so I can feed the path to exec().  This is
> nontrivial.
>
> Worse, it's not always possible.  If chroot() has happened since the program
> started, there may not _be_ a path to my current executable available from
> this process's current or root directories.

does this even make sense (as a general purpose function)? if the executable 
isn't available in your path it's likly that any config files it needs are not 
available either.

> What would be really nice is if I could feed a NULL path to exec on NOMMU
> systems, and have that mean "re-exec the current executable".  I can't think
> of a way to do this without kernel support.  Any opinions on whether this is
> worthwhile?

for something like busybox/toolbox where you have different functions based on 
the name used to execute the program, which name would you use?

David Lang

> A nommu-friendly daemonize() is another use for this, by the way...
>
> Rob
>
