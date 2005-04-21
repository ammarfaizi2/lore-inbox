Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVDURBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVDURBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDURBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:01:48 -0400
Received: from hermes.domdv.de ([193.102.202.1]:30986 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261552AbVDURAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:00:31 -0400
Message-ID: <4267DC2E.9030102@domdv.de>
Date: Thu, 21 Apr 2005 19:00:30 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pavel@ucw.cz, rjw@sisk.pl
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3: various swsusp problems
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,
there's some problems with swsusp in 2.6.12-rc3 (x86_64):

1. Is it necessary to print the following message during regular boot?
   swsusp: Suspend partition has wrong signature?
   It is a bit annoying and I believe it will confuse some swsusp
   users.

2. PCMCIA related hangs during swsusp.
   swsusp hangs after freeing memory when either cardmgr is running
   or pcmcia cards are *physically* inserted. It is insufficient
   to do a 'cardctl eject' the cards must be removed, too, for
   swsusp not to hang. I do suspect some problem with the
   'pccardd' kernel threads.

3. Sometimes during the search for the suspend hang reason the system
   went during suspend into a lightshow of:
   eth0: Too much work at interrupt!
   and some line that ends in:
   release_console_sem+0x13d/0x1c0)
   The start of the line is not readable as it just flickers by in
   the eth0 message limbo. NIC is a built in RTL-8169 Gigabit Ethernet
   (rev 10). Oh, no chance for a serial console capture as there's no
   built in serial device in this laptop.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
