Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWF1Pup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWF1Pup (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932847AbWF1Pup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:50:45 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:6083 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932555AbWF1Puo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:50:44 -0400
Date: Wed, 28 Jun 2006 17:50:48 +0200
From: Johann Lombardi <johann.lombardi@bull.net>
To: sho@tnes.nec.co.jp
Cc: adilger@clusterfs.com, cmm@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] ext3: enlarge blocksize and fix rec_len overflow
Message-ID: <20060628155048.GG2893@chiva>
References: <20060628205238sho@rifu.tnes.nec.co.jp>
MIME-Version: 1.0
In-Reply-To: <20060628205238sho@rifu.tnes.nec.co.jp>
User-Agent: Mutt/1.5.11+cvs20060403
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/06/2006 17:54:45,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/06/2006 17:54:46,
	Serialize complete at 28/06/2006 17:54:46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

> ext2/ext3_dir_entry_2 has a 16-bit entry(rec_len) and it would overflow
> with 64KB blocksize.  This patch prevent from overflow by limiting
> rec_len to 65532.

In empty_dir(), offset is incremented by de->rec_len until it reaches
inode->i_size. I think bad things will happen with a 64kB blocksize since
the records no longer span the entire directory block.

AFAICS, there's a similar issue with bh->b_size in ext3_delete_entry().

Cheers,

Johann
