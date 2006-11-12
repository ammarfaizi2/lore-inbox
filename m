Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755106AbWKLNXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbWKLNXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755108AbWKLNXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:23:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31495 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755106AbWKLNXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:23:07 -0500
Date: Sun, 12 Nov 2006 14:23:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: include/linux/nfsd/nfsfh.h: NULL dereference
Message-ID: <20061112132310.GJ25057@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following:

<--  snip  -->

...
static __inline__ struct svc_fh *
fh_copy(struct svc_fh *dst, struct svc_fh *src)
{
        if (src->fh_dentry || src->fh_locked) {
                struct dentry *dentry = src->fh_dentry;
                printk(KERN_ERR "fh_copy: copying %s/%s, already verified!\n",
                        dentry->d_parent->d_name.name, dentry->d_name.name);
        }
                        
        *dst = *src;
        return dst;
}
...

<--  snip  -->

src->fh_dentry is being dereferenced when we discover it's NULL...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

