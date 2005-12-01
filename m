Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVLAMv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLAMv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbVLAMv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:51:58 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:11976 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932202AbVLAMv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:51:57 -0500
Date: Thu, 1 Dec 2005 13:52:06 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Takashi Sato <sho@bsd.tnes.nec.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: stat64 for over 2TB file returned invalid st_blocks
Message-ID: <20051201125206.GB24519@wohnheim.fh-wedel.de>
References: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01e901c5f66e$d4551b70$4168010a@bsd.tnes.nec.co.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 December 2005 21:00:26 +0900, Takashi Sato wrote:
> 
> diff -uprN -X linux-2.6.14.org/Documentation/dontdiff linux-2.6.14.or
> g/include/asm-i386/stat.h linux-2.6.14-blocks/include/asm-i386/stat.h
> --- linux-2.6.14.org/include/asm-i386/stat.h 2005-10-28 09:02:08.000000000 
> +0900
> +++ linux-2.6.14-blocks/include/asm-i386/stat.h 2005-11-18 
> 22:42:37.000000000 +0900
> @@ -58,8 +58,7 @@ struct stat64 {
>  long long st_size;
>  unsigned long st_blksize;
> 
> - unsigned long st_blocks; /* Number 512-byte blocks allocated. */
> - unsigned long __pad4;  /* future possible st_blocks high bits */
> + unsigned long long st_blocks; /* Number 512-byte blocks allocated. */

After a closer look: have you tested this on a big-endian machine as
well?  This heavily smells like it will work one one endianness only.

Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell
