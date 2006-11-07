Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWKGVUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWKGVUP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbWKGVUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:20:14 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:12429 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750929AbWKGVUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:20:13 -0500
Date: Tue, 7 Nov 2006 14:20:12 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Jeff Layton <jlayton@redhat.com>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>, Eric Sandeen <sandeen@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107212012.GC27140@parisc-linux.org>
References: <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <20061107174217.GA29746@wohnheim.fh-wedel.de> <20061107175601.GB29746@wohnheim.fh-wedel.de> <1162928464.28425.59.camel@dantu.rdu.redhat.com> <20061107204135.GF29746@wohnheim.fh-wedel.de> <1162933980.28425.64.camel@dantu.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162933980.28425.64.camel@dantu.rdu.redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 04:13:00PM -0500, Jeff Layton wrote:
> +	/* ino must not collide with any ino assigned in the loop below. Set
> +	   it to the highest possible inode number */
> +	inode->i_ino = (1 << (sizeof(s->s_lastino) * 8)) - 1;

This really isn't a good idiom to be using; GCC now takes this to mean
"I can reformat your hard drive because you did something outside the
spec".

Try instead:
+	inode->i_ino = -1;

