Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTKTSon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTKTSom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:44:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6042 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262827AbTKTSol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:44:41 -0500
Date: Thu, 20 Nov 2003 18:44:40 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org, mochel@osdl.org,
       dipankar@in.ibm.com
Subject: Re: [PATCH] sysfs_remove_dir Vs dcache_readdir race fix
Message-ID: <20031120184439.GF24159@parcelfarce.linux.theplanet.co.uk>
References: <20031120054707.GA1724@in.ibm.com> <20031120054957.GD24159@parcelfarce.linux.theplanet.co.uk> <20031120055655.GB1724@in.ibm.com> <20031120102525.GD1367@in.ibm.com> <20031120071709.0acf35aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120071709.0acf35aa.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 20, 2003 at 07:17:09AM -0800, Andrew Morton wrote:

> Seems to me that the libfs code is fragile.
> 
> What happens if the dentry at filp->f_private_data gets moved to a
> different directory after someone did dcache_dir_open()?  Does the loop
> in dcache_readdir() go infinite again?

Can't happen - it's not hashed and not attached to any inode.  IOW, there's
no way to find that animal, let alone pass it to d_move().
