Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVJRRRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVJRRRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 13:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJRRRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 13:17:00 -0400
Received: from p54B055E8.dip.t-dialin.net ([84.176.85.232]:57082 "EHLO
	ccc-offenbach.org") by vger.kernel.org with ESMTP id S1750870AbVJRRRA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 13:17:00 -0400
Date: Tue, 18 Oct 2005 19:16:45 +0200
From: Rudolf Polzer <debian-ne@durchnull.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051018171645.GA59028%atfield-dt@durchnull.de>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m37jcakhsm.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsis, quam aut quem »Krzysztof Halasa« appellare soleo:
> Horms <horms@verge.net.au> writes:
> 
> >> Then log out and let root login (in a computer pool, you can usually get
> >> an admin to log on as root on a console somehow). The next time he'll
> >> press TAB to complete a file name, he instead will run the shell
> >> command.
> 
> Why doesn't the intruder just simulate login process (printing "login: "
> and "Password:")? That's known and used for ages.
> 
> The root user (and any other user) should press the SAK key before
> attempting login. It should a) reset terminal to a sane state,
> b) terminate and/or disconnect all processes from current tty.

That does not help against the loadkeys issue if the attacking user is still
logged in on another virtual console. Even when tty1 is active, a user owning
tty6 can use loadkeys.

Plus, the Linux SAK does not reset the keyboard mapping. And SAK does not reset
the video mode, so when pressed on X, the terminal video mode is garbled until
reboot (maybe it works fine with some framebuffer drivers, but with the stock
VGA text console, it doesn't). X comes back up fine, but when pressing
Ctrl-Alt-F1, X will restore the video mode it saw on startup - which is the
mode of the previous X server the SAK has killed.

> Alternatively, he/she should hw-reset/power-cycle the terminal,
> if possible (say, with serial/X-terminal).

Well, sometimes you have problems that powercycling would "hide" so you can't
track them down if you powercycle the whole computer every time.

> OTOH I don't know why ordinary users should be allowed to change key
> bindings.

For using foreign languages and keyboard mappings.

But for that a suid wrapper around loadkeys would suffice - most distributions
include more than enough keyboard mapping files already.

> BTW: Not sure about Linux consoles, but in general ESCape sequences
> can redefine key bindings as well. That's why SAK/reset is so important.

If man console_codes is correct, they can't.
