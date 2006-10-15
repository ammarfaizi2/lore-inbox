Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWJOHIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWJOHIP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 03:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWJOHIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 03:08:15 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:24755 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964815AbWJOHIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 03:08:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=BG3OnBJUENWnigggWMVBv0BUeWc9dVxJi3c3+pBR/mnBN4w+HMFPXLEhz20cVHzMtRP8yWZy0m3HjUrueIH68UJcvpDO9nH4l1qOEPN3FkRxDqVZTRI948+l9+nZxzplHEw7Qe3R5UyBg4jaOC3taKfKMw/CcHvSIUSfnnW/FQA=  ;
Date: Sun, 15 Oct 2006 00:08:09 -0700
From: David Brownell <david-b@pacbell.net>
To: matthew@wil.cx, akpm@osdl.org
Subject: Re: [Bulk] Re: [PATCH 1/2] [PCI] Check that MWI bit really did get 
 set
Cc: val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <1160161519800-git-send-email-matthew@wil.cx>
 <20061013214135.8fbc9f04.akpm@osdl.org>
 <20061014140249.GL11633@parisc-linux.org>
 <20061014134855.b66d7e65.akpm@osdl.org>
 <20061015032000.GP11633@parisc-linux.org>
In-Reply-To: <20061015032000.GP11633@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the only effect of returning EINVAL is a printk (for this particular
> driver):
>
>         /* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
>         retval = pci_set_mwi(pdev);
>         if (!retval)
>                 ehci_dbg(ehci, "MWI active\n");

Erm, I've lost context here but it's completely legit for hardware
to NOT support MWI, so it is in no way an error if it's not set.
(Memory-Write-Invalidate is just a more efficient way to write data
that may be cached; if the device can't issue those cycles, there's
no loss of correctness.)

Since it's not an error, there should be no such printk ... which
is exactly how it's coded above.

Who is issuing the printk on a non-error code path??

- Dave


