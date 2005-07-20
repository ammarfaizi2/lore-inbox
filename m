Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVGTHgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVGTHgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 03:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVGTHgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 03:36:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:4562 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261173AbVGTHgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 03:36:15 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>, linux-kernel@vger.kernel.org,
       machida@sm.sony.co.jp
Subject: Re: [RFD] FAT robustness
Date: Wed, 20 Jul 2005 10:35:41 +0300
User-Agent: KMail/1.5.4
References: <20050719165821.96544.qmail@web26907.mail.ukl.yahoo.com>
In-Reply-To: <20050719165821.96544.qmail@web26907.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507201035.41877.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 July 2005 19:58, Etienne Lorrain wrote:
> > I'd like to have a discussion about FAT robustness.
> > Please give your thought, comments and related issues.
> 
>   What I would like is to treat completely differently writing to
>  FAT (writing to a removeable drive) which need a complete "mount",
>  and just reading quickly a file (a standard use of removeable devices).
> 
>  Basically, to read you would not need to mount the partition, just
>  read /readfs/fd1 which uses two or three functions accessing /dev/fd1
>  in raw mode to read the filesystem descriptor and the root directory.
>  Same for /readfs/cdrom and /readfs/sda4 (USB drive).
>  The only cache would be the one provided by /dev/fd1 - a kind of
>  mount read-only at each file opening.
> 
>  This system would be disabled if the partition is already mounted
>  read/write somewhere - but as long as you do not try to write to
>  a removeable disk you can extract it at any time.
> 
>   The two or three function I am talking of are located in Gujin
>  "fs.c" file to access read-only FAT12/16/32, EXT2/3 and ISOFS
>  ( http://gujin.org ). Just few kilobytes - and some source
>  modifications for that use.

I think we will be better with more generic 'flush all dirty data
and mark superblock as clean asap' behaviour, aka 'weak O_SYNC',
so that we can remove e.g. USB removable almost anytime (can't safely
remove it _only while it is being written to_).
--
vda

