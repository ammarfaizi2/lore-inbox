Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265621AbUAJWri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAJWrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:47:37 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:53392
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265621AbUAJWrb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:47:31 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040110221402.GB17845@matchmail.com>
References: <Pine.LNX.4.44.0401102100180.5835-100000@poirot.grange>
	 <1073771855.3958.15.camel@nidelv.trondhjem.org>
	 <20040110221402.GB17845@matchmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073774846.3962.46.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 17:47:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 10/01/2004 klokka 17:14, skreiv Mike Fedyk:

> I have to admit, I haven't been following NFS on TCP very much.  Is the code
> in the stock 2.4 and 2.6 kernels ready for production use?  It seemed from
> what I read it was still experemental (and even marked as such in the
> config). 

The client code has been very heavily tested. It is not marked as
experimental.
The server code is marked as "officially experimental, but seems to work
well". You'll have to talk to Neil to find out what that means. In
practice, though, it performs at least as well as the UDP code.

If you are in a production environment and really don't want to trust
the TCP code, you can disable it, and use the option I mentioned earlier
of setting a low value of r/wsize.

Or better still: fix your network setup so that you don't lose all those
UDP fragments (check switches, NICs, drivers,...). The icmp time
exceeded error is a sign of a lossy network, NOT a broken NFS
implementation.

Trond
