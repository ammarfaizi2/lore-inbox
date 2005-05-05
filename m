Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVEEQQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVEEQQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVEEQQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:16:46 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:34822 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262146AbVEEQQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:16:29 -0400
Date: Thu, 5 May 2005 18:16:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 fails to read partition table
Message-ID: <20050505161610.GA4604@pclin040.win.tue.nl>
References: <055UDZ711@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055UDZ711@server5.heliogroup.fr>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 02:37:54PM +0000, Hubert Tonneau wrote:

> 2.6.11 and 2.6.11.7 work fine.
> 2.6.12-rc1 2.6.12-rc2 and 2.6.12-rc3 fail to read partiton table on my laptop,
> also 2.6.12-rc3 works fine on another box also running FullPliant.
> 
> The partition table has been created by Pliant partition tool:
> http://fullpliant.org/pliant/linux/storage/partition.pli
> function 'partition_create' at line 52.

[Heve been away for a while, sorry for a slow reaction]

Yes. I see you create partitions using

ph type := (shunt fs="ext2" or fs="xfs" 83h fs="swap" 82h fs="raid" 0FDh 0)

and it looks like the final 0 is the culprit here.
Earlier Linux disregarded partition types, today 0 means "unused".

Andries
