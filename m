Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVADApq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVADApq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVADAdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:33:50 -0500
Received: from terminus.zytor.com ([209.128.68.124]:18595 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262012AbVADAbT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:31:19 -0500
Message-ID: <41D9E3AA.5050903@zytor.com>
Date: Mon, 03 Jan 2005 16:30:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tridge@samba.org
CC: sfrench@samba.org, linux-ntfs-dev@lists.sourceforge.net,
       samba-technical@lists.samba.org, aia21@cantab.net,
       hirofumi@mail.parknet.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FAT, NTFS, CIFS and DOS attributes
References: <41D9C635.1090703@zytor.com> <16857.56805.501880.446082@samba.org>
In-Reply-To: <16857.56805.501880.446082@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> 
> Thats taken from Samba4, where it is fully implemented. I guess Steve
> is planning on integrating cifsfs with the Samba4 way of handling EAs,
> NT ACLs, attribs, streams etc at some stage.
> 
> See 
>   http://samba.org/ftp/unpacked/samba4/source/librpc/idl/xattr.idl 
> for a full definition of the structures we use. 
> 
> I used a NDR encoding in each of the xattrs to provide a well defined
> architecture independent encoding, and an easy way to extend the
> structure in the future (thats why DosAttrib is a union with a version
> switch). 
> 

Oh geez.  Couldn't you have split out the various data items into 
separate xattrs?  This seems to be a really bad user interface, 
especially for writing (can't chmod the file without poking at all the 
other data items), except for a non-DOS-based filesystem to keep data 
for Samba itself.  Samba clearly has other needs than other users, 
although of course it would be unfortunate if Samba then can't export 
this information.

In other words, I'm inclined to define simple system attributes or just 
go back to the original ioctl() patch for the DOS filesystems as seen by 
the kernel.

	-hpa
