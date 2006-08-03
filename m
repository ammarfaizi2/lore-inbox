Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWHCPck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWHCPck (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWHCPck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:32:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:35995 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964791AbWHCPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:32:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K+p+0pm9nGCB+zacNfr3RoS1OCqZzWYFV26sXp1xwYESK7vbYwvgLdATgKYZBvl98qt0iw9ezhzprfzqBoTLuxHJjgQiLWuRojgwMRSjidmEfNrmSgQOKRiLHBCpYLcI8COOoJJY3Udtp7K+/4S9qwQuWfjYH+9RkqOhDwA7f7o=
Message-ID: <4ae3c140608030832n2124b8abu479b7b4ae3eda1f@mail.gmail.com>
Date: Thu, 3 Aug 2006 11:32:33 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Can someone explain under what condition inode cache pages can be swapped out?
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0608030951270.32738@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4ae3c140608022315y675eed20hcefbb8fb0407f4a3@mail.gmail.com>
	 <Pine.LNX.4.61.0608030951270.32738@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many thanks for kind replies.

You said inode cache is never swapped at all. In other words, the
inode cache pages are not swappable. How do you know the pages are
never swapped out? How can I tell whether a specific memory page is
swappable?  Can you point me to the right place in the kernel so that
I can see more details?

If my understanding is right, inode cache shrinker only frees the
reclaimable inodes, which means, if a lot of files are opened when
shrinker is activated, the shrinker may not find sufficient
reclaimable inodes to free enough space. What will Linux do under such
condition?

Xin

On 8/3/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
>
> >
> > Specifically, how a swaping system determine which page should be
> > swapped out when memory is tight?
>
> LRU, f.ex.
>
> > Intuitively, I think inode cache
> > pages should be swapped out as late as possible.
>
> I believe they are not swapped at all - they are shrunk when memory becomes
> a premium. (If this was a math class I'd say the cache size will be zero,
> although that's not too realistic in practice)
>
> > But how Linux mkae
> > decision on this? Why linux does not pin inode pages in the memory?
>
> Ugh hell no. Then you could trigger OOM by simply walking a big filesystem.
>
>
> Jan Engelhardt
> --
>
