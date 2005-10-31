Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVJaNhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVJaNhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 08:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVJaNhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 08:37:41 -0500
Received: from pcp09227423pcs.sanarb01.mi.comcast.net ([69.241.229.183]:55486
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S1751153AbVJaNhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 08:37:41 -0500
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
From: Trond Myklebust <trondmy@trondhjem.org>
To: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1130763105.8802.23.camel@lade.trondhjem.org>
References: <20051031173358.9566.patches@notabene>
	 <1051031063444.9586@suse.de>  <1130763105.8802.23.camel@lade.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Oct 2005 08:37:38 -0500
Message-Id: <1130765858.8802.36.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 07:51 -0500, Trond Myklebust wrote:
> This should normally be OK as far as NFS is concerned since we usually
> end up revalidating the attribute cache in the lookup() code, but you
> could imagine a networked filesystem that does not do this. I'd
> therefore prefer if such checks were made in the filesystem itself.

Actually, I'm wrong about this. ftruncate() doesn't do a
lookup/lookup_revalidate, so the current NFS code may end up using stale
attribute data.

Moving the checks to the VFS will just make that problem unfixable,
though.

Cheers,
  Trond
