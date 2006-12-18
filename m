Return-Path: <linux-kernel-owner+w=401wt.eu-S1754168AbWLRPpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168AbWLRPpH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754170AbWLRPpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:45:06 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:56472 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbWLRPpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:45:05 -0500
Message-ID: <4586B77E.1080803@s5r6.in-berlin.de>
Date: Mon, 18 Dec 2006 16:45:02 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: ieee1394 in 2.6.20-rc1 (was Re: Linux 2.6.20-rc1)
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612171834.59624.gene.heskett@verizon.net> <4585E967.6000706@s5r6.in-berlin.de> <200612172329.14723.gene.heskett@verizon.net>
In-Reply-To: <200612172329.14723.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Sunday 17 December 2006 20:05, Stefan Richter wrote:
>>What's missing in our implementation is that the use count of ohci1394
>>goes up too once a "high-level driver" uses resources of a host driven
>>by ohci1394.
> 
> This needs some tlc then I assume?

Yes. It's now logged at http://bugzilla.kernel.org/show_bug.cgi?id=7701
and will probably stay there until I do something about it myself.

>>The FireWire stack has three layers: Low level (ohci1394 and pcilynx;
>>control the host bus adapter),
> The hardware

Yes, or more precisely the built-in hardware, not hardware at the other
end of the wire.

>>mid level (the ieee1394 core)
> which I assume (fuggly word) steers the high level stuff to the right 
> entry points in the hardware handler?

Yes. It implements common management functionality and makes actions
like "write into a register of a remote node" or "receive a stream into
a buffer" independent of the actual host adapter --- or at least that
was the intent when Linux' FireWire stack was designed. Years ago there
was actually another driver for a non-OHCI host adapter chip from
Adaptec; and there is a mostly functional but unmaintained out-of-tree
driver for a non-OHCI/ non-PCI adapter from Texas Instruments (TI GP2Lynx).

IOW the ieee1394 core provides a platform to stick application-level
drivers (protocol drivers) like for DV, IPv4 networking, SBP-2 storage
on top of it without having to care of how particular host adapter chips
are programmed. raw1394 basically extends ieee1394 to stick userspace
drivers on it.

But as mentioned, this layering is partly violated in the actual
implementation. Also, the ieee1394 core is itself needlessly dependent
on a PCI kernel API, making it harder for embedded developers to add
their own low-level drivers than it ought to be. (So I was told; I
actually rarely hear from embedded development projects.)
-- 
Stefan Richter
-=====-=-==- ==-- =--=-
http://arcgraph.de/sr/
