Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUBKUF2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUBKUF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:05:28 -0500
Received: from thunk.org ([140.239.227.29]:206 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265700AbUBKUFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:05:22 -0500
Date: Wed, 11 Feb 2004 15:05:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Mike Bell <kernel@mikebell.org>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211200517.GA4846@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	Mike Bell <kernel@mikebell.org>, linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <4028DA93.9060107@aitel.hist.no> <20040210160011.GJ4421@tinyvaio.nome.ca> <4029F96A.6050105@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4029F96A.6050105@aitel.hist.no>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:44:10AM +0100, Helge Hafting wrote:
> Sure.  Completely random device numbers will make this demand loading of 
> device drivers impossible. Either it won't happen (all numbers won't be 
> completely random, although they may get more dynamic than today) or
> module loading based on device node opening will be deprecated.

It could be made to work.  You could have a magic device number, say
(255,255), which means "unloaded device driver", which causes a
hotplug callout, and a SIGSTOP sent to the process that tried the
open.  The userspace program would then be responsible for loading the
relevant device driver, converting the /dev file to the correct
dynamic major/minor number, and then sending a SIGCONT to the process,
which would then either restart the open() or the open() would return
-EAGAIN.  

It would be kinda hairy, in that the kernel would need to know whether
or not userspace had accepted responsibility for handling these calls
(if it didn't open() would just return -ENODEV as it does today).  So
it might not be worth doing, but if people really cared about it, it
could indeed be done.

					- Ted
