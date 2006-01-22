Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWAVU0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWAVU0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWAVU0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:26:54 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:40282 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbWAVU0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:26:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=InMfi/VLcyakX9TiYXoMfU2lnnvHGEAZsvELuSk15F3QtPOCZGTGFZ1CV/fijcGng5jur9r40WXexHaLv/TMkTQgXvctWGGscjEBDQnk5JX6yuI8BsHq2/JEbv/1U6o+SygXCYVOdhua6ZtQWYfjudj81mO5uFzl/Qf4k+mIl8o=
Message-ID: <43D3E96C.2050703@gmail.com>
Date: Sun, 22 Jan 2006 21:22:04 +0100
From: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: es-ar, es, en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] minix filesystem: Corrected patch
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka!

On 1/22/06, you wrote:

 >+                                       offset = p - kaddr;
 >> +                                       over = filldir(dirent, de3->name, l,
 >> +                                       (n<<PAGE_CACHE_SHIFT) | offset,
 >> +                                       de3->inode, DT_UNKNOWN);
 >Hmm, strange formatting. Wouldn't it be better if you introduced a
 >name pointer and moved those filldir bits outside of the if-else
 >block? Less code duplication that way.
 >+                               if (namecompare(namelen,sbi->s_namelen,name,de3->name))
 >> +                                       goto found;
 >> +                       }
 >Same here.
 >+                                       goto out_unlock;
 >> +                               de = minix_next_entry(de, sbi);
 >> +                               de3 = minix_next_entry(de3, sbi);
 >Why do you do both here?

You are right, but I thought that duplication was the appropiate to be the most conservative with the preexistent code and also providing for the needed duplication of the strucutre minix_dir_entry.
The secondary structure (minix3_dir_entry) has to follow all the endeavours of its parent one, so both are here.

 >+               sbi->s_log_zone_size = *(__u16 *)(bh->b_data + 12);
 >> +               sbi->s_max_size = *(__u32 *)(bh->b_data + 16);
 >> +               sbi->s_nzones = *(__u32 *)(bh->b_data + 20);
 >You probably want to introduce a struct minix3_super_block for this.
 >It's much more readable that way.

Yes, but if I do, is closer to a rewrite of the preexistent code. And I think that it not deserves it. Minix is not so important (sorry if some one is listening).

 >+                               goto out_bad_hblock;
 >> +               }
 >You're now setting the block size twice for the V3 case.

You are right.

 >+#define MINIX2_INODES_PER_BLOCK(b) ((b)/(sizeof (struct minix2_inode)))
 >Maybe this should be called minix_inodes_per_block instead and be a
 >static inline function?

Just to follow the style found.




