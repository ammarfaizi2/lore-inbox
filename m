Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUGXDOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUGXDOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUGXDOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:14:36 -0400
Received: from peabody.ximian.com ([130.57.169.10]:5014 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268253AbUGXDOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:14:34 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <4101D14D.6090007@metaparadigm.com>
References: <1090604517.13415.0.camel@lucy>
	 <4101D14D.6090007@metaparadigm.com>
Content-Type: text/plain
Date: Fri, 23 Jul 2004 23:14:41 -0400
Message-Id: <1090638881.2296.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 11:02 +0800, Michael Clark wrote:

> Should there be some sharing with the device naming of sysfs or are
> will we introduce a new one? ie sysfs uses:
>
> devices/system/cpu/cpu0/<blah>
>
> Would it be a better way to have a version that takes struct kobject
> to enforce consistency in the device naming scheme. This also means
> userspace would automatically know where to look in /sys if futher
> info was needed.

No, we want to give an interface that matches the sort of provider URI
used by object systems such as CORBA, D-BUS, and DCOP.  We also do _not_
want to put policy in the kernel.

The easiest way to avoid that is simply to use a name similar to the
path name.

Passing the sysfs name would probably be a good potential argument to
the signal, though.  The temperature signal in the patch is just an
example.

> Question is does it make sense to use this infrastructure without sysfs
> as hald, etc require it. ie depends CONFIG_SYSFS

That sounds like policy to me.

Especially if drivers start using this for error logging, there are no
ties to sysfs.  Configuration dependencies tend to be hard build-time
deps anyhow.

	Robert Love


