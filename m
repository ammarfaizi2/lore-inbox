Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTJ0UYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTJ0UYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:24:17 -0500
Received: from root.org ([67.118.192.226]:18704 "HELO rootlabs.com")
	by vger.kernel.org with SMTP id S263496AbTJ0UYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:24:04 -0500
Date: Mon, 27 Oct 2003 12:24:04 -0800 (PST)
From: Nate Lawson <nate@root.org>
To: "Noah J. Misch" <noah@caltech.edu>
cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: [BUG] test9 ACPI bad: scheduling while atomic!
In-Reply-To: <Pine.GSO.4.58.0310262327040.19469@clyde>
Message-ID: <20031027122259.Y77994@root.org>
References: <Pine.GSO.4.58.0310262327040.19469@clyde>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, Noah J. Misch wrote:
> > are shown below.  It looks like the AML associated with the AC event is
> > trying to do an AML_SLEEP_OP.  Since this is called while in the
> > interrupt handler, and the eventual call to acpi_os_sleep() sets the
> > current state to interruptible... boom.  One simple, but terribly ugly,
> > workaround is to make acpi_os_sleep() call acpi_os_stall() if
> > in_atomic() is true (patch below).  Hopefully there's a better way to
> > fix this.  Somehow the interpreter really needs to drop interrupt
> > context before it starts making calls like this.  Thanks,

I thought a change was committed to address this, calling Stall for up to
255 us and Sleep for more than that.

-Nate
