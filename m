Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRGKSUH>; Wed, 11 Jul 2001 14:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRGKST5>; Wed, 11 Jul 2001 14:19:57 -0400
Received: from dryline-fw.yyz.somanetworks.com ([216.126.67.45]:19042 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S264375AbRGKSTu>; Wed, 11 Jul 2001 14:19:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15180.39107.179401.666431@somanetworks.com>
Date: Wed, 11 Jul 2001 14:19:47 -0400
From: "Georg Nikodym" <georgn@somanetworks.com>
To: "Richard Purdie" <rpurdie@bigfoot.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
In-Reply-To: <00c101c10a33$8a024920$0301a8c0@rpnet.com>
In-Reply-To: <00c101c10a33$8a024920$0301a8c0@rpnet.com>
X-Mailer: VM 6.90 under 21.2  (beta44) "Thalia" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "RP" == Richard Purdie <rpurdie@bigfoot.com> writes:

 >> > I'm trying to get Linux to work with an Alcatel Speedtouch ADSL
 >> > USB
 RP> modem.
 >> > By executing the following script after boot up I get the BUG
 >> > message
 RP> after
 >> > running pppd.
 >>
 >> Have you tried asking the author of the speedtouch driver about
 >> this?

 RP> I've sent him a copy of the bug report I submitted here. I'm
 RP> still unsure of where the problem lies. My machine is being
 RP> unpredictable even when the driver hasn't been loaded.

The BUG() invocation is a result of invalid flags being passed to
kmem_cache_grow().

The numeric values associated with things like GFP_ATOMIC changed in
2.4.6.  Your problem is likely related to the use of modules built on
something other than the kernel you're running.

(I know this because I spent entirely too long debugging somebody's
code yesterday that thought it was a good idea to have his own copies
of the definitions of GFP_ATOMIC, et al.)
