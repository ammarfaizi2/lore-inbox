Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWHKWaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWHKWaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWHKWaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 18:30:10 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:4745 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751166AbWHKWaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 18:30:09 -0400
Subject: Re: [Ext2-devel] [PATCH] fix ext3 mounts at 16T
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Eric Sandeen <esandeen@redhat.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <44DD00FA.5060600@redhat.com>
References: <44DD00FA.5060600@redhat.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 11 Aug 2006 15:29:54 -0700
Message-Id: <1155335394.3765.20.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 17:13 -0500, Eric Sandeen wrote:
> I figure before we get too fired up about 48 bits and ext4 let's fix 32 bits on ext3 :)
> 
> I need to do some actual IO testing now, but this gets things mounting for a 16T ext3 filesystem.
> (patched up e2fsprogs is needed too, I'll send that off the kernel list)
> 
> This patch fixes these issues in the kernel:
> 
> o sbi->s_groups_count overflows in ext3_fill_super()
> 
> 	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
> 			       le32_to_cpu(es->s_first_data_block) +
> 			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
> 			      EXT3_BLOCKS_PER_GROUP(sb);
> 
> at 16T, s_blocks_count is already maxed out; adding EXT3_BLOCKS_PER_GROUP(sb) overflows it and 
> groups_count comes out to 0.  Not really what we want, and causes a failed mount.
> 
> Feel free to check my math (actually, please do!), but changing it this way should work & 
> avoid the overflow:
> 
> (A + B - 1)/B changed to: ((A - 1)/B) + 1
> 
> o ext3_check_descriptors() overflows range checks

Looks correct to me.:)

Mingming

