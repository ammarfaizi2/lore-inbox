Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVERPch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVERPch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVERPcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:32:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44518 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262299AbVERPAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:00:54 -0400
Date: Wed, 18 May 2005 16:00:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Carsten Otte <cotte@freenet.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 2/5] mm/fs: execute in place (V2)
Message-ID: <20050518150053.GA24389@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Carsten Otte <cotte@freenet.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, schwidefsky@de.ibm.com,
	akpm@osdl.org
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424413.2202.17.camel@cotte.boeblingen.de.ibm.com> <20050518142707.GA23162@infradead.org> <428B57AA.2030006@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B57AA.2030006@freenet.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 04:56:42PM +0200, Carsten Otte wrote:
> I do plainly agree that this would make the code more readable here.
> But it has a significant downside:
> Once you have a different set of file operations for either case, you
> also need to have a different file_operations struct in each individual
> filesystem using this. Also, this moves the check "do we have xip today?"
> from here to the filesystem that needs to decide which file operations
> struct to use.
> Looking forward, there may be multiple filesystems using this which
> leads to duplicating the need for this check.

I don't think that's much of a problem.  The filesystem has a new file_operations
instance and decided at read_inode time which one to use.  You already have different
address_space operations and a different truncate anyway.

