Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264839AbUETCS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbUETCS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 22:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUETCS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 22:18:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64493 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264839AbUETCSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 22:18:55 -0400
Message-ID: <40AC1580.6090401@pobox.com>
Date: Wed, 19 May 2004 22:18:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix 8139too ring size for dreamcast/embedded
References: <20040511125405.GA14578@linux-sh.org>
In-Reply-To: <20040511125405.GA14578@linux-sh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:
> Presently 2.6.6 backs out the CONFIG_8139_RXBUF_IDX in favor of using a
> hardcoded 8139_RXBUF_IDX (again). This seems to have been done due to
> some issues occuring with 8139_RXBUF_IDX == 3, however (as the Kconfig
> pointed out), we still need 8139_RXBUF_IDX == 1 in the CONFIG_SH_DREAMCAST
> case.
> 
> The patch which made this change can be seen at:
> 
> http://linux.bkbits.net:8080/linux-2.5/user=shemminger/cset@1.1371.719.67?nav=!-|index.html|stats|!+|index.html|ChangeSet@-8w
> 
> Before that, CONFIG_8139_RXBUF_IDX was set to 1 both in the CONFIG_SH_DREAMCAST
> and CONFIG_EMBEDDED cases. This patch adds that back into the current 8139too.

Patch applied to 2.6.x.


> Additionally, why remove the config option at all? Wouldn't it just be
> easier to drop the range from 0 - 3 to 0 - 2 until problems with a 64K ring
> size are resolved?

<shrug>  Mainly it was easier just to hardcode it in the driver.

I would not object to your suggestion of "0 - 2", however I tend to 
think that the current lack of option, with your patch applied, serves 
the user best:  the driver will always use the largest RX buffer 
possible for the hardware.

	Jeff



