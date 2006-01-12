Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWALSnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWALSnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWALSnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:43:07 -0500
Received: from isilmar.linta.de ([213.239.214.66]:49118 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932657AbWALSnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:43:06 -0500
Date: Thu, 12 Jan 2006 19:43:05 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: soft lockup detected in acpi_processor_idle() -- false positive?
Message-ID: <20060112184305.GA7068@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest git, fresh after resuming from suspend-to-disk (in-kernel variant):

[4294914.586000] Restarting tasks... done
[4294922.657000] BUG: soft lockup detected on CPU#0!
[4294922.657000] 
[4294922.657000] Pid: 0, comm:              swapper
[4294922.657000] EIP: 0060:[<f003084c>] CPU: 0
[4294922.657000] EIP is at acpi_processor_idle+0x1f3/0x2d5 [processor]
[4294922.657000]  EFLAGS: 00000282    Not tainted  (2.6.15)
[4294922.657000] EAX: fffff000 EBX: 005543a8 ECX: 00000000 EDX: 00000000
[4294922.657000] ESI: edcc3064 EDI: edcc2f60 EBP: c041cfdc DS: 007b ES: 007b
[4294922.657000] CR0: 8005003b CR2: 080c3000 CR3: 2d530000 CR4: 000006d0


As acpi_processor_idle doesn't take any locks AFAIK, it seems to me to be a
false positive -- or do I miss something obvious?

	Dominik
