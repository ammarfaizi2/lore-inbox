Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268776AbUILSmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268776AbUILSmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268778AbUILSmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:42:06 -0400
Received: from outbound01.telus.net ([199.185.220.220]:8853 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S268776AbUILSkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:40:51 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <alan@lxorguk.ukuu.org.uk>
Cc: <peter@mysql.com>, <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified)Denial of Service Attack
Date: Sun, 12 Sep 2004 12:40:56 -0600
Message-ID: <002501c498f8$0a4ebc20$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <02b201c498f6$8bb92540$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

 My inetd is not the old one, it is in Slackware 10.0..
apparently 1.79s, still works here. (the s added by
The slackware group according to the readme:

/*      $Slackware: inetd.c 1.79s 2001/02/06 13:18:00 volkerdi Exp $    */
/*      $OpenBSD: inetd.c,v 1.79 2001/01/30 08:30:57 deraadt Exp $      */ 
/*      $NetBSD: inetd.c,v 1.11 1996/02/22 11:14:41 mycroft Exp $       */
/* 

It still dies pretty fast :( Willy is probably right, in that
the bug is application level in this case. Can you explain
though, how it is appropriate to have no timeout on CLOSE_WAIT.
Lets assume (such as the case with the mysql bug), that it is
created, and for some reason never addressed.. The end case being
mysql reporting "Too many Connections". That would make me assume
these connections are still "alive" (perhaps I am assuming wrong?)
and could still cause issues with other services, if the volume of
them was to get too high.

It still seems prudent to me to have some kind of timeout (2 hours,
or something?) to have it expuldge the connection, because obviously,
it isn't going to voluntarily close.

This bug also exists with Apache, the default config of SSH,
and anything controlled by inetd. This is the vast majority of
popular services on a regular internet server.. That is bad, no?

D.

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
> Sent: Sunday, September 12, 2004 11:17 AM
> To: Willy Tarreau
> Cc: Wolfpaw - Dale Corse; peter@mysql.com; Linux Kernel 
> Mailing List; netdev@oss.sgi.com
> Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and 
> REMOTE(verified)Denial of Service Attack
> 
> 
> On Sul, 2004-09-12 at 18:59, Willy Tarreau wrote:
> > The problem is within inetd. In my case it could be because it was a
> > bit old (1999), but since you have it too,
> 
> Ancient inetd had several fd leak bugs fixed over time and 
> some other problems with built in services. Not much of a 
> suprise that a 1999 inetd has it.
> 
> Alan
> 
> 
> --------------------------------------------------------------
> --------------
> -
> This message has been scanned for Spam and Viruses by ClamAV 
> and SpamAssassin
> --------------------------------------------------------------
> --------------
> -
> 
> 
> 
> 
> 

