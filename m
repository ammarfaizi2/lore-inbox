Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270152AbTG0JbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270620AbTG0JbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:31:11 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:17572 "EHLO
	uptime.churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S270152AbTG0JbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:31:09 -0400
Subject: Re: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad
	value compared to 2.4
From: Stefan Jones <cretin@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org
In-Reply-To: <1059244318.3400.17.camel@localhost>
References: <1059244318.3400.17.camel@localhost>
Content-Type: text/plain
Organization: Gentoo Linux
Message-Id: <1059299182.3383.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 27 Jul 2003 10:46:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OSDL wrote:
> 
> Which is interesting in itself. It's entirely possible that we should 
> just ignore the 16-bit status when it comes to the SS_POWERON logic. 
> 
> 
> Does the card actually _work_ when you do your hack? Or does it just 
> stop the hang? 
> 
It just stopped the hang, which caused me to think I was onto something.

I will continue my debugging and take this to the pcmcia list,

so far with printk's and early returns I have got the following:

The ds_ioctl's are triggering the hang,

ioctl calls to DS_ADJUST_RESOURCE_INFO and DS_GET_STATUS work fine (all
others are quoted out and are not called before the hang )

But the first call to DS_VALIDATE_CIS causes the machine to hang.
I have tracked down the hang to 

pcmcia_get_first_tuple called from
pcmcia_validate_cis called from
ds_ioctl

in cistpl.c

Will narrow it down some more today.

PS. the card is:
Netgear 802.11b wireless PC card 16-bit PCMCIA MA401
( which works fine with 2.4.21 )

For you pcmcia ppl:
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0166.html
( hardware details )
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.3/0690.html
( my misdiagnosis )

Any tips, known problem?

Stefan

