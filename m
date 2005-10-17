Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbVJQVvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbVJQVvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVJQVvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:51:36 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:22696 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932346AbVJQVvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:51:36 -0400
Date: Mon, 17 Oct 2005 23:53:43 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1 dead in early boot
Message-ID: <20051017215343.GA30829@aitel.hist.no>
References: <20051016154108.25735ee3.akpm@osdl.org> <20051017210609.GA30116@aitel.hist.no> <20051017140906.0771f797.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017140906.0771f797.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:09:06PM -0700, Andrew Morton wrote:
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> >
> > This one gets me a penguin on the framebuffer, and then dies
> > with no further textual output.  
> > numlock leds were working, and I could reboot with sysrq.
> 
> Can we get anything useful out of sysrq-p and sysrq-t?
> 
> Also, adding initcall_debug to the boot command line might help.
> 
Tried again without the framebuffer.  Still hanging, but more info:

Last messages before getting stuck:
md autorun DONE
kjournald starting
Ext3-fs mounted fs w. ordered data mode
VFS mounted root (ext3) read-only
freeing unused kernel memory 216k freed.
warning-unable to open an initial console
kernel panic-not syncing:No init found. Try passing init= option to kernel


Somewhat silly. There certainly was a console (vgacon) or I wouldn't
be able to read the messages.  And if it mounted root, then there certainly
was an init to run also.


SYSRQ P  (Omitting lots of time-consuming hex numbers, please tell
if those are really needed.)
sysrq: show regs
cpu 0
Pid:1, comm: swapper not tainted 2.6.14-rc4-mm1 #17
RIP  {__delay+4}
(Omitted register dump)
Call trace:
panic+315
vgacon_cursor+0
init+543
child_rip+8
init+0
child_rip+0

SYSRQ T  gave me several pages, with no scrollback.  Several kernel
threads and their stack dumps.  Simplified:
kedac     R running task
md2       S
md3       S
md0       S
kjournald S

I can provide the full 80x50 page, but I have to write it down by hand
so only if someone actually think it will be useful.

That EDAC thing was new in rc4-mm1, compared to rc3.  I am testing
another rc4-mm1 kernel without it.  (menuconfig adviced me to say Y
to the new EDAC thing, so I did that initially.)

Helge Hafting
