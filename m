Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268457AbTBSNNo>; Wed, 19 Feb 2003 08:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268461AbTBSNNo>; Wed, 19 Feb 2003 08:13:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44683
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268457AbTBSNNn>; Wed, 19 Feb 2003 08:13:43 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045647562.12533.1.camel@zion.wanadoo.fr>
References: <E18lC5R-00067P-00@the-village.bc.nu>
	 <20030218230910.A27653@flint.arm.linux.org.uk>
	 <1045619583.25795.11.camel@irongate.swansea.linux.org.uk>
	 <1045647562.12533.1.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045664739.27427.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 14:25:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 09:39, Benjamin Herrenschmidt wrote:
> Hrm... I tend to agree with Russell here... 0x7f is the "safe" value
> for IDE. IDE controllers with nothing wired shall have a pull down
> on D7. The reason is simple: busy loops in the IDE code waiting for
> BSY to go down.
> 
> Now, if your point is to keep BSY up and have wait loops timeout,
> then 0xff may actually make some sense ;)

0xFF is what happens with a real hot unplug so we must handle it
irrespective of convenience. Your probe loop might want to check
some kind of 'dead' variable when this is all done I guess. That
way we can have

	unplugged_event()
	{
		change iops
		drive->dead = 1;
	}

and the probe code can spot ->dead in the poll loop

