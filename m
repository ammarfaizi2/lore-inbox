Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSKBUdi>; Sat, 2 Nov 2002 15:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSKBUdi>; Sat, 2 Nov 2002 15:33:38 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:14835 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261406AbSKBUdg>; Sat, 2 Nov 2002 15:33:36 -0500
Message-ID: <7312677.1036269363155.JavaMail.nobody@web55.us.oracle.com>
Date: Sat, 2 Nov 2002 12:36:03 -0800 (PST)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: jt@hpl.hp.com, alessandro.suardi@oracle.com
Subject: Re: 2.5.42: IrDA issues
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 24, 2002 at 11:14:41AM +0200, Alessandro Suardi wrote:
> > Jean Tourrilhes wrote:

[snip]

> > 09:03:01.369859 xid:rsp 589c38b5 < bb700000 S=6 s=5 Nokia 6310 hint=b125 
> > [ PnP Modem Fax Telephony IrCOMM IrOBEX ] (27)
> > 09:03:01.382763 xid:cmd 589c38b5 > ffffffff S=6 s=* dolphin hint=0400 [ 
> > Computer ] (23)
> > 09:03:01.422691 snrm:cmd ca=fe pf=1 589c38b5 > bb700000 new-ca=66 (33)
> > 09:03:01.524835 ua:rsp ca=66 pf=1 589c38b5 < bb700000 (31)
> > 09:03:01.524997 rr:cmd > ca=66 pf=1 nr=0 (2)
> > 09:03:01.774694 rr:cmd > ca=66 pf=1 nr=0 (2)
> > 09:03:02.274609 rr:cmd > ca=66 pf=1 nr=0 (2)
> > 09:03:02.774533 rr:cmd > ca=66 pf=1 nr=0 (2)
> > --------------------------------------------------------
> > 
> > Then hangs (all this is with the 20021007 driver).
> > 
> > 
> > Hope it's helpful, ciao,
> > 
> > --alessandro
>      That's a speed problem (1152000 is MIR). You are supposed to
> select the proper module parameters to get speed changes to MIR/FIR to
> work properly (check IrDA mailing list messages from Daniele). Another
> solution is to limit the speed of the stack to 115200 (115k - see my
> web page for details).

OK... found finally time to re-test, I ran today the 10/30 smsc-ircc2 driver
 under RedHat 8.0, kernel 2.5.45 and the 115200 limit (after patching the
 few remaining uses of __FUNCTION__ in smsc-ircc.c), and the GPRS
 link stays up instead of going down after < 3 minutes. Speed is definitely
 slower (using the GPRS link) than the current 2.4.20-rc1 / smc-ircc combo
 but given the record of GPRS performance 'round here I do know it's not
 meaningful yet - I'll repost with irdadump logs if performance stays on the
 low end (my "fast" transfers peak at 3.9KB/s, the slowness of today's
 tests was about 0.2KB/s).

Under 2.5 I keep being spammed by

Nov  2 17:02:52 dolphin kernel: IrLAP, no activity on link!
Nov  2 17:03:37 dolphin last message repeated 2 times
Nov  2 17:04:52 dolphin last message repeated 8 times
Nov  2 17:05:58 dolphin last message repeated 5 times
Nov  2 17:07:03 dolphin last message repeated 10 times
Nov  2 17:08:08 dolphin last message repeated 4 times
Nov  2 17:09:11 dolphin last message repeated 6 times
Nov  2 17:10:28 dolphin last message repeated 5 times
Nov  2 17:12:37 dolphin last message repeated 8 times
Nov  2 17:13:43 dolphin last message repeated 3 times

while a substantially lower amount of spam under 2.4 tells me

Nov  2 21:28:31 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
Nov  2 21:28:31 dolphin kernel: irda0: transmit timed out
Nov  2 21:28:38 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
Nov  2 21:28:38 dolphin kernel: irda0: transmit timed out
Nov  2 21:29:05 dolphin kernel: NETDEV WATCHDOG: irda0: transmit timed out
Nov  2 21:29:05 dolphin kernel: irda0: transmit timed out


Thanks for now & ciao,

--alessandro
