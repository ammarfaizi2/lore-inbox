Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbTC0Qai>; Thu, 27 Mar 2003 11:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbTC0Qah>; Thu, 27 Mar 2003 11:30:37 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:27406
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S263283AbTC0Qag>; Thu, 27 Mar 2003 11:30:36 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33E08@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'root@chaos.analogic.com'" <root@chaos.analogic.com>
Cc: henrique.gobbi@cyclades.com, linux-kernel@vger.kernel.org
Subject: RE: Interpretation of termios flags on a serial driver
Date: Thu, 27 Mar 2003 08:41:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 5:41 PM, Richard B. Johnson wrote:
> 
> On Wed, 26 Mar 2003, Henrique Gobbi wrote:
> 
> > Thanks for the feedback.
> >
> > > If PARENB is set you generate parity. It is ODD parity if PARODD
> > > is set, otherwise it's EVEN. There is no provision to generate
> > > "stick parity" even though most UARTS will do that. When you
> > > generate parity, you can also ignore parity on received data if
> > > you want.  This is the IGNPAR flag.
> >
> > Ok. But, considering the 2 states of the flag IGNPAR, what 
> should the
> > driver do with the chars that are receiveid with wrong 
> parity, send this
> > data to the TTY with the flag TTY_PARITY or just discard this data ?
> >
> > regards
> > Henrique
> >
> 
> 
> If the IGNPAR flag is true, you keep the data. You pretend it's
> okay. Ignore parity means just that. Ignore it. You do not flag
> it in any way. This is essential. If you have a 7-bit link and
> somebody is sending you stick-parity, you can still use the data.
> 
Hi Richard,

Right idea, wrong flag.  ;-)

IGNPAR = 1  discard received data with parity errors. (ignore data)
INPCK = 0   deliver data with parity errors, as is.   (ignore error)

See 2.4/drivers/char/n_tty.c:~500

Cheers,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
