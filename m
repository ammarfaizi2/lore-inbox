Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268449AbUHYDrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268449AbUHYDrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUHYDrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:47:02 -0400
Received: from fw.osdl.org ([65.172.181.6]:15051 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268449AbUHYDqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:46:55 -0400
Date: Tue, 24 Aug 2004 20:45:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, thomas@undata.org
Subject: Re: [PATCH] Fix shared interrupt handling of SA_INTERRUPT and
 SA_SAMPLE_RANDOM
Message-Id: <20040824204508.3b31449f.akpm@osdl.org>
In-Reply-To: <s5heklxhjbg.wl@alsa2.suse.de>
References: <s5heklxhjbg.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> while the recent investation of latency issues, Thomas Charbonne
>  suggested that there is a long-standing bug in the irq handler.
>  When the irq is shared, SA_INTERRUPT flag is checked only for the
>  first registered handler.  When it's without SA_INTERRUPT, always
>  local_irq_enable() is called even if the second or later handler has
>  SA_INTERRUPT.

That's because SA_INTERRUPT interrupts shouldn't be shared.  The grey cell
which remembered why this is so seems to have died, but I've put the email
thread here: http://www.zip.com.au/~akpm/linux/patches/stuff/x.txt
