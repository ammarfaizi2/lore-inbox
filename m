Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVADXLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVADXLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVADXHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:07:40 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:40655 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262163AbVADVpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 16:45:39 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, hirofumi@mail.parknet.co.jp,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1104833357.26349.21.camel@imp.csi.cam.ac.uk>
References: <41D9B1C4.5050507@zytor.com>
	 <1104787447.3604.9.camel@localhost.localdomain>
	 <41D9BA8B.2000108@zytor.com>
	 <1104788816.3604.17.camel@localhost.localdomain>
	 <41D9C111.2090504@zytor.com>  <1104833357.26349.21.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 04 Jan 2005 13:45:37 -0800
Message-Id: <1104875137.3815.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-04 at 10:09 +0000, Anton Altaparmakov wrote:
> > Nicholas Miell wrote:
> > > On another note, NTFS-style xattrs (aka named streams) are unrelated to
> > > Linux xattrs. A named stream is a separate file with a funny name, while
> > > a Linux xattr is a named extension to struct stat.
> 
> This is incorrect.  NTFS has two different beasts:
> 
[ why this is incorrect omitted for brevity ]
> 
> One interesting bit of trivia is that Windows uses named streams very
> extensively while it _never_ uses EAs.  In fact I have never seen a
> Windows OS or application that uses EAs.  They were added to be
> compatible with OS/2 EAs when it came out but since OS/2 died they now
> just seem like old baggage/backwards compatibility in Windows that is no
> longer used.  (If anyone knows of a Windows application that uses EAs
> please let me know.  I would be most interested in knowing about it!)
> 

This would probably explain why I've never heard of them. In my brief
perusal of the MSDN Library in search of more information about these
beasts, the only hint I could find related to their existence is in
parameters to ZwCreateFile/NtCreateFile (which are themselves mostly
undocumented). The high level file API certainly doesn't support their
use, AFAICT.

I think it's reasonably safe to assume that hpa's worry that FAT might
get EAs in the future is unfounded. (Named streams is still a
possibility, but I don't think Microsoft is all that interested in
making improvements to a filesystem that people use so that they don't
have to license NTFS.)

> Hope this clears things up a bit as far as NTFS is concerned...
> 
> I don't know what API would be best for accessing named streams on NTFS
> but an xattrs like interface is not suitable IMO.  You really want to be
> able to open them and access them like normal files.  An interface
> similar to the Solaris openat() system call (see
> http://docs.sun.com/app/docs/doc/816-0212/6m6nd4nc7?a=view) that has
> been discussed on LKML before seems like a good way to deal with this
> but I am more interested in getting normal write support into NTFS at
> present than I am in fancy features like EAs and named streams...
> 

Good luck with that.

> Best regards,
> 
>         Anton
-- 
Nicholas Miell <nmiell@comcast.net>

