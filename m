Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVBOCav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVBOCav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 21:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVBOCav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 21:30:51 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:42680 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261598AbVBOCaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 21:30:46 -0500
Date: Tue, 15 Feb 2005 13:26:18 +1100
From: Nathan Scott <nathans@sgi.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Repeatable hang with XFS under 2.6.11-rc4
Message-ID: <20050215022617.GB875@frodo>
References: <16913.21817.702372.962991@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16913.21817.702372.962991@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Feb 15, 2005 at 12:49:45PM +1100, Peter Chubb wrote:
> Running Reaim-7 on a 4G ram disk with 4 processors on
> Itanium... Every few runs, as the multiprocessing level increases, we
> see 22 processes hung in sync(), all except one waiting in
> sync_filesystems() and that one waiting in pagebuf_iowait().

That would indicate either XFS dropped the IO completion for a
metadata buffer, or the driver didn't pass it back to us.  Hard
to say which; is this with default mkfs options?  If so, try
using -ssize=4k at mkfs time, that'll get rid of some of the
more unusual IO patterns which XFS can send down.  Also try a
blocksize the same as the pagesize (16K there I would guess).
If the behaviour changes, these'll give us pointers and help
isolate where the problem is.

cheers.

-- 
Nathan
