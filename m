Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271389AbTHRLVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271394AbTHRLVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:21:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59656 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S271389AbTHRLVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:21:04 -0400
Date: Mon, 18 Aug 2003 12:21:01 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030818122101.C31111@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <135601c36495$85e507b0$1aee4ca5@DIAMONDLX60> <20030817143313.A22402@flint.arm.linux.org.uk> <151901c36577$12b6f680$1aee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <151901c36577$12b6f680$1aee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Mon, Aug 18, 2003 at 07:41:34PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 07:41:34PM +0900, Norman Diamond wrote:
> "Russell King" <rmk@arm.linux.org.uk> replied to me:
> > Not quite.  This is an old problem dating back several years to early 2.4
> > times.  Back in the dark old days, ide-cs used to use the name "ide_cs" to
> > bind the driver to the device.  It now uses "ide-cs" for binding.
> 
> Yes the problem is reminiscent of early 2.4 days, but how is it that 2.4.19
> doesn't have the problem and 2.6.0-test3 does have the problem on the same
> machine?

In 2.6.0-test3:

linux/drivers/ide/legacy/ide-cs.c:

	static dev_info_t dev_info = "ide-cs";

In 2.4.21:

linux/drivers/ide/legacy/ide-cs.c

	static dev_info_t dev_info = "ide-cs";

The pcmcia-cs package may have ide-cs called ide_cs though.

> > Make sure that "ide_cs" isn't mentioned in /etc/pcmcia/config - if it
> > is, change it to "ide-cs".
> 
> I will hope to have time to check this next weekend, but I'm sure the 2.4
> name ide-cs is used.  I was startled to see 2.6.0-test3 load a module named
> ide_cs instead of ide-cs, but there it was.  It was listed that way by
> lsmod, but failing in the bind as shown above.  Notice that modprobe used
> the same name as lsmod showed.

The output of lsmod can be confusing.  '-' is replaced by '_' in the
module name.  This doesn't affect module binding, loading or unloading.
You can still rmmod ide-cs even if it's called ide_cs.

In either case, this is what should be in /etc/pcmcia/config:

device "ide-cs"
  class "ide" module "ide-cs"

pcmcia-cs 3.1.24 ships with:

device "ide_cs"
  class "ide" module "ide_cs"

which is wrong for the kernels ide-cs implementation.

The first line contains the device name, and is also the name used to
bind the driver to the device.  (this is referenced by the "bind"
statements in the "card" sections.)  The second line contains the
module name(s) to load.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

