Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWBUX0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWBUX0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWBUX0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:26:20 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39898 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750961AbWBUX0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:26:20 -0500
Date: Tue, 21 Feb 2006 18:26:07 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, Oleg Drokin <green@linuxhacker.ru>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: FMODE_EXEC or alike?
Message-ID: <20060221232607.GS22042@fieldses.org>
References: <20060220221948.GC5733@linuxhacker.ru> <20060220215122.7aa8bbe5.akpm@osdl.org> <1140530396.7864.63.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140530396.7864.63.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 08:59:56AM -0500, Trond Myklebust wrote:
> Hmm.... We might possibly want to use that for NFSv4 at some point in
> order to deny write access to the file to other clients while it is in
> use.

So on the NFS client, an open with FMODE_EXEC could be translated into
an NFSv4 open with a deny_write bit (since NFSv4 opens also do windows
share locks).

An NFSv4 server might also be able to translate deny mode writes into
FMODE_EXEC in the case where it was exporting a cluster filesystem.  It
wouldn't completely solve the problem of implementing cluster-coherent
share locks (which also let you deny reads, who knows why), but it seems
like it would address the case most likely to matter.

--b.
