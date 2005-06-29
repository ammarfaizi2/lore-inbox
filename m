Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVF2R2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVF2R2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVF2R02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:26:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:53387 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261543AbVF2RWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 13:22:43 -0400
Date: Wed, 29 Jun 2005 18:22:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: Robert Love <rml@novell.com>, adi@hexapodia.org,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org,
       mtk-lists@gmx.net
Subject: Re: wrong madvise(MADV DONTNEED) semantic
Message-ID: <20050629172238.GA3356@mail.shareable.org>
References: <1119986623.6745.10.camel@betsy> <8493.1120063987@www35.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8493.1120063987@www35.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kerrisk wrote:
> For a MAP_SHARED region, the kernel may discard modified 
> pages, depending on the architecture.  (I seem to recall 
> getting this information about architecture variation from 
> an email conversation with Jamie Lokier; I haven't 
> verified it.  On x86 at least, I haven't seen an pages
> discarded for MADV_DONTNEED on a MAP_SHARED region.)  

The discard in MAP_SHARED case isn't explicit.  It's due to CPU cache
incoherency, so the data (or just some of the data) is lost simply by
not syncing properly between userspace and the page cache.

It wouldn't be apparent on fully-coherent architectures like x86.

That was when I last looked at the code (during the 2.5 time frame).
I didn't test it, only examined the code, but quite thoroughly.

-- Jamie
