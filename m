Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264790AbUEPTKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264790AbUEPTKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 15:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbUEPTKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 15:10:19 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:14730 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264790AbUEPTKP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 15:10:15 -0400
Subject: Re: 2.6.6 breaks kmail (nfs related?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Amann <amann@physik.tu-berlin.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405161149430.25502@ppc970.osdl.org>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	 <Pine.LNX.4.58.0405152142400.25502@ppc970.osdl.org>
	 <1084730382.3764.7.camel@lade.trondhjem.org>
	 <1084731015.3764.10.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0405161115000.25502@ppc970.osdl.org>
	 <1084733234.3764.30.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0405161149430.25502@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1084734612.6331.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 16 May 2004 15:10:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 16/05/2004 klokka 14:50, skreiv Linus Torvalds:
> Agreed. But the kmail message is apparently "(No space left on device?)", 
> which may be just kmail itself reacting to a truncated write rather than 
> any actual ENOSPC error.  A "strace" would help clarify exactly what goes 
> wrong..

Right...

One possible suspect might be open(O_EXCL) since, AFAICS, Andreas is
using maildir-style mailboxes. Perhaps that SETATTR call in
nfs3_proc_create() is failing? We recently fixed so that it always sets
MTIME/ATIME...

Andreas: when you do the "strace" could you first run

echo "16" >/proc/sys/sunrpc/nfs_debug

and then record the output from "dmesg" immediately after the kmail
crash?

Cheers,
  Trond
