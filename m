Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136137AbRECHJf>; Thu, 3 May 2001 03:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136138AbRECHJ1>; Thu, 3 May 2001 03:09:27 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28556 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136137AbRECHJL>;
	Thu, 3 May 2001 03:09:11 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15089.979.650927.634060@pizda.ninka.net>
Date: Thu, 3 May 2001 00:08:03 -0700 (PDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Geert Uytterhoeven writes:
 > Since you're not allowed to use direct memory dereferencing on ioremapped
 > areas, wouldn't it be more logical to let ioremap() return an unsigned long
 > instead of a void *?
 > 
 > Of course we then have to change readb() and friends to take a long as well,
 > but at least we'd get compiler warnings when someone tries to do a direct
 > dereference.

There is a school of thought which believes that:

struct xdev_regs {
	u32 reg1;
	u32 reg2;
};

	val = readl(&regs->reg2);

is cleaner than:

#define REG1 0x00
#define REG2 0x04

	val = readl(regs + REG2);

I'm personally ambivalent and believe that both cases should be allowed.

BTW, current {read,write}{b,w,l}() allow both pointer and unsigned
long arguments.  If your implementation isn't casting the port address
arg right now, perhaps you haven't tried to compile very many drivers
which use these interfaces or you're just ignoreing the warnings :-)

Later,
David S. Miller
davem@redhat.com
