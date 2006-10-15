Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWJOTQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWJOTQh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWJOTQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:16:37 -0400
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:36961 "HELO
	smtp105.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030250AbWJOTQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:16:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=IHmBAlW3SPXQ0q7nAtRCyg2viLJWt9vCxqFG6FRdIKQi2f+4J0LmSH0SdTGl8FIT8LCY7MgrdutImygN4QSEw5+6VNO6+BQhqR82YRkVuJ31J/oJpoNxJXBACSo4fy7QIDjWfYq4GJKx6sC9Q415+XcSv9Jbzw38Nnpk/jSGP6k=  ;
Date: Sun, 15 Oct 2006 12:16:31 -0700
From: David Brownell <david-b@pacbell.net>
To: alan@lxorguk.ukuu.org.uk, matthew@wil.cx, akpm@osdl.org
Subject: Re: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Cc: val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <1160161519800-git-send-email-matthew@wil.cx>
 <20061013214135.8fbc9f04.akpm@osdl.org>
 <20061014140249.GL11633@parisc-linux.org>
 <20061014134855.b66d7e65.akpm@osdl.org>
 <20061015032000.GP11633@parisc-linux.org>
 <20061015070809.978C714552@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <1160922082.5732.51.camel@localhost.localdomain>
 <20061015135756.GD22289@parisc-linux.org>
 <20061015104544.5de31608.akpm@osdl.org>
In-Reply-To: <20061015104544.5de31608.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061015191631.DE49D19FEC8@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(From Alan Cox:)
> The underlying bug is that someone marked pci_set_mwi must-check, that's
> wrong for most of the drivers that use it. If you remove the must check
> annotation from it then the problem and a thousand other spurious
> warnings go away.

Yes, there seems to be abuse of this new "must_check" feature.


(From Andrew Morton:)
> But if MWI _does_ make a difference to performance then we should tell
> someone that it isn't working rather than silently misbehaving?

Thing is, a "difference to performance (alone)" != "misbehavior".

If it affected correctness, then a warning would be appropriate.

Most drivers should be able to say "enable MWI if possible, but
don't worry if it's not possible".  Only a few controllers need
additional setup to make MWI actually work ... if they couldn't
do that setup, that'd be worth a warning before they backed off
to run in a non-MWI mode.

- Dave

