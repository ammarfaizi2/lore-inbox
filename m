Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292700AbSCMIO4>; Wed, 13 Mar 2002 03:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292705AbSCMIOq>; Wed, 13 Mar 2002 03:14:46 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:35786 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S292700AbSCMIO3>; Wed, 13 Mar 2002 03:14:29 -0500
Date: Wed, 13 Mar 2002 09:14:22 +0100
From: bert hubert <ahu@ds9a.nl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: ide filters / 'ide dump' / 'bio dump'
Message-ID: <20020313091422.A23422@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <E16kcTV-0002ar-00@the-village.bc.nu> <3C8D6CA4.8060604@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8D6CA4.8060604@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Mar 12, 2002 at 02:51:07AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 02:51:07AM +0000, Jeff Garzik wrote:

> The current implementation needs to be changed anyway :)  From "ATA raw 
> command" to "device raw command" at the very least.

Regarding proposed ATA filtering, this touches somewhat on something I've
been thinking about for a while: biodump.

Basically, biodump is to a block device what tcpdump is to a network
adaptor.

So we would be able to do this:

# biodump /dev/hda
09:09:33.023 READ block 12345 [10 blocks]
09:09:33.024 READ block 12355 [10 blocks]
09:09:33.025 READ block 12365 [10 blocks]
09:09:34.000 WRITE block 12345 [1 block]

Or somewhat more fancy, and only useful for non-growing files:

# biodump /var/db/bigdb/tablefile
file on /dev/hda, getting blockmap:
09:09:33.023 READ logical block 12345 [10 blocks]
09:09:33.024 READ logical block 12355 [10 blocks]
09:09:33.025 READ logical block 12365 [10 blocks]
09:09:34.000 WRITE logical block 12345 [1 block]

Because right now, we have no idea why that disk light is blinking. If
somebody implements a filter, it would be a natural place to also provide
a dumping hook.

biodump might in fact turn out to become atadump and scsidump (which is
rather sad actually).

regards,


bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
