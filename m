Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269781AbUJGJ7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269781AbUJGJ7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269780AbUJGJ7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:59:47 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:55215 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269781AbUJGJ4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:56:25 -0400
Message-ID: <029301c4ac5c$553c7250$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: "David S. Miller" <davem@davemloft.net>,
       "Olivier Galibert" <galibert@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
References: <20041006193053.GC4523@pclin040.win.tue.nl><003301c4abdc$c043f350$b83147ab@amer.cisco.com><20041006200608.GA29180@dspnet.fr.eu.org><20041006163521.2ae12e6d.davem@davemloft.net><20041007001937.GA48516@dspnet.fr.eu.org> <20041006172959.47c25e3d.davem@davemloft.net>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 11:56:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Sent: Thursday, October 07, 2004 01:29

> On Thu, 7 Oct 2004 02:19:37 +0200
> Olivier Galibert <galibert@pobox.com> wrote:
> 
> > On Wed, Oct 06, 2004 at 04:35:21PM -0700, David S. Miller wrote:
> > > On Wed, 6 Oct 2004 22:06:08 +0200
> > > Olivier Galibert <galibert@pobox.com> wrote:
> > > 
> > > > On Wed, Oct 06, 2004 at 12:43:27PM -0700, Hua Zhong wrote:
> > > > > How hard is it to treat the next read to the fd as NON_BLOCKING, even if
> > > > > it's not set?
> > > > 
> > > > Programs don't expect EAGAIN from blocking sockets.
> > > 
> > > That's right, which is why we block instead.
> > 
> > Programs don't expect a read to block after a positive select either,
> > so it doesn't really help.
> 
> It absolutely does help the programs not using select(), using
> blocking sockets, and not expecting -EAGAIN.

Both returning EAGAIN and blocking are not POSIX compliant. Returning EIO
from blocking sockets is an option. Another option would be to have select()
check the data so that when it returns it can guarantee available data. This would
not affect performance of recvmsg() without using select().


--ms


