Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135551AbRDXRSf>; Tue, 24 Apr 2001 13:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135549AbRDXRSZ>; Tue, 24 Apr 2001 13:18:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27149 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135540AbRDXRSP>; Tue, 24 Apr 2001 13:18:15 -0400
Subject: Re: [OFFTOPIC] Re: [PATCH] Single user linux
To: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)
Date: Tue, 24 Apr 2001 18:16:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, cat@zip.com.au (CaT),
        viro@math.psu.edu (Alexander Viro),
        mhaque@haque.net (Mohammad A. Haque),
        ttel5535@artax.karlin.mff.cuni.cz,
        mharris@opensourceadvocate.org (Mike A. Harris),
        linux-kernel@vger.kernel.org
In-Reply-To: <200104241702.MAA00717@tomcat.admin.navo.hpc.mil> from "Jesse Pollard" at Apr 24, 2001 12:02:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14s6Qr-0002VW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And get_mail must have elevated privileges to search for the users mail...
> or sendmail must have already switched user on reciept to put it in the
> users inbox which also requires privleges...

No. Think instead of blindly following existing implementation

	socket(AF_UNIX, SOCK_STREAM, 0);
	connect("/var/run/mailservice");
	write("GIMMEMYMAIL\n");
	read("200 CATCH..");
	read(all my mail)

The daemon needs no priviledge. The client needs no priviledge. The 
PEERCRED authentication on AF_UNIX sockets does the work. I can even pass you
back the file handle of the mailbox if I was using an old style non database
indexed mail spool.

> It's much more efficent to process each mail as it arrives.

You are doing a lot more exec() calls that way. If you get enough mail
to make spool space an issue you want a daemon.

Alan


