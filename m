Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTJNVKR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTJNVKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:10:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57249 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262785AbTJNVKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:10:09 -0400
Message-ID: <3F8C6576.464328CE@us.ibm.com>
Date: Tue, 14 Oct 2003 14:07:02 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: spi@gmxpro.de
CC: LKML <linux-kernel@vger.kernel.org>, root@chaos.analogic.com
Subject: Re: How to wait for kernel messages?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Oct 2003, Sebastian Piecha wrote:

> I have some problems with one NIC. Due to lack of time as an
> workaround I'd like to wait for the kernel message "NETDEV WATCHDOG:
> eth0: transmit timed out" and ifconfig down/up the NIC.
>
> How can I trigger any action by such a kernel message? Do I have to
> grep the kernel log?
>
> Mit freundlichen Gruessen/Best regards,
> Sebastian Piecha

If you had LTC's Event Logging installed, and you had your kernel
configured to forward printk messages to the event log, you could
do something like this:

evlnotify -f 'data~"NETDEV WATCHDOG: eth0: transmit timed out"' \
	-a 'ifconfig eth0 down; ifconfig eth0 up'

That would cause the ifconfig down/up to run each time the indicated
printk happened.

Jim Keniston
IBM Linux Technology Center
