Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVEJRCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVEJRCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 13:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbVEJRCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 13:02:09 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60569 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261708AbVEJRBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 13:01:30 -0400
Date: Tue, 10 May 2005 18:01:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Xavier Roche <roche+kml2@exalead.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [XFS] Kernel (2.6.11) deadlock in user mode when writing data through mmap on large files (64-bit systems)
Message-ID: <20050510170129.GA1320@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org
References: <427F6310.9020709@exalead.com> <4280D292.2030509@exalead.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4280D292.2030509@exalead.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a known problem, or rather two of them:

 1) when dirtying lots of memory via mmap writeout happens pretty randmomly
    inside the file and the filesystem has problems creating nice clusters.
    In the case of extent based filesystems that's really bad as the extent
    map is fragmented now
 2) XFS keeps each inode's extent map in one single memory block.

You're seeing allocation errors where we are trying to realloc that memory
block.

Could you try the patches that Nikita posted to -mm that should improve
this behaviour?
