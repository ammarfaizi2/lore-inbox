Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVCNAyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVCNAyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVCNAyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:54:18 -0500
Received: from nevyn.them.org ([66.93.172.17]:61102 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261614AbVCNAyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:54:15 -0500
Date: Sun, 13 Mar 2005 19:54:13 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
Message-ID: <20050314005413.GA17711@nevyn.them.org>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU> <1110690267.24123.7.camel@lade.trondhjem.org> <20050313200412.GA21521@nevyn.them.org> <1110746550.23876.8.camel@lade.trondhjem.org> <20050314003512.GA16875@nevyn.them.org> <1110761410.30085.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110761410.30085.13.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 07:50:09PM -0500, Trond Myklebust wrote:
> Sorry, but you should _never_ have gotten an ESTALE error if the file
> was not in use when you deleted the old copy of glibc. A fresh call to
> open() will always result in a new lookup of the filehandle.
> What may have happened in the case of the EIO error is that you may have
> raced: i.e. a client starts reading the file while it is being copied
> to.

It is in a separate root filesystem, currently not used by anything on
the target.  It is likely to be in cache, but I can absolutely
guarantee it isn't open.  Hmm, server is x86_64 2.6.7, client is 2.6.10
MIPS.  I should upgrade them and see if that helps.

Unfortunately I haven't found any smaller testcases than installing an
entire root FS.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
