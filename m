Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVHKOGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVHKOGs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHKOGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:06:48 -0400
Received: from pat.uio.no ([129.240.130.16]:55474 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750719AbVHKOGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:06:47 -0400
Subject: Re: fcntl(F GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
In-Reply-To: <994.1123766559@www9.gmx.net>
References: <1123764552.8251.43.camel@lade.trondhjem.org>
	 <994.1123766559@www9.gmx.net>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 10:06:31 -0400
Message-Id: <1123769192.8251.75.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.552, required 12,
	autolearn=disabled, AWL 2.26, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 15:22 (+0200) skreiv Michael Kerrisk:

> As noted already, I don't know much of CIFS and SAMBA.
> But are you saying that it is sensible and consistent that
> "a process can open a file read-write, and can't place a 
> read lease, but can place a write lease"?  

It is just as "sensible and consistent" as being able to open the file
read-write and being able to place a read lease but not a write lease.
What is your point?

Make no mistake: this is not a locking protocol. It is implementing
support for a _caching_ protocol.

> This is precisely the point of the problem.  Stephen 
> Rothwell, and Matthew Wilcox seem to be saying that
> the last bit is not the case.  

The NFSv4 spec explicitly states that

  When a client has a read open delegation, it may not make any changes
  to the contents or attributes of the file but it is assured that no
  other client may do so.  When a client has a write open delegation,
  it may modify the file data since no other client will be accessing
  the file's data.  The client holding a write delegation may only
  affect file attributes which are intimately connected with the file
  data:  size, time_modify, change.

so NFSv4 cannot currently support this behaviour. If CIFS supports it,
then maybe we have a case for going to the IETF and asking for a
clarification to implement the same behaviour in NFSv4.

Cheers,
  Trond

