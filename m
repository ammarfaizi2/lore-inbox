Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTI2WIo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 18:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbTI2WIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 18:08:44 -0400
Received: from gprs144-48.eurotel.cz ([160.218.144.48]:2693 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263014AbTI2WIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 18:08:42 -0400
Date: Tue, 30 Sep 2003 00:07:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, scottm@somanetworks.com,
       greg@kroah.com, rgooch@atnf.csiro.au, mingo@redhat.com, pavel@suse.cz
Subject: Re: 2.6.0-test6: a few __init bugs
Message-ID: <20030929220717.GH1815@elf.ucw.cz>
References: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064872693.5733.42.camel@dooby.cs.berkeley.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Here are several places where non-__init functions call __init functions
> or reference __init data.  I've looked at all of them and believe that
> they are all either legitimate bugs or opportunities to declare more
> code as __init to save memory.  Thanks for looking over these, and sorry
> if I've made any mistakes.

> ** Code should be declared __init?
> ** name_to_dev_t()                                                     (__init)
>      called by kernel/power/swsusp.c:read_suspend_image()              (not __init)
>        called by kernel/power/swsusp.c:software_resume()               (not __init)
> Fix: declare read_suspend_image() __init
> Fix: declare software_resume() __init
> 
> Note: read_suspend_image() in pmdisk.c is declared __init.

Yes, it should be safe to declare that code __init. Applied.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
