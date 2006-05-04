Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWEDEGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWEDEGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 00:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWEDEGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 00:06:22 -0400
Received: from mf01.sitadelle.com ([212.94.174.68]:46984 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751071AbWEDEGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 00:06:21 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 8/13: eCryptfs] File operations
Date: Thu, 4 May 2006 06:06:27 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
References: <20060504031755.GA28257@hellewell.homeip.net> <20060504033949.GG28613@hellewell.homeip.net>
In-Reply-To: <20060504033949.GG28613@hellewell.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605040606.28385.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 05:39, Phillip Hellewell wrote:
> +struct file_operations ecryptfs_dir_fops = {
> +	.readdir = ecryptfs_readdir,
> +	.ioctl = ecryptfs_ioctl,
> +	.mmap = generic_file_mmap,
> +	.open = ecryptfs_open,
> +	.flush = ecryptfs_flush,
> +	.release = ecryptfs_release,
> +	.fsync = ecryptfs_fsync,
> +	.fasync = ecryptfs_fasync,
> +	.lock = ecryptfs_lock,
> +	.sendfile = ecryptfs_sendfile,
> +};
> +
> +struct file_operations ecryptfs_main_fops = {
> +	.llseek = ecryptfs_llseek,
> +	.read = ecryptfs_read_update_atime,
> +	.write = generic_file_write,
> +	.readdir = ecryptfs_readdir,
> +	.ioctl = ecryptfs_ioctl,
> +	.mmap = generic_file_mmap,
> +	.open = ecryptfs_open,
> +	.flush = ecryptfs_flush,
> +	.release = ecryptfs_release,
> +	.fsync = ecryptfs_fsync,
> +	.fasync = ecryptfs_fasync,
> +	.lock = ecryptfs_lock,
> +	.sendfile = ecryptfs_sendfile,
> +};

Current kernel has support for const file_operations, so new file systems 
should use a 'const' attribute for 'file_operation' declarations.
It helps avoiding false sharing on SMP.

Eric
