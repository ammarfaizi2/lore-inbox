Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbUK3WRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbUK3WRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUK3WRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:17:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:43498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262350AbUK3WRX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:17:23 -0500
Date: Tue, 30 Nov 2004 14:17:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Buffer overrun in arch/x86_64/sys_ia32.c:sys32_ni_syscall()
Message-ID: <20041130141718.I2357@build.pdx.osdl.net>
References: <1101787520.4087.5.camel@localhost> <20041130103150.I14339@build.pdx.osdl.net> <1101847574.3951.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1101847574.3951.3.camel@localhost>; from jeremy@goop.org on Tue, Nov 30, 2004 at 12:46:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> On Tue, 2004-11-30 at 10:31 -0800, Chris Wright wrote:
> > * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> > > struct task_struct.comm is defined to be 16 chars, but
> > > arch/x86_64/sys_ia32.c:sys32_ni_syscall() copies it into a static 8 byte
> > > buffer, which will surely cause problems.  This patch makes lastcomm[]
> > > the right size, and makes sure it can't be overrun.  Since the code also
> > > goes to the effort of getting a local copy of current in "me", we may as
> > > well use it for printing the message.
> > 
> > Looks good, but you missed sys32_vm86_warning.
> 
> Hadn't got that far.  Should we be worried that task_struct.comm might
> not be \0-terminated, and therefore use ("... %.*s ...",
> sizeof(lastcomm), lastcomm) in the printk's?

It gets NULL terminated during exec or prctl.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
