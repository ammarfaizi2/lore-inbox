Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbTGNLN7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbTGNLN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:13:59 -0400
Received: from usti.fccps.cz ([194.108.74.250]:3070 "EHLO usti.fccps.cz")
	by vger.kernel.org with ESMTP id S266004AbTGNLNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:13:55 -0400
Message-ID: <002a01c349fc$23a0e8c0$ec00000a@fccps.cz>
From: "=?iso-8859-1?B?RnJhbnRpc2VrIFJ5c+FuZWs=?=" <rysanek@fccps.cz>
To: <marcelo@conectiva.com.br>
Cc: "Francois Romieu" <romieu@fr.zoreil.com>, <henrique2.gobbi@cyclades.com>,
       <linux-kernel@vger.kernel.org>
References: <20030711212551.A25528@electric-eye.fr.zoreil.com>
Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
Date: Mon, 14 Jul 2003 13:36:15 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mr. Tosatti,

I've been asked by Mr. Francois Romieu, the author of
drivers/net/wan/dscc4.c,
to give you a summary of my user-space experience with recent versions
of dscc4.c and the Generic HDLC Layer (drivers/net/wan/hdlc_*.c, hdlc.o).

The message is: it works, to the extent that it can be configured and
TCP/IP works. I've tried DSCC4 hardware back-to-back and against
a Cisco, in a few different configurations. I've tried the three basic
encapsulations: cisco-hdlc, itu-hdlc and sync ppp.
I don't know enough FR and X.25 to be able to come up with a workable
setup (didn't even try).

I was using linux 2.4.21-rc1 and 2.4.21 (release). This works, but that
version of dscc4.c suffers from a hardware quirk in the DSCC4 hardware
- the port/link cannot be reconfigured without a cold reboot.
The effects of this quirk are alleviated by a patch to dscc4.c that has been
submitted by F.Romieu for approval to the linux kernel and that reportedly
has made i to the -ac series, but not to the vanilla 2.4.21.
I have not touched the sources of the Generic HDLC Layer (hdlc*.c) that is
present in 2.4.21-rc1 to 2.4.21. I was using the vanilla source without
modification. I don't know about any differences in the hdlc*.c in the -ac
series - I didn't investigate that flavor.

As for the userspace sethdlc.c by Krzystof Halasa: I was using ver.1.12,
modified by Mr. Romieu, who has "cut some non-compiling functionality."
The current version from Krzysztof Halasa is 1.15.

I barely had the time to test basic workability and document my test bench.
Unfortunately I did not do any stress/long-term/feature-crosscompatibility
testing.
Specifically, I was using uniprocessor machines only (no SMP).
I did not test all the features available in the Generic HDLC Layer, I don't
even
fully understand all the technologies covered - I was only interested in
basic
point-to-point IP over sync serial.

I've written a short mini-HOWTO - the chapter on test results in terms of
transfer rates and ping round trips is at
http://sweb.cz/Frantisek.Rysanek/sync/dscc4+HDLC-Mini-HOWTO.html#Drivers.ope
n.tests

I hope that I was not completely wasting your time :-)
If you have further questions, ask me.
Thanks for the great job that you're doing.

Sincerely yours

Frank Rysanek



----- Original Message -----
From: "Francois Romieu" <romieu@fr.zoreil.com>
To: "Frantisek Rysánek" <rysanek@fccps.cz>
Sent: Friday, July 11, 2003 9:25 PM
Subject: [marcelo@conectiva.com.br: Re: Why is generic hldc beig ignored?
RE:Linux 2.4.22-pre4]


> Imho l-k is waiting for a summary of your experiences with post
> 2.4.21-pre linux hdlc.
>
> Btw latest dscc4 updates are available in Alan Cox's -ac series.
>
> ----- Forwarded message from Marcelo Tosatti
<marcelo@conectiva.com.br> -----
>
> From: Marcelo Tosatti <marcelo@conectiva.com.br>
> Date: Fri, 11 Jul 2003 14:18:10 -0300 (BRT)
> Subject: Re: Why is generic hldc beig ignored?   RE:Linux 2.4.22-pre4
> X-X-Sender: marcelo@freak.distro.conectiva
> To: Henrique Oliveira <henrique2.gobbi@cyclades.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
>    Kevin Curtis <kevin.curtis@farsite.co.uk>,
>    lkml <linux-kernel@vger.kernel.org>
> References: <7C078C66B7752B438B88E11E5E20E72E25C978@GENERAL.farsite.co.uk>
>  <Pine.LNX.4.55L.0307101410570.25103@freak.distro.conectiva>
>  <003101c34712$a9b8f480$602fa8c0@henrique>
<1057914760.8028.27.camel@dhcp22.swansea.linux.org.uk>
>  <013901c347cd$44586f60$602fa8c0@henrique>
> X-Spam-Status: No, hits=-28.7 required=4.0
> tests=EMAIL_ATTRIBUTION,IN_REP_TO,REFERENCES,REPLY_WITH_QUOTES,
>       USER_AGENT_PINE,X_MAILING_LIST
> version=2.53-fr_1
> X-Spam-Level:
> X-Spam-Checker-Version: SpamAssassin 2.53-fr_1 (1.174.2.15-2003-03-30-exp)
>
>
>
> On Fri, 11 Jul 2003, Henrique Oliveira wrote:
>
> > Hello !!!
> > No offence here but the generic hdlc layer's been always confusing. I
will
> > write here what I believe is going on.
> > Until version 2.4.20 we had the old hdlc layer, with only one source
file
> > hdlc.c. People that wanted to use the new hdlc layer had to apply a
patch
> > provided by Halasa or by the WAN cards vendors. The kernel 2.4.21 came
out
> > with the new hdlc layer, that includes a couple of files:
hdlc_generic.c,
> > hdlc_fr.c, hdlc_ppp.c, hdlc_raw.c, etc. I don't know the status of
the -ac
> > tree but I can say that the kernel 2.4.21 has the new code.
> > The new hdlc layer really needs new tools. This new tool can
(supposedly) be
> > found at Halasa's web site. I don't know if someone has tested these
tools
> > but I am about to run a test this afternoon. If someone is interested on
the
> > results, just drop me a line.
>
> I am.
>
> Please report the results of your tests and CC lkml.
>
> And Alan, what the -ac tree hdlc changes are about ?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> ----- End forwarded message -----

