Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWBUXcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWBUXcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBUXcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:32:46 -0500
Received: from pat.uio.no ([129.240.130.16]:30969 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750770AbWBUXcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:32:45 -0500
Subject: Re: FMODE_EXEC or alike?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060221232607.GS22042@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru>
	 <20060220215122.7aa8bbe5.akpm@osdl.org>
	 <1140530396.7864.63.camel@lade.trondhjem.org>
	 <20060221232607.GS22042@fieldses.org>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 18:32:31 -0500
Message-Id: <1140564751.8088.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.725, required 12,
	autolearn=disabled, AWL 1.27, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 18:26 -0500, J. Bruce Fields wrote:
> On Tue, Feb 21, 2006 at 08:59:56AM -0500, Trond Myklebust wrote:
> > Hmm.... We might possibly want to use that for NFSv4 at some point in
> > order to deny write access to the file to other clients while it is in
> > use.
> 
> So on the NFS client, an open with FMODE_EXEC could be translated into
> an NFSv4 open with a deny_write bit (since NFSv4 opens also do windows
> share locks).
> 
> An NFSv4 server might also be able to translate deny mode writes into
> FMODE_EXEC in the case where it was exporting a cluster filesystem.  It
> wouldn't completely solve the problem of implementing cluster-coherent
> share locks (which also let you deny reads, who knows why), but it seems
> like it would address the case most likely to matter.

Hmm... I don't think you want to overload write deny bits onto
FMODE_EXEC. FMODE_EXEC is basically, a read-only mode, so it
would mean that you could no longer do something like

  OPEN(READ|WRITE,DENY_WRITE) 

which I would assume is one of the more frequent Windoze open modes.

Cheers,
  Trond

