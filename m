Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWBCRJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWBCRJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWBCRJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:09:47 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:15020 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S1751246AbWBCRJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:09:46 -0500
Message-ID: <43E38E00.301@aarnet.edu.au>
Date: Sat, 04 Feb 2006 03:38:16 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australia's Academic & Research Network
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk> <43E36850.5030900@aarnet.edu.au> <20060203160218.GA27452@flint.arm.linux.org.uk>
In-Reply-To: <20060203160218.GA27452@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -104.901 BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

> My point stands - if the user can provide an arbitary string to printk,
> they can fake any kernel message.  That in itself is a security bug.
> If there is an instance of that, then that's the real bug which would
> need fixing.
> 
> Once those bugs have been fixed, your claimed bug is also magically
> fixed.

Hi Russell,

Thanks for the explanation of where the kernel should handle
covert channels.

How about the other bugs reported by people who have used
the Remote-Serial-Console-HOWTO:

   - writing any text to an idle (DCD not asserted) modem still
     causes incoming calls to be hung up on.  That's not good
     as sysadmins can't connect to systems with failing hardware.

     [Note that modems really need the 'r' option, so it's
      fine to continue to write with DCD unasserted without
      the 'r' option.]

   - the huge boot times with the 'r' option and an idle/
     unconnected modem/terminal server.  This is caused by
     the CTS timing out per character even when CTS is
     floating (CTS is not defined unless DSR is asserted).
     This basically makes the 'r' option impossible to
     use on production systems.  Not using the 'r' option
     with a terminal server brings other problems (notably
     character loss problems when people paste a large
     number of characters into the SSH session through
     the terminal server to the remote host).

   - writing LF CR rather than CR LF unfortunately causes
     issues with some terminals.

I'm really only the messenger here.  I've collected bug reports
from readers of the HOWTO and written a patch to address their
experiences.  I'm sure people with much more familiarity with
the kernel can do it better.

Thanks,
Glen

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Australia's Academic & Research Network  www.aarnet.edu.au
