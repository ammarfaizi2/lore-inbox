Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271320AbRHTQPn>; Mon, 20 Aug 2001 12:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271321AbRHTQPd>; Mon, 20 Aug 2001 12:15:33 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:24733 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S271320AbRHTQPV>; Mon, 20 Aug 2001 12:15:21 -0400
Date: Mon, 20 Aug 2001 10:15:38 -0600
Message-Id: <200108201615.f7KGFcD01007@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Donald Thompson <dlt@dataventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stallion EasyIO and devfs
In-Reply-To: <Pine.LNX.4.31.0108200124160.11127-100000@dv1.dataventures.com>
In-Reply-To: <200108122123.f7CLNDK03327@mobilix.ras.ucalgary.ca>
	<Pine.LNX.4.31.0108200124160.11127-100000@dv1.dataventures.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Thompson writes:
> devfsd and the compatability links work correctly as of 2.4.8 with the
> patch you provided.
> 
> This is quite possibly user error and not a kernel issue, but it seems
> pppd 2.4.1 breaks once I've got the stallion card under devfsd with
> compatability links.
> 
> mgetty runs on device lets say, /dev/ttyE2 (symlink to /dev/ttyE/2), and
> passes off incoming connections to pppd. I'm expecting pppd is gonna want
> to look at /etc/ppp/options.ttyE2, but its not.
> 
> If I change stallion.c at around line 145 from:
> static char     *stl_serialname = "ttyE/%d";
> 
> To:
> static char     *stl_serialname = "ttyE%d";
> 
> so that the real device becomes /dev/ttyE2 rather than a symlink to
> /dev/ttyE/2 pppd starts looking at the correct options file.

The recent versions of devfsd expect the Stallion devices to have the
name tts/E%d, so this suggests that you are running a virgin
kernel. So grab devfs-patch-v187 and devfsd-v1.3.17 (or later) and try
again. If you still have problems, run strace and analyse the result.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
