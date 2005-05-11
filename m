Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVEKPJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEKPJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVEKPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:09:57 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51121 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261247AbVEKPJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:09:25 -0400
Date: Wed, 11 May 2005 16:09:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: cotte@freenet.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: add execute in place support
Message-ID: <20050511150924.GA29976@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, cotte@freenet.de,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	schwidefsky@de.ibm.com, akpm@osdl.org
References: <428216F7.30303@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428216F7.30303@de.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 04:30:15PM +0200, Carsten Otte wrote:
> [RFC/PATCH 2/5] mm/fs: add execute in place support
> This patch is the biggest chunk in the patchset. It adds a new address
> space operation called get_xip_page, which works similar to
> readpage/writepage but returns a reference to a struct page for the
> on-disk data for the given page. The page is supposed to be up-to-date.
> In mm/filemap.c, all generic implementations of file operations are
> extended to work with the new address space operation if provided.

This is a lot of code for a very special case.

Could you try to put all the xip code into a separate file, e.g. mm/xip.c
that's only built when CONFIG_XIP is set?  It would probably require
duplicating a little more code if you want clean interfaces, e.g. probably
a separate set of generic operations.

