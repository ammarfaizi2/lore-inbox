Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVADBPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVADBPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 20:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVADBPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 20:15:47 -0500
Received: from terminus.zytor.com ([209.128.68.124]:17320 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261980AbVADBPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 20:15:20 -0500
Message-ID: <41D9EDF6.1060600@zytor.com>
Date: Mon, 03 Jan 2005 17:14:30 -0800
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
References: <41D9C635.1090703@zytor.com>	<16857.56805.501880.446082@samba.org>	<41D9E3AA.5050903@zytor.com> <16857.59946.683684.231658@samba.org>
In-Reply-To: <16857.59946.683684.231658@samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org wrote:
> 
> I think you'll find that all users of dos attributes on Linux will
> have very similar needs to Samba, and will want these things grouped
> together. For example:
> 
>  - backup/restore apps will want to backup/restore these attributes as
>    lumps
>  - wine implements essentially the same APIs as Samba, just in a
>    different form, and so tends to get the same groupings of
>    attributes get/set calls that Samba does (the SMB protocol is to a
>    large degree a on-the-wire version of Win32).
> 
> Are there any other significant users of DOS attributes on Linux that
> want something different?
> 

I don't know, but it certainly doesn't match my application (which is 
pretty simple... needing to frob DOS attribute bits while writing DOS 
files) or expectation thereof... plus it's not very unixy :-/

More or less what you seem to want is an ioctl() that takes a mask of 
what to write, similar to the way notify_change() works inside the 
kernel.  This is a legitimate API, but it requires knowledge of the 
internals, and isn't setxattr().  The big thing here is the need for a mask.

Of course, one way one can do this is to expose user.dos.attrib or 
something like that as a synthesized block form of these, and still have 
separate system.* xattrs that control the individual options on the 
filesystems which actually store this stuff.

I certainly see why *you* want it, but it still seems to me to be bad 
interface design for anything other than backup and file repository 
programs.  Also see my previous note about endianness of structures 
carried from place to place.

At this point I think I'm going to let my ioctl() patch stand as-is, 
solving the immediate problem, and let people who are more directly 
affected delve into this particular morass.

	-hpa
