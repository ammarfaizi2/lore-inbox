Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288061AbSAMUJQ>; Sun, 13 Jan 2002 15:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSAMUJG>; Sun, 13 Jan 2002 15:09:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288061AbSAMUIw>; Sun, 13 Jan 2002 15:08:52 -0500
Message-ID: <3C41E945.9040700@zytor.com>
Date: Sun, 13 Jan 2002 12:08:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com> <E16PqXQ-0000BD-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> 
>>The structure of the cpio_header is as follows (all 8-byte entries
>>contain 32-bit hexadecimal ASCII numbers):
> 
> I thought there's a binary version of the cpio header.  What is the
> point of the ascii encoding?
> 


Byte order independence.  The binary version of cpio is ancient and 
obsolete.  Unfortunately the SysV people didn't have the htons() etc 
macros of BSD, so they had no concept of portable binary formats.

 
>>The c_mode field matches the contents of st_mode returned by stat(2)
>>on Linux, and encodes the file type and file permissions.
>>
>>The c_filesize should be zero for any non-regular file.
>>
>>If the filename is "TRAILER!!!" this is actually an end-of-file
>>marker; the c_filesize for an end-of-file marker must be zero.
>>
> It sure looks ugly, but I suppose the c_filesize=zero is the real
> end-of-file marker.  Did I mention it sure looks ugly?
> 


c_filesize == 0 does *NOT* imply a end-of-archive marker.  It is the 
filename "TRAILER!!!" that does.  And yes, it's ugly.

	-hpa


