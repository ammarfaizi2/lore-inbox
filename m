Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264836AbUF1HMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264836AbUF1HMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264843AbUF1HMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:12:12 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:50880 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S264836AbUF1HMH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:12:07 -0400
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Reply-To: goldwyn_r@myrealbox.com
From: "Goldwyn Rodrigues" <goldwyn_r@myrealbox.com>
To: jbglaw@lug-owl.de
CC: linux-kernel@vger.kernel.org
Date: Mon, 28 Jun 2004 12:42:01 +0530
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1088406721.9804291cgoldwyn_r@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With an unpatched version you would not be able to create a file
>> greater than 2TB at all and considers that all files are below 2TB.
>
>
> ...but consider what's happening in the case you're first running a
> patched kernel, create some >2TB files, then start an unpatched kernel
> and work with those (formerly >2TB) files.
>
> First of all, the files will look like being %= 2TB (albeit that, I
> think with any >2TB file, you'd need to set an incompatibility flag so
> that an unpatched ext3fs actually *refuses* to mount any FS containing a
> file >2TB). What happens if you rename() such a file? What happens if
> you use a pre-2TB ext2fs with it?
>
> Sounds like an incompatible extension, so you need to mark it as one:)


I am working on the COMPAT fields now. Most probably, I will be able to give Read only access. I have to study more on this.

>> Andreas has proposed a few fields but I want to make sure that those
>> fields as well are not used.
>
>
>
> If you were "offered" several chooses, why did you take this one, which
> is used by the HURD? Were other possibilities already used for other
> purposes?


I got the mail just sometime back. I am working on it. The fields are
the ones for fragmented address. I do not know why they are placed there
and am trying to find if they are used in any other code. However, they
would still overlap with other OS. The fields proposed are:

__u32    i_faddr; used to keep fragmented addresses. I did not see any
reference to this data field in the linux code.
__u8 l_i_frag: fragment number.. conflicts with similar field in HURD
__u8 l_i_fsize: Fragment size.. conflicts with similar field in HURD
__u16 ipad1: unused. conflicts with i_mode_high in HURD

If anyone knows if these fields are used, in the Linux kernel source, or
any other operating system, let me know.


> They're "compatible" as long as there's no data in the journal; with
> data in the journal, ext3 marks itself as being incompatible ext2. This
> is what >2TB filesize support probably needs to do, too.
>

By "converting", I meant re-coding the patch for ext2. I consider the
ext2 and ext3 filesystems different, as they were meant to be. As far as
data structure which I am concerned with, for breaking the limits, ext2
and ext3 use the same inode data structures.

Thanks,

-- 
Goldwyn :o)




