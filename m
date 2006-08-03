Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWHCOj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWHCOj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWHCOjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:39:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10711 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932423AbWHCOjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:39:54 -0400
Date: Thu, 3 Aug 2006 15:39:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 06/28] reintroduce list of vfsmounts over superblock
Message-ID: <20060803143953.GD920@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	viro@ftp.linux.org.uk, herbert@13thfloor.at
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235244.964B79E7@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801235244.964B79E7@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:52:44PM -0700, Dave Hansen wrote:
> 
> We're moving a big chunk of the burden of keeping people from
> writing to r/o filesystems from the superblock into the
> vfsmount.  This requires that we consult the superblock's
> vfsmounts when things like remounts occur.
> 
> So, introduce a list of vfsmounts hanging off the superblock.
> We'll use this in a bit.

I don't think we'll need it.  We really need to keep is someone writing
to this vfsmount counters in addition to is someone writing to this sb.

In fact there are cases were we want a superblock to be writeable to
without any view into it being writeable, e.g. for journal recovery.

