Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUEPRte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUEPRte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbUEPRtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:49:33 -0400
Received: from main.gmane.org ([80.91.224.249]:52146 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264683AbUEPRt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:49:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
Date: Sun, 16 May 2004 21:49:17 +0400
Message-ID: <pan.2004.05.16.17.49.14.823495@altlinux.ru>
References: <40A7A278.7010405@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.177.124.23
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 May 2004 21:18:48 +0400, Brad Campbell wrote:

> I have been using 2.6.5 happily for a while now on this machine.
> It's an Asus A7V600 with 3 Promise SATA150-TX4 SATA cards.
> 
> With 2.6.6 (and 2.6.6-bk3) it hangs with a dma timeout on boot detecting the 9th sata drive (there 
> are 10). I left it for about 10 minutes to see if anything else transpired but it just sat there.
> I'm on a serial console to this machine at the moment and I could not get it to respond to the magic 
> sysrq key over serial either.
> 
> I have placed all relevant info including a capture of 2.6.5 boot and 2.6.6 boot, plus all requested 
> info from linux/REPORTING-BUGS on my webpage
> 
> Normal working dmesg
> http://www.wasp.net.au/~brad/2.6.5.log
> 
> Hung up dmesg
> http://www.wasp.net.au/~brad/2.6.6.log
> 
> .config and all other info I could gather.
> http://www.wasp.net.au/~brad/2.6.6.config
> Much as I'd love to be subscribed, I just can't keep up with the volume so please cc: me.
> Willing to try patches/hacks/suggestions

Looks like ACPI problems.  First, for some reason ACPI in 2.6.6 decided to
use PIC mode, while 2.6.5 used IOAPIC mode.  Second, IRQ 12 was chosen for
the Promise controller which failed; this is a known problem in 2.6.6,
the patch at http://bugzilla.kernel.org/show_bug.cgi?id=2665 should fix it.


