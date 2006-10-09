Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWJIKDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWJIKDo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWJIKDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:03:44 -0400
Received: from mout2.freenet.de ([194.97.50.155]:57736 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751014AbWJIKDn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:03:43 -0400
Date: Mon, 09 Oct 2006 12:05:11 +0200
To: "Peter Osterlund" <petero2@telia.com>
Subject: Re: [PATCH 7/11] 2.6.18-mm3 pktcdvd: make procfs interface optional
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
References: <op.tguqh5r2iudtyh@master> <m3bqoqmt3e.fsf@telia.com>
Content-Transfer-Encoding: 7BIT
Message-ID: <op.tg5c8vr2iudtyh@master>
In-Reply-To: <m3bqoqmt3e.fsf@telia.com>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 05.10.2006, 21:59 Uhr, schrieb Peter Osterlund <petero2@telia.com>:

> Given the fact that Linus doesn't allow breaking user space tools
> unless absolutely necessary, I don't think it makes sense to be able
> to disable the character device control code.

Hmm, since it will be optional to leave the procfs interface in the
kernel, it is on the admin / distribution builder to decide this.
I know only one tool that uses this interface (pktsetup), maybe there
are others, but if the sysfs interface will be available in future (?),
there is another (simple) option to control the driver, using simple
shell commands e.g.
And i read anywhere, that procfs should only contain process information
in a far away (?) future ;)

> Therefore a patch that unconditionally moves
> /proc/driver/pktcdvd/pktcdvd? to debugfs would make a lot of sense.

Then move it to debugfs and drop it from procfs.

> Also, the current change has another problem:
>
> static int pkt_seq_show(struct seq_file *m, void *p)
> +{
> +       struct pktcdvd_device *pd = m->private;
> +       char buf[1024];
> +
> +       pkt_print_info(pd, buf, sizeof(buf));
> +       seq_printf(m, "%s", buf);
> +       return 0;
> +}
>
> This wastes 1K stack space, and it can corrupt the stack if the
> pkt_print_info() function wants to write more than 1K data.

Ok, 1k is a little bit high, since only about 300 chars are written
into the buffer currently.
But also, pkt_print_info() would only write sizeof(buf) chars into
the buffer.

-Thomas
