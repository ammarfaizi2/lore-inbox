Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUA2WkG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 17:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUA2WkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 17:40:06 -0500
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:19852 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id S266466AbUA2Wj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 17:39:58 -0500
From: Frodo Looijaard <frodol@dds.nl>
Date: Thu, 29 Jan 2004 23:39:44 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       linux-7110-psion@lists.sourceforge.net
Subject: Re: PATCH to access old-style FAT fs
Message-ID: <20040129223944.GA673@frodo.local>
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp> <20040128115655.GA696@arda.frodo.local> <87y8rr7s5b.fsf@devron.myhome.or.jp> <20040128202443.GA9246@frodo.local> <87bron7ppd.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <87bron7ppd.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have attached a newer, better behaving version of my patch:
  * Implements new mount option oldfat for FAT-derived filesystems.
  * Stops scanning dirs when DIR_Name[0] = 0 when oldfat is set
  * Writes a 0 to the next entry DIR_Name[0] when overwriting an entry
    which has DIR_Name[0] = 0 when oldfat is set

It has been tested with both msdos and vfat filesystems and seems to
work well (unlike the patch of a few days ago, which had some issues).

Once you get around to cleaning up the code and making the
stop-scanning-dirs-on-zero the default way, the patch can be shrunken to
include only the third item.

> The above should "goto EODir;". Likewise, another "contiure" of
> fat_search_long().

I am not convinced that the goto is always safe, and I am pretty sure
that it works now (though not as efficient as possible, perhaps), so I
have left that in place for now.

> mark_inode_dirty(dir) is not needed, instead of it we should do
> mark_buffer_dirty(bh).
> 
> And this fat_get_entry() updates bh and de, but it should be point to
> allocated bh and de, not free entry. It's needed by msdos_add_entry().

Both are now implemented using the new fat_write_zero_entry function.

Thanks for your help,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

--wac7ysb48OaltWcw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="linux-fat-2.6.0.patch-20040129.gz"
Content-Transfer-Encoding: base64

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

--wac7ysb48OaltWcw--
