Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267396AbUG2Anu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267396AbUG2Anu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267394AbUG2AlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:41:02 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:53708 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267400AbUG2Ah2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:37:28 -0400
Subject: Re: -mm swsusp: do not default to platform/firmware
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@digitalimplant.org>,
       akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040728234352.GA14319@elf.ucw.cz>
References: <20040728222445.GA18210@elf.ucw.cz>
	 <20040728161448.336183e2.akpm@osdl.org> <20040728233929.GD16494@elf.ucw.cz>
	 <20040728234352.GA14319@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1091061026.8873.78.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 10:30:26 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-29 at 09:43, Pavel Machek wrote:
> +I did found some kernel threads don't do it, and they don't freeze, and

"I found... threads that don't..."

> +so the system can't sleep. Is this a known behavior?
> +
> +A: All such kernel threads need to be fixed, one by one. Select place
> +where it is safe to be frozen (no kernel semaphores should be held at
> +that point and it must be safe to sleep there), and add:
> +
> +            if (current->flags & PF_FREEZE)
> +                    refrigerator(PF_FREEZE);
> +

Perhaps you should also add.

If the thread is needed for writing the image to storage, you should
instead set the PF_NOFREEZE process flag when creating the thread.

Regards,

Nigel

