Return-Path: <linux-kernel-owner+w=401wt.eu-S1751527AbXALNlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbXALNlj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbXALNlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:41:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52835 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751442AbXALNli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:41:38 -0500
Date: Fri, 12 Jan 2007 13:53:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Proposed changes for libata speed handling
Message-ID: <20070112135301.4cdba24f@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently hacking on the speed handling code a bit

I'd like to do the following unless anyone has any objections

- Remove post_set_mode and make drivers wrap the guts of the existing
set_mode() function. This allows a driver to wrap and see success/failure
while removing a callback, and also to add pre-mode code. (ie you'd do

foo_set_mode() {
    ata_default_set_mode()
    my_fiddling();
}

- Fix the ->set_mode method FIXMEs in the current tree [DONE]

- Add set_specific_mode, with a default behaviour that works for most
controllers. Those using a private ->set_mode might need a private
->set_specific_mode, in some cases like it8212 simply to error the request

- Hook set_specific_mode to the ata command parser so that instead of
erroring set_features commands we snoop them and force the mode change
desired on the controller (if valid)

- Send the command to set the speed before setting the controller speed,
so that we send them at the right rate.

Any comments ?

Alan
