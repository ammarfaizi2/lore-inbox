Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbVAFVnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbVAFVnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVAFVlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:41:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48651 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263017AbVAFVk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:40:56 -0500
Date: Thu, 6 Jan 2005 22:40:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jaharkes@cs.cmu.edu, coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org
Subject: 2.6: fs/coda/dir.c: coda_hasmknod seems to be buggy
Message-ID: <20050106214053.GA28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function coda_mknod in fs/coda/dir.c (I checked 2.6.10-mm2) stats with:

<--  snip  -->

...
static int coda_mknod(struct inode *dir, struct dentry *de, int mode, dev_t rdev)
{
        int error=0;
        const char *name=de->d_name.name;
        int length=de->d_name.len;
        struct inode *inode;
        struct CodaFid newfid;
        struct coda_vattr attrs;

        if ( coda_hasmknod == 0 )
                return -EIO;

<more code>
...

<--  snip  -->


The problem is that not a single place in the kernel assigns any value 
to coda_hasmknod.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

