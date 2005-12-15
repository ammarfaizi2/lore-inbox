Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVLOOcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVLOOcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVLOOcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:32:06 -0500
Received: from free.hands.com ([83.142.228.128]:32898 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1750706AbVLOOcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:32:05 -0500
Date: Thu, 15 Dec 2005 14:31:24 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: ordering of suspend/resume for devices.  any clues, anyone?
Message-ID: <20051215143124.GD14978@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[hi, please kindly cc me direct as i am deliberately subscribed with
settings to not receive posts from this list, but if that is inconvenient
for you to cc me, don't worry i can always look up the archives
to keep track of replies, thank you.]

http://handhelds.org/moin/moin.cgi/BlueAngel

works.

am seeking some advice regarding power management - specifically
the ordering of devices "resume" functions being called.

we have an LCD, and an ATI chip.  switching on the LCD powers up
the ATI chip.

unfortunately, resume calls the ATI device initialisation
_before_ the LCD resume initialisation.  the ATI chip's
initialisation fails - naturally - because it's not even
powered up.

of course - this can't be taken care of in userspace as an apm
event because the framebuffer device cannot be a module [without
terminating all running x-applications].

so.

possible solutions, as i see them:

1) have some awfulness in the LCD driver and the ATI driver with some
shared resume initialisation callbacks.

2) work out where the initialisation of the LCD driver is called
from, and somehow get that inserted into the initialisation order
in the reverse way from what it is now, such that the linked list
of device drivers is inverted, such that the resume event will
end up calling the LCD resume _after_ the ATI resume.

3) some lovely "dependency" work gets done in the linux kernel
where you can register priorities on the resume order.

this would mirror the way that the old apm "event.d" thing
would have worked.

4) other - that i don't know about, but would love to hear from
someone if there already exists a solution.

any clues, anyone?

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
