Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbUK3Vkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbUK3Vkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbUK3Vkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:40:39 -0500
Received: from gw.goop.org ([64.81.55.164]:57521 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S262332AbUK3VkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:40:24 -0500
Subject: Re: Buffer overrun in arch/x86_64/sys_ia32.c:sys32_ni_syscall()
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041130103150.I14339@build.pdx.osdl.net>
References: <1101787520.4087.5.camel@localhost>
	 <20041130103150.I14339@build.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 12:46:13 -0800
Message-Id: <1101847574.3951.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-0.mozer.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 10:31 -0800, Chris Wright wrote:
> * Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> > struct task_struct.comm is defined to be 16 chars, but
> > arch/x86_64/sys_ia32.c:sys32_ni_syscall() copies it into a static 8 byte
> > buffer, which will surely cause problems.  This patch makes lastcomm[]
> > the right size, and makes sure it can't be overrun.  Since the code also
> > goes to the effort of getting a local copy of current in "me", we may as
> > well use it for printing the message.
> 
> Looks good, but you missed sys32_vm86_warning.

Hadn't got that far.  Should we be worried that task_struct.comm might
not be \0-terminated, and therefore use ("... %.*s ...",
sizeof(lastcomm), lastcomm) in the printk's?

	J

