Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752160AbWCOXWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbWCOXWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbWCOXWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:22:50 -0500
Received: from mail.gurulabs.com ([67.137.148.7]:28826 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S1752160AbWCOXWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:22:49 -0500
Subject: Re: Warning - Maxtor SATA II and Nvidia nforce4
From: Dax Kelson <dax@gurulabs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
In-Reply-To: <4418996E.6010808@garzik.org>
References: <1142461887.2521.44.camel@station14.example.com>
	 <4418996E.6010808@garzik.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 16:23:18 -0700
Message-Id: <1142464998.5578.17.camel@station14.example.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 17:47 -0500, Jeff Garzik wrote:
> Ah, I see this made it to LKML :)
> 
> Dax Kelson wrote:
> > Short version
> > ==============
> > Nvidia Nforce4 chipset with Maxtor SATA II drives with certain firmware
> > revisions cause data corruption and system instability when under
> > moderate to heavy I/O load.
> 
> I'm a bit suspicious of this.
> 
> Looking at the link, there are three problem areas and two problem blame 
> targets implied:
> 
> 	Data corruption	-> blame nvidia driver
> 	NCQ		-> blame nvidia driver
> 	Detection	-> blame maxtor firmware
> 
> The first one likely applies to the Windows driver not Linux's sata_nv, 
> and thus irrelevant here.

No.

Take a big file (5-10gb)

$ cp bigfile newfile
$ cp bigfile newfile2
$ cp bigfile newfile3
$ cp bigfile newfile4
$ md5sum bigfile newfile*
[results are all different, assuming kernel doesn't panic during test]

When I use the "stress" utility from
http://weather.ou.edu/~apw/projects/stress/

The box usually makes it an an hour or two before a kernel panic or I/O
errors wedge the box.

I setup a netdump/netconsole server on my network and I have several
crashes captured. If you are interested I can send them on to you. I
filed most them under the Red Hat bugzilla, but closed them after I
discovered they were a hardware problem.

> The second one OBVIOUSLY applies only to 
> Windows, since sata_nv (and libata itself) don't yet enable NCQ.  The 
> third one could potentially apply to Linux.  Lastly, your mention of 
> "nforce fake raid" almost certainly indicates Windows or proprietary 
> drivers.

Linux device mapper is proprietary? :)

The corruption occurs with a single disk or when using a device mapper
"nvraid".

> Therefore, I ask:
> * are you reporting a only drive detection problem?

No. Detection was never a problem for me.

> * why are you reporting unrelated Windows problems to a Linux list?

I'm not, see above.

> * if you are indeed reporting a problem on Linux, where is the kernel 
> and driver version info, as requested in REPORTING-BUGS?

Well, what can Linux do about this hardware problem? Maybe there is a
workaround that can be done, but I'm not counting on it. A warning would
be nice if it possible to detect the conditions where this can occur.
This way others can troubleshoot and identify this problem quicker.

I used mostly late model FC5 rawhide kernels which I believe are based
off of 2.6.16rc5-git12/git13 or therebouts.

> * and can you provide such info *and reproduce the problems* without 
> proprietary drivers loaded?

Sorry for the misunderstanding. Again, no proprietary drivers ever
loaded. Problem is 100% reproducible. See above, etc.

Dax Kelson


