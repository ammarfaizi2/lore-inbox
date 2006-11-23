Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933608AbWKWLHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608AbWKWLHQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933606AbWKWLHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:07:15 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12001 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S933601AbWKWLHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:07:13 -0500
Date: Thu, 23 Nov 2006 11:13:07 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Conke Hu" <conke.hu@amd.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add IDE mode support for SB600 SATA
Message-ID: <20061123111307.3b249ce9@localhost.localdomain>
In-Reply-To: <20061122182610.4d9f3d98.akpm@osdl.org>
References: <FFECF24D2A7F6D418B9511AF6F3586020108CD36@shacnexch2.atitech.com>
	<20061122182610.4d9f3d98.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 18:26:10 -0800
Andrew Morton <akpm@osdl.org> wrote:

> I doubt if it's appropriate to do all this via ifdefs.  Users don't compile
> their kernels - others compile them for the users.  We need the one kernel
> binary to support both modes.   Possible?

I'm not sure we do. What the Jmicron drivers do is

- If SATA (libata) is enabled (module or built in) then turn on AHCI
- If it is not enabled then support the chip fully in SFF mode via
drivers/ide

As the AHCI mode is fundamentally better (both with respect to standards
and to performance) this makes sense.

I think the SB600 should do the same - if support is in the
kernel/modules - then turn on AHCI mode. If not then don't. No user
options needed, no complex config questions.

Alan
