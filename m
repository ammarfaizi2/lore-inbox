Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262701AbTCMV60>; Thu, 13 Mar 2003 16:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262736AbTCMV60>; Thu, 13 Mar 2003 16:58:26 -0500
Received: from mail.zmailer.org ([62.240.94.4]:14827 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S262701AbTCMV6V>;
	Thu, 13 Mar 2003 16:58:21 -0500
Date: Fri, 14 Mar 2003 00:09:05 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rob Ekl <lkhelp@rekl.yi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sendfile, loopback, and TCP header checksum
Message-ID: <20030313220905.GK29167@mea-ext.zmailer.org>
References: <Pine.LNX.4.53.0303131510060.10653@rekl.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0303131510060.10653@rekl.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 03:32:58PM -0600, Rob Ekl wrote:
> Hi.  I'm working on a program that uses sendfile() to copy a file to a TCP
> socket.  I did some testing where the server and client processes were on
> the same machine.  While watching ethereal's packet dumps, I noticed the
> packets that sendfile() creates are reported to have incorrect checksums.  
> Other packets from the same program (ie created by write() or writev() )
> have the correct checksum.

  copy(-and-checksum) is needed for write*(), and during copying,
  the checksumming can be thrown in essentially for free.

  For sendfile(), the system does not need to do such copying,
  and these days devices can be reported as capable to handle
  e.g. tcp checksumming built in.

  Loopback device does not bother with checksums -- it is coming
  from within the box, no point in checking such things.
  ( see:  drivers/net/loopback.c   -- there are most curious set
    of initialized   dev->features  flags. )

...
> This leads me to the conclusion that using sendfile() on a loopback
> interface over a TCP connection generates packets with incorrect checksums
> in the TCP headers.
> 
> I do not know if ethereal is falsely reporting that the checksums are 
> incorrect, but it's a very limited scope of the source of packets with 
> incorrect checksums (only sendfile-generated to loopback).

  It may well be correct report, but to calculate those would be
  wasted effort.

> Is this something that even needs to be addressed, since the receiver
> would discard the packet if the checksum is incorrect, but since it's over
> loopback, there's no chance of receiving data corrupted by the transport
> medium and loopback ignores the checksum?

  Quite so.

> System information:  2.4.20 on both machines, ia32 CPUs, ethereal 0.9.10 
> with libpcap 0.7.

/Matti Aarnio
