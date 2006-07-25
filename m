Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWGYODk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWGYODk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWGYODk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:03:40 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:30598 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932136AbWGYODk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:03:40 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Tue, 25 Jul 2006 15:03:32 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: aia21@cantab.net, akpm@osdl.irg, linux-kernel@vger.kernel.org
Subject: Re: ntfs: remove unnecessary PG_uptodate check from ntfs_readpage
In-Reply-To: <Pine.LNX.4.58.0607251542570.2665@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0607251500480.2372@hermes-2.csi.cam.ac.uk>
References: <Pine.LNX.4.58.0607251542570.2665@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not apply this patch or you will see metadata corruption on 
NTFS.

Pekka, given there is a comment saying why this check is necessary, I 
really do not understand how you can claim that it is not...

Best regards,

	Anton

On Tue, 25 Jul 2006, Pekka J Enberg wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> The check is not needed because SetPageUptodate is called for locked pages
> and callers of ->readpage either explicitly check for PageUptodate or pass
> newly allocated pages (see read_cache_pages and page_cache_read).
> 
> Cc: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> 
>  fs/ntfs/aops.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> Index: 2.6/fs/ntfs/aops.c
> ===================================================================
> --- 2.6.orig/fs/ntfs/aops.c
> +++ 2.6/fs/ntfs/aops.c
> @@ -410,14 +410,6 @@ static int ntfs_readpage(struct file *fi
>  
>  retry_readpage:
>  	BUG_ON(!PageLocked(page));
> -	/*
> -	 * This can potentially happen because we clear PageUptodate() during
> -	 * ntfs_writepage() of MstProtected() attributes.
> -	 */
> -	if (PageUptodate(page)) {
> -		unlock_page(page);
> -		return 0;
> -	}
>  	vi = page->mapping->host;
>  	ni = NTFS_I(vi);
>  	/*
> 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
