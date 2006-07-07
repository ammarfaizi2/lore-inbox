Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWGGTuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWGGTuO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWGGTuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:50:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46825 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932291AbWGGTuM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:50:12 -0400
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <87veq9cosq.fsf@javad.com>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org>  <87veq9cosq.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Jul 2006 21:07:11 +0100
Message-Id: <1152302831.20883.63.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-07 am 21:23 +0400, ysgrifennodd Sergei Organov:
> It seems that there is much worse problem here. The amount of data that
> has been inserted by the tty_insert_flip_string() could be up to
> URB_TRANSFER_BUFFER_SIZE (=4096 bytes) and may easily exceed
> TTY_THRESHOLD_THROTTLE (=128 bytes) defined in the
> char/n_tty.c. 

You may throttle late but that is always true as there is an implicit
race between the hardware signals and the chip FIFO on all UART devices.
The buffering should be taking care of it, and the tty layer taking care
not to over stuff the ldisc which I thought Paul had fixed while doing
the locking wizardry

Alan



