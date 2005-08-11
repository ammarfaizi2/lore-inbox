Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbVHKOMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbVHKOMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 10:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbVHKOMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 10:12:54 -0400
Received: from pat.uio.no ([129.240.130.16]:60857 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750941AbVHKOMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 10:12:53 -0400
Subject: Re: fcntl(F GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
In-Reply-To: <1123769192.8251.75.camel@lade.trondhjem.org>
References: <1123764552.8251.43.camel@lade.trondhjem.org>
	 <994.1123766559@www9.gmx.net> <1123769192.8251.75.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 10:12:31 -0400
Message-Id: <1123769551.8251.80.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.459, required 12,
	autolearn=disabled, AWL 2.35, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 10:06 (-0400) skreiv Trond Myklebust:

> The NFSv4 spec explicitly states that
> 
>   When a client has a read open delegation, it may not make any changes
>   to the contents or attributes of the file but it is assured that no
>   other client may do so.  When a client has a write open delegation,
>   it may modify the file data since no other client will be accessing
>   the file's data.  The client holding a write delegation may only
>   affect file attributes which are intimately connected with the file
>   data:  size, time_modify, change.
> 
> so NFSv4 cannot currently support this behaviour. If CIFS supports it,
> then maybe we have a case for going to the IETF and asking for a
> clarification to implement the same behaviour in NFSv4.

Note: I'm not saying that this means we _must_ implement the current
behaviour in leases. If CIFS allows the server to hand out read oplocks
when the client opened the file with a write share, then NFSv4 can
simply deal with the difference in semantics by just never requesting a
read lease in that situation.
That said, if CIFS has the same semantics as NFSv4, then why allow the
aberrant case?

Cheers,
  Trond

