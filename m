Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWGMSjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWGMSjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWGMSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:39:54 -0400
Received: from mail.parknet.jp ([210.171.160.80]:51461 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1030282AbWGMSjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:39:53 -0400
X-AuthUser: hirofumi@parknet.jp
To: Eduard Bloch <edi@gmx.de>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: confusion and case problems: utf8 <-> iocharset
References: <20060713075617.GA9429@rotes76.wohnheim.uni-kl.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 14 Jul 2006 03:39:44 +0900
In-Reply-To: <20060713075617.GA9429@rotes76.wohnheim.uni-kl.de> (Eduard Bloch's message of "Thu, 13 Jul 2006 09:56:17 +0200")
Message-ID: <87fyh5bb7z.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch <edi@gmx.de> writes:

> The trouble:
>
> First, the terminology in vfat.txt is not consistent with what actually
> happens. It says "iocharset" but in fact it is not a charset used for IO
> operations, it does not stand for charset at all but for the mapping of
> encodings. The better name should be "visible_encoding", IMO.
> And in the kernel setup, why do I need a separate "VFAT_IOCHARSET"
> option? Why should I not use the systemwide settings, AFAICS that change
> is relevant for what the users see and this thing should be consistent
> across all mounted filesystems. So why do I need a separate kernel
> setting here? Questions over questions.

Probably, you want to use "utf8" systemwidely. But, you shouldn't use
utf8 for vfat, because it's breaking. The main reason is this.

> Second: 
> there is the "utf8" option. How does that exactly differ from
> iocharset=utf8? There is not clear explanation in vfat.txt. What happens
> if you use both options, especially if iocharset!=utf8? Which one is
> prefered?

iocharset=utf8 doesn't have a case conversion table.

utf8 option is similar to iocharset=utf8, but utf8 uses case
conversion table of iocharset=xxx. But, there is a known bug.

> Third:
> how can I disable all that funny letter case conversions? They are not
> described anywhere properly, nor the way to disable them. IMO there are
> two problems:
>
>  - what you write to the FS is not the same what "ls" shows you later.
>    Eg. ABW becomes "abw" but "ABWÖ" becomes "ABWÖ". Abcd becomes "Abcd"
>    but "ABC" becomes "abc".  Does it make sense? NO.
>    I would like to stop the kernel playing such games, I had enough of
>    such trouble back in my Windows 98 times.

Probably, you want to use shortname=xxx option.

>  - this case conversion can actually break things. When iocharset=utf-8
>    and utf8 are used, then you cannot access the data with the same
>    name after storing it.

Yes, it's a known bug.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
