Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUEQPzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUEQPzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUEQPzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:55:38 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:26498 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261746AbUEQPzM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:55:12 -0400
Subject: Re: 2.6.6 breaks kmail (nfs related?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Amann <amann@physik.tu-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405171331.35688.amann@physik.tu-berlin.de>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	 <Pine.LNX.4.58.0405161149430.25502@ppc970.osdl.org>
	 <1084734612.6331.8.camel@lade.trondhjem.org>
	 <200405171331.35688.amann@physik.tu-berlin.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084809309.3669.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 11:55:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 17/05/2004 klokka 07:31, skreiv Andreas Amann:
> fstat64(8, 0xbfffe650)                  = -1 ESTALE (Stale NFS file handle)
> _llseek(8, 0, [373], SEEK_END)          = 0
> write(8, "X\1\0\0", 4)                  = -1 ESTALE (Stale NFS file handle)
> write(8, "\5\0\0\0,\0\0a\0z\0/\0w\0t\0z\0t\0+\0N\0S\0+\0001\0s"..., 344) = -1 
> ESTALE (Stale NFS file handle)

That's wierd... Where could that be coming from? The client is *never*
supposed to generate that on its own. If an ESTALE turns up, it should
always be generated from the server.

Does that same ESTALE show up on a tcpdump/ethereal dump? If so, could
you please check that the filehandle that is contained from the reply to
LOOKUP(".outbox.index") is the same as that which is sent on the
offending GETATTR call?

Cheers,
  Trond
