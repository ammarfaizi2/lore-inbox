Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276132AbRJaX4o>; Wed, 31 Oct 2001 18:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276231AbRJaX4e>; Wed, 31 Oct 2001 18:56:34 -0500
Received: from [63.231.122.81] ([63.231.122.81]:28720 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S276132AbRJaX4W>;
	Wed, 31 Oct 2001 18:56:22 -0500
Date: Wed, 31 Oct 2001 16:56:09 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: linux-kernel@vger.kernel.org,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>, J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011031165609.T16554@lynx.no>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	vda <vda@port.imtp.ilyichevsk.odessa.ua>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, J Sloan <jjs@lexus.com>
In-Reply-To: <7DFB419183D@vcnet.vc.cvut.cz> <Pine.LNX.4.30.0110312341150.30534-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.30.0110312341150.30534-100000@gans.physik3.uni-rostock.de>; from tim@physik3.uni-rostock.de on Wed, Oct 31, 2001 at 11:58:03PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 31, 2001  23:58 +0100, Tim Schmielau wrote:
> Next step would be to decide what to do with the start_time field of
> struct task_struct, which is still 32 bit and stores seconds times HZ.
> Other uses for 64 bit jiffies might be identified as well.

I would say that (excluding stability issues because of jiffies wrap)
that this is ready for submission to Linus.  He may be of the mind that
he would rather fix the wrap issues sooner rather than later, or he
may want to minimize disruption during the "VM stabilize" period (there
are still a couple of hang issues apparently).

> +u64 get_jiffies64(void)
> +{
> +	static unsigned long jiffies_hi = 0;
> +	static unsigned long jiffies_last = INITIAL_JIFFIES;
> +	static unsigned long jiffies_tmp;
        ^^^^^^ jiffies_tmp doesn't need to be static.

One suggestion someone had was to put dummy "get_jiffies64()" calls
in some other infrequently used areas to ensure jiffies_hi is valid
if we don't call uptime for 1.3 years after the first wrap.  I don't
know if that matters or not.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

