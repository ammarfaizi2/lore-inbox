Return-Path: <linux-kernel-owner+w=401wt.eu-S933213AbWLaUpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933213AbWLaUpd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933218AbWLaUpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:45:32 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47643
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933213AbWLaUpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:45:32 -0500
Date: Sun, 31 Dec 2006 12:45:31 -0800 (PST)
Message-Id: <20061231.124531.125895122.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: wmb@firmworks.com, devel@laptop.org, linux-kernel@vger.kernel.org,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
References: <459714A6.4000406@firmworks.com>
	<Pine.LNX.4.61.0612311350060.32449@yvahk01.tjqt.qr>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sun, 31 Dec 2006 15:12:26 +0100 (MET)

> BUT, the eeprom utility may be used to modify values, and if used, I
> would like to see ofwfs show the updated value. openpromfs does it
> today:
> 
> 15:09 ares:/proc/openprom/options # cat oem-banner?
> false
> 15:09 ares:/proc/openprom/options # eeprom 'oem-banner?=true'
> 15:09 ares:/proc/openprom/options # cat oem-banner?
> true
> 
> (BTW, why does not openpromfs have it rw?)

It used to be able to :-)

When I changed sparc/sparc64 over to an in-memory copy of the
OFW tree, I wasn't able to retain writable property support
in openpromfs.  It just needs to be implemented and I never
found the desire nor time.

Happily, everyone uses 'eeprom' or some other program accessing
the tree via /dev/openprom to change values.

I'm incredibly surprised how much resistence there is from the
i386 OFW folks to do this right.  It would be like 80 lines of
code to suck the device tree into kernel memory, or if they don't
want to do that they can use inline function wrappers to provide
the clean C-language interface to all of this and the cost to
i386-OFW would be zero with the benefit that other platforms could
use the code potentially.

Doing the same thing 3 different ways, knowingly, is just very bad
engineering.  That is how you end up with a big fat pile of
unmaintainable poo instead of a clean maintainable source tree.  If we
fix a bug in one of these things, the other 2 are so different that if
the bug is in the others we'll never know and it's not easy to check
so people won't do it.

So please do this crap right.

Thanks.
