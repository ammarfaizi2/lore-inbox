Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVCORN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVCORN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 12:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVCORMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 12:12:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:51655 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261542AbVCORL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 12:11:29 -0500
Date: Tue, 15 Mar 2005 09:08:34 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Cc: Kay Sievers <kay.sievers@vrfy.org>
Subject: [RFC] Changes to the driver model class code.
Message-ID: <20050315170834.GA25475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

There are 4 patches being posted here in response to this message that
start us on the way toward cleaning up the driver model code so that
it's actually usable by mere kernel developers :)

The main problem with the class code, is that _everyone_ gets it wrong
when trying to use it (and that includes me.)  So, because of that, the
class_simple wrapper was written.  So almost everyone used that.  That
pretty much proved that the class_simple interface was the proper type
of interface for the main class code itself.

Because of that, Kay wrote a first cut at adding the class_simple type
of interface to the class core (he posted it to lkml a month or so ago.)
I've finally taken that code, tweaked it a bit (fixing a module
ownership issue that sprang up due to the class core changes, and
changed the locking model) and added it to my bk-driver tree.  I've also
taken his tty and input patches that convert those subsystems over to
the new functions (it's pretty much a simple search and replace for
existing class_simple users.)

Then I moved the USB host controller code to use this new interface.
That was a bit more complex as it used the struct class and struct
class_device code directly.  As you can see by the patch, the result is
pretty much identical, and actually a bit smaller in the end.

So I'll be slowly converting the kernel over to using this new
interface, and when finished, I can get rid of the old class apis (or
actually, just make them static) so that no one can implement them
improperly again...

Comments?

Oh, I need to go add kernel-doc to the new functions, will do that
next...

thanks,

greg k-h
