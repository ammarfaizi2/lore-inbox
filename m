Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVHaLbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVHaLbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVHaLbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:31:14 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:49597 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S932415AbVHaLbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:31:13 -0400
Date: Wed, 31 Aug 2005 08:35:06 -0300
From: Glauber de Oliveira Costa <gocosta@br.ibm.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Glauber de Oliveira Costa <gocosta@br.ibm.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       ext2resize-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] Ext3 online resizing locking issue
Message-ID: <20050831113506.GM23782@br.ibm.com>
References: <20050824210325.GK23782@br.ibm.com> <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk> <20050825204335.GA1674@br.ibm.com> <1125410818.1910.52.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125410818.1910.52.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The two different uses of the superblock lock are really quite
> different; I don't see any particular problem with using two different
> locks for the two different things.  Mount and the namespace code are
> not locking the same thing --- the fact that the resize code uses the
> superblock lock is really a historical side-effect of the fact that we
> used to use the same overloaded superblock lock in the ext2/ext3 block
> allocation layers to guard bitmap access.
> 
> 
At a first look, i thought about locking gdt-related data. But in a
closer one, it seemed to me that we're in fact modifying a little bit
more than that in the resize code. But all these modifications seem to
be somehow related to the ext3 super block specific data in
ext3_sb_info. My first naive approach would be adding a lock to that
struct

Besides that, by doing that, we become pretty much independent of vfs
locking decisions to handle ext3 data. Do you think it all make sense?



-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
gocosta@br.ibm.com
=====================================
