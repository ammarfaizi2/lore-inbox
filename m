Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTHVCnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 22:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262993AbTHVCnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 22:43:11 -0400
Received: from imap.gmx.net ([213.165.64.20]:54961 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262992AbTHVCnJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 22:43:09 -0400
Message-ID: <3F45830A.5C0F5BCA@gmx.de>
Date: Fri, 22 Aug 2003 04:42:18 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: "Bill J.Xu" <xujz@neusoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: "ctrl+c" disabled!
References: <036601c367e0$01adabc0$2a01010a@avwindows>
	 <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill J.Xu" wrote:
> 
> The following is the stty' result, I think it's right
> ----------------------------------------------------------------------------------
> bash-2.05# stty -a
> speed 9600 baud; rows 0; columns 0; line = 0;
> intr = ^C; quit = ^\; erase = ^?; kill = ^X; eof = ^D; eol = <undef>;
> eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
> lnext = ^V; flush = ^U; min = 1; time = 0;
> -parenb -parodd cs8 hupcl -cstopb cread clocal -crtscts
> -ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
> -iuclc ixany -imaxbel
> opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
> isig icanon -iexten echo -echoe -echok -echonl -noflsh -xcase -tostop echoprt
> echoctl echoke
> ----------------------------------------------------------------------------------
> but  ^C is bad

Hmm... looks fine.  intr set to ^C and isig enabled.  Maybe you should check what
the terminal program is actually sending:

  od -tx1

Then type Ctrl-C Ctrl-D.  Should print "00000000 03".

How do you kill the process from telnet?  kill -9 <pid> or kill -2 <pid>?
Maybe sigint is ignored (possible if bash was started with ignored sigint -
broken/strange getty).  Is job control (^Z/fg) working?

Ciao, ET.
