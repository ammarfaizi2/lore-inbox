Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267107AbTBXOGE>; Mon, 24 Feb 2003 09:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTBXOGE>; Mon, 24 Feb 2003 09:06:04 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:27658 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267107AbTBXOGD>; Mon, 24 Feb 2003 09:06:03 -0500
Date: Mon, 24 Feb 2003 14:16:13 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (6/21) FS & partiton
Message-ID: <20030224141613.A6064@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030223092116.GA1324@yuzuki.cinet.co.jp> <20030223094325.GG1324@yuzuki.cinet.co.jp> <20030223102937.A15963@infradead.org> <3E58A63F.9090607@cinet.co.jp> <20030224140539.GB1115@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224140539.GB1115@yuzuki.cinet.co.jp>; from tomita@cinet.co.jp on Mon, Feb 24, 2003 at 11:05:39PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 11:05:39PM +0900, Osamu Tomita wrote:
> --- linux/fs/fat/inode.c	2003-01-02 12:21:53.000000000 +0900
> +++ linux98/fs/fat/inode.c	2003-02-24 11:30:10.000000000 +0900
> @@ -939,7 +939,8 @@
>  		error = first;
>  		goto out_fail;
>  	}
> -	if (FAT_FIRST_ENT(sb, media) != first) {
> +	if (FAT_FIRST_ENT(sb, media) != first
> +	    && (media != 0xf8 || FAT_FIRST_ENT(sb, 0xfe) != first)) {

Maybe add a small comment here describing it's needed for PC98 dos?

BTW: Linux codingstyle sais it should be written as

	if (FAT_FIRST_ENT(sb, media) != first &&
	    (media != 0xf8 || FAT_FIRST_ENT(sb, 0xfe) != first)) {


Also please split this patch up into one to the fat file system
and one to the partition code.


Otherwise this patch looks nice to me.

