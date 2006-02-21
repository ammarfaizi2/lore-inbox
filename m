Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWBUOUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWBUOUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWBUOUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:20:45 -0500
Received: from linuxhacker.ru ([217.76.32.60]:7357 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S932259AbWBUOUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:20:45 -0500
Date: Tue, 21 Feb 2006 16:21:59 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Antonio Vargas <windenntw@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060221142159.GI5733@linuxhacker.ru>
References: <20060220221948.GC5733@linuxhacker.ru> <20060220215122.7aa8bbe5.akpm@osdl.org> <1140530396.7864.63.camel@lade.trondhjem.org> <69304d110602210615m491829ccx9ba84edc8dafe1f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69304d110602210615m491829ccx9ba84edc8dafe1f7@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Feb 21, 2006 at 03:15:53PM +0100, Antonio Vargas wrote:
> > > We would need to understand whether this is needed by other distributed
> > > filesystems and if so, whether the proposed implementation is suitable and
> > > sufficient.
> > Hmm.... We might possibly want to use that for NFSv4 at some point in
> > order to deny write access to the file to other clients while it is in
> > use.
> When done with regards to failing a write if anyone has mapped the
> file for executing it, or failing the execute if it's open/mmaped for
> write, I can't really see the difference between local, remote and
> clustered filesystems...

Currently this is only possible locally, when both execution and opening
for writing is performed on the same node. Then VFS enforces ETXTBSY.
But if you do exec on one node and open for writing on another,
VFSes on those nodes have no idea on what happens on all other nodes.

Bye,
    Oleg
