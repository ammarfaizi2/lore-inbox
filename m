Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVH3OIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVH3OIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVH3OIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:08:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932123AbVH3OIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:08:42 -0400
Subject: Re: [PATCH] Ext3 online resizing locking issue
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Glauber de Oliveira Costa <gocosta@br.ibm.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       ext2resize-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20050825204335.GA1674@br.ibm.com>
References: <20050824210325.GK23782@br.ibm.com>
	 <1124996561.1884.212.camel@sisko.sctweedie.blueyonder.co.uk>
	 <20050825204335.GA1674@br.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1125410818.1910.52.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 30 Aug 2005 15:06:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-08-25 at 21:43, Glauber de Oliveira Costa wrote:

> Just a question here. With s_lock held by the remount code, we're
> altering the struct super_block, and believing we're safe. We try to
> acquire it inside the resize functions, because we're trying to modify 
> this same data. Thus, if we rely on another lock, aren't we probably 
> messing  up something ?

The two different uses of the superblock lock are really quite
different; I don't see any particular problem with using two different
locks for the two different things.  Mount and the namespace code are
not locking the same thing --- the fact that the resize code uses the
superblock lock is really a historical side-effect of the fact that we
used to use the same overloaded superblock lock in the ext2/ext3 block
allocation layers to guard bitmap access.

--Stephen

