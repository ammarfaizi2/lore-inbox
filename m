Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWBVXcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWBVXcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWBVXcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:32:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:9196 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1751487AbWBVXb6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:31:58 -0500
Date: Wed, 22 Feb 2006 18:31:52 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060222233152.GF11556@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru> <20060220215122.7aa8bbe5.akpm@osdl.org> <1140530396.7864.63.camel@lade.trondhjem.org> <20060221232607.GS22042@fieldses.org> <1140564751.8088.35.camel@lade.trondhjem.org> <20060222195721.GC28219@fieldses.org> <1140644216.7879.7.camel@lade.trondhjem.org> <20060222220435.GJ28219@fieldses.org> <1140646653.7879.25.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140646653.7879.25.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 05:17:33PM -0500, Trond Myklebust wrote:
> I understand FMODE_EXEC to mean that we want to call
> deny_write_access(). OTOH, FMODE_WRITE is supposed to trigger an
> automatic call to get_write_access().

Ugh.  OK, well that makes FMODE_EXEC useless for the server, then.

It'd be nice to be able to give the server some way of enforcing the
deny bits.  Otherwise, though translating FMODE_EXEC to DENY_WRITE will
at least allow the nfs server to deny writes by other clients, it'll
still do nothing to protect against writers on the exported filesystem
(even local writers--nevermind the cluster case).

And an open flag is attractive since it gives at least some hope that we
might be able to do DENY_WRITE atomically with the open.  Samba
apparently just does the open and then tries to get a mandatory lock
afterwards, but that seems racy.

--b.
