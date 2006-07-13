Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWGML74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWGML74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWGML74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:59:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750921AbWGML7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:59:55 -0400
Subject: Re: [patch] ext3: remove btree_dir
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Qi Yong <qiyong@fc-cn.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060713080538.GA20259@localhost.localdomain>
References: <20060713080538.GA20259@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 12:59:25 +0100
Message-Id: <1152791965.5208.9.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2006-07-13 at 16:05 +0800, Qi Yong wrote:
> Remove support for EXT3_FEATURE_RO_COMPAT_BTREE_DIR, so mount can
> safely fail out when some new feature added using 0x0004. 

I think this is a bad idea.

It's not safe to reuse this existing feature bit: if we do, then any
existing 2.6 kernel prior to the change will mistakenly think that it
understands that feature for read-write, and will therefore be likely to
corrupt data.  And we are not remotely short of feature bits, so there's
no pressure to free up existing bits.

Removing the flag from the tree will remove what is essentially
documentation that this flag cannot be reused.

Cheers,
 Stephen


