Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283724AbRLNV1H>; Fri, 14 Dec 2001 16:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285506AbRLNV07>; Fri, 14 Dec 2001 16:26:59 -0500
Received: from fmr01.intel.com ([192.55.52.18]:17136 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S283724AbRLNV0m>;
	Fri, 14 Dec 2001 16:26:42 -0500
Message-ID: <C8C7DD4157F2D411AC7000A0C96B1522016C37D4@fmsmsx58.fm.intel.com>
From: "Sottek, Matthew J" <matthew.j.sottek@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: zap_page_range in a module
Date: Fri, 14 Dec 2001 13:26:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  I have a driver memory mapping issue that I'm unsure how to
handle. Basically I've written a i810 framebuffer driver that uses
only stolen memory modes (Mostly for embedded customers). This driver
currently can only work when compiled into the kernel because I need 
zap_page_rage(). Is there an acceptable way for me to get equivalent
functionality in a module so that this will be more useful to the
general public?

Some backup info:
The "stolen memory" is the 1mb that the bios takes from the system
before OS load. The i810 maps this in 64k banks to 0xa0000. I can
use any video modes <1MB in size by accessing the memory via these
64k banks and swapping banks when needed.

For the fb driver I allow memory mapping of a 1MB area on the fb device
file and install a zero_page fault handler. When a page is faulted I
map the 64k region that contains the page the client needs with
remap_page_range() and switch the memory bank. I then need to drop
any old 64k ranges so that I will get another zero_page fault when
they are accessed. This way the client see's 1MB linear memory and
I bank flip behind the scenes.

So I'm using zap_page_range() to drop the pages for the "old" memory
bank. This, of course, is not exported to modules. Is there some
existing way to get this functionality in a module? is there any
chance to export zap_page_range()?

please cc this address in replies

 -Matt

