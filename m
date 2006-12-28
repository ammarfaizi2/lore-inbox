Return-Path: <linux-kernel-owner+w=401wt.eu-S1755008AbWL1VqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008AbWL1VqY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755009AbWL1VqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:46:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.174]:50951 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbWL1VqX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:46:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: BUG: scheduling while atomic, new libata code
Date: Thu, 28 Dec 2006 22:47:05 +0100
User-Agent: KMail/1.9.5
Cc: "Randy Dunlap" <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <9e4733910612261747s4b32d6ben2e5a55f88f225edf@mail.gmail.com> <20061226175559.e280e66e.randy.dunlap@oracle.com> <9e4733910612271816x1ebc968auf94de2a84526aee0@mail.gmail.com>
In-Reply-To: <9e4733910612271816x1ebc968auf94de2a84526aee0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612282247.06127.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 03:16, Jon Smirl wrote:
> BUG: scheduling while atomic: hald-addon-stor/0x20000000/5078
>  [<c02b0289>] __sched_text_start+0x5f9/0xb00
>  [<c024a623>] net_rx_action+0xb3/0x180
>  [<c01210f2>] __do_softirq+0x72/0xe0
>  [<c0105205>] do_IRQ+0x45/0x80

This doesn't seem to be related to libata at all. Like your
first trace, you call schedule from a softirq context, which
is always atomic.
The only place where I can imagine this happening is the
local_irq_enable() in there, which can be defined in different
ways.
Are you running with paravirt_ops, CONFIG_TRACE_IRQFLAGS_SUPPORT
and/or kernel preemption enabled?

	Arnd <><
