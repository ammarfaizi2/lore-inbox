Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271748AbTHDNs0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271753AbTHDNs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:48:26 -0400
Received: from angband.namesys.com ([212.16.7.85]:32408 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S271748AbTHDNsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:48:24 -0400
Date: Mon, 4 Aug 2003 17:48:22 +0400
From: Oleg Drokin <green@namesys.com>
To: Martin Pitt <martin@piware.de>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030804134822.GF3911@namesys.com>
References: <20030803102321.GA428@donald.balu5> <20030804075420.GB4396@namesys.com> <20030804084306.GB15110@donald.balu5> <20030804091703.GC3911@namesys.com> <20030804101310.GA1187@donald.balu5> <20030804101628.GD3911@namesys.com> <20030804132207.GA29529@donald.balu5>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804132207.GA29529@donald.balu5>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Aug 04, 2003 at 03:22:11PM +0200, Martin Pitt wrote:
> > Yeah, sure.
> I did that. I will send you the screenshot per private mail for not
> cluttering up the mailing list.

Ok, got it.
reiserfsck hanged for unknown reason.
This is not on your root partition, but rather on /dev/hda6

> > > > can you press sysrq-T at the time of a hang and then send us the traces?
> > > That's even more difficult, it produces several screenfulls of text
> > > scrolling away very fast. I'd need a serial console for this purpose
> > > but it will last a while to set this up since I don't have the
> > > necessary hardware here. I could do it tomorrow.
> > Well, as I understand, you first press sysrq-T, then ^C, then thing boots and you can
> > colled sysrq-t output from dmesg or boot logs.
> It does not work that way. Both with 2.4.x and 2.6.0-test2, after
> pressing sysrq-something you can only choose actions from the menu (i.
> e. eventually reboot). Every key press is interpreted as magic key
> menu selection, I do not even have to hold down alt+sysrq to choose
> 's'ync, 'b'oot and so on. There is no such thing as "e'x'it from this
> menu". This may be regarded as another bug.

Hm, I heard of such cases and usually this is because some key(un)press events got lost.
How about pressing Ctrl key and Alt key separately which should let you out of this mode
hopefully.

Also What if you'd unmount /dev/hda6 after you booted and try to run
/sbin/reiserfsck -a /dev/hda6, will it hang in this case?
If so, you might be able to get stacktrace (with sysrq-t) from that point too.
Also look if reiserfsck eats cpu or behaves strangely in some other manner when hanging,
and if so, we may need a metadata snapshot of your /dev/hda6 device
( you can obtain one with debugreiserfs -p /dev/hda6 | bzip2 -9c >metadata.bz2)

Bye,
    Oleg
