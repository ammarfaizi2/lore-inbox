Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314697AbSD1XLB>; Sun, 28 Apr 2002 19:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314700AbSD1XLB>; Sun, 28 Apr 2002 19:11:01 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:32423 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314697AbSD1XLA>;
	Sun, 28 Apr 2002 19:11:00 -0400
Date: Mon, 29 Apr 2002 09:07:07 +1000
From: Anton Blanchard <anton@samba.org>
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcnet32 on 2.4.18 doesn't init on IBM rs/6000 B50 (powerpc)
Message-ID: <20020428230707.GG17500@krispykreme>
In-Reply-To: <20020425220402.GA3654@man.beta.es> <20020425221519.GA13245@krispykreme> <20020428153253.GA2924@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> It fixes indeed the problem on the init of the card, but I have made a
> deeper diagnosis of the problem and there are things left.

Good, at least one bug is fixed :)

> I have even got it to work with 2.4.18 without any patch. The problems
> appear just when you do a netboot of the machine, if you just boot from the
> disk 2.4.18 does ok. But if you boot from the net you get the problem with
> detection on 2.4.18 which is solved on 2.4.19 pres, but also you get another
> problem with the card, and it is that communication doesn't work like it
> should, this problem is not corrected on 2.4.19preX as of pre7 at least.

Can you send me the version of OF you are using? You should be able to get
it off the bootup splash screen or by doing lsprop /proc/device-tree/openprom.
Do you get any errors in dmesg when the card stuffs up?

> This problems as I said before are caused when booting from the net and not
> when the machine is booted from disk. It looks like the card is left on a
> bad state by the openfirmware, in fact I've seen openfirmware fail several
> times to retrieve big kernel files (more than 1 MB) and afterwards even fail
> to do a bootp request, so I think that the card is left on a bad state that
> drives as to things like this one:

One thing to watch out for with the RS/6000 OF is that it wont reply
to ARP messages during a TFTP load. If you are trying to load a
big image you need to arp -s <hostname> <hw_addr>.

Anton
