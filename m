Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbUBICkX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 21:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264563AbUBICkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 21:40:23 -0500
Received: from slask.tomt.net ([217.8.136.223]:22400 "EHLO pelle.tomt.net")
	by vger.kernel.org with ESMTP id S264558AbUBICkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 21:40:22 -0500
Message-ID: <4026F312.60703@tomt.net>
Date: Mon, 09 Feb 2004 03:40:18 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.3-rc1
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402082351.48958.bzolnier@elka.pw.edu.pl> <4026CF98.5000905@tomt.net> <200402090234.20832.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402090234.20832.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Ok thanks, I got the same dump.  I think the problem is that memory used by
> previously registered ide_pci_host_proc_list entry (for pdc202xx_new driver)
> is already unmapped because of __initdata in pdc202xx_new.h.
> (This doesn't happen in built-in case because this memory is freed after
> all drivers are initialized.)
> 
> Does this patch help?

Ahh, indeed it does, _but_

pdc202xx_old seems to have the same bug, making via82cxxx crash later on 
instead.

Doing the same change to pdc202xx_old.h (removing __initdata) fixes this 
case too :-)
