Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUJYEIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUJYEIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 00:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUJYEIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 00:08:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:58573 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261351AbUJYEId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 00:08:33 -0400
Subject: Concerns about our pci_{save,restore}_state()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 14:06:22 +1000
Message-Id: <1098677182.26697.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

I was looking at our "generic" pci_save_state() and pci_restore_state()
and I have various concerns with them, I was wondering what you though
about them...

 - We should always write the command register after all the BARs,
typically that mean write it back _last_
 - We shouldn't write to the BIST register, it is defined as having
side effects and writing to it any value may trigger a BIST on the
card, with all the possible bad consequences that has
 - What about saving/restoring more registers ? I'm not sure wether it
should be the responsibility of the driver to save and restore things
above dword 15, but we should at least deal with the case of P2P bridges
who have more "standard" registers

In addition, we currently have no mecanism to save/restore the state of
P2P bridges. Shouldn't we do that in pci_device_suspend() if there is no
driver attached ?

Ben.


