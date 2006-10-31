Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423734AbWJaSKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423734AbWJaSKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423728AbWJaSKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:10:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:42071 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423734AbWJaSKo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:10:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Dye0ZPGCO/zd5Odnb6a6jJx5m8KOnjb72T8crAJtUf56uGlqIqZP8jLCU0HtGYXngeZUhBdaRPVR/O1eR4X+eTohOoE44MDekAZBRqaWZkqs5EMgANx36mfJHFjG4leNRY0bR0i2JLmRi5P64F+B7p+e0PbACxv9T/YxKbRRr48=
Message-ID: <f46018bb0610311010w4400dcb9n10eb872babd86cc1@mail.gmail.com>
Date: Tue, 31 Oct 2006 13:10:42 -0500
From: "Holden Karau" <holden@pigscanfly.ca>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 1/1] fat: improve sync performance by grouping writes revised
Cc: "Holden Karau" <holdenk@xandros.com>,
       "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>, hirofumi@mail.parknet.co.jp,
       linux-kernel@vger.kernel.org, "akpm@osdl.org" <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, "Nick Piggin" <nickpiggin@yahoo.com.au>
In-Reply-To: <20061031163002.GC23021@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <454765AC.1050905@xandros.com>
	 <20061031163002.GC23021@wohnheim.fh-wedel.de>
X-Google-Sender-Auth: f71f6ed243ea1621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> On Tue, 31 October 2006 10:03:08 -0500, Holden Karau wrote:
> > +static int fat_mirror_bhs_optw(struct super_block *sb, struct buffer_head **bhs,
> > +                            int nr_bhs , int wait)
> >  {
> >       struct msdos_sb_info *sbi = MSDOS_SB(sb);
> > -     struct buffer_head *c_bh;
> > +     struct buffer_head *c_bh[nr_bhs*(sbi->fats)];
>
> Variable-sized array on the kernel-stack?  That can easily explode in
> your hands.  Unless you are _very_ sure about the bounds, you should
> do an explicit kmalloc.  And if you were that sure, you could just as
> well have an array with fixed size.
>
sbi->fats has a range of 2 to 4, but I suppose that might concievably
change if someone decides they want a fat filesystem with a lot of
backup FATs and modifies some other parts of the driver to support
that. I'll change it to use kmalloc.
> > +     if (sb->s_flags & MS_SYNCHRONOUS )
> [...]
> > +             }
> [...]
> > +                              int nr_bhs )
>
> Trailing whitespace in those lines.
..... oops. I'll fix that.
>
> Jörn
>
> --
> Prosperity makes friends, adversity tries them.
> -- Publilius Syrus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Cell: 613-276-1645
