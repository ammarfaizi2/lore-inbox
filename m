Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288697AbSADRvp>; Fri, 4 Jan 2002 12:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbSADRvf>; Fri, 4 Jan 2002 12:51:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7187 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S280984AbSADRv0>;
	Fri, 4 Jan 2002 12:51:26 -0500
Message-ID: <3C35EB95.FAE9E4BE@mandrakesoft.com>
Date: Fri, 04 Jan 2002 12:51:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        linux-kernel@vger.kernel.org, andries.brouwer@cwi.nl,
        viro@math.psu.edu
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <3C355143.8FAC281D@mandrakesoft.com>
		<Pine.LNX.4.33.0201040845130.5360-100000@penguin.transmeta.com> <15413.59311.202564.173759@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> 
> Linus Torvalds writes:
>  >
>  > On Fri, 4 Jan 2002, Jeff Garzik wrote:
>  > > >
>  > > > Now, if somebody actually has the raw "kdev_t" in their on-disk
>  > > > structures, that's a real problem, but I don't think anybody does.
>  > > > Certainly I didn't see reiserfs do it (but it may well be missing a few
>  > > > "kdev_t_to_nr()" calls)
>  > >
>  > > AFAICS it does:
>  > >
>  > > include/linux/reiserfs.h:
>  > > #define sd_v1_rdev(sdp)         (le32_to_cpu((sdp)->u.sd_rdev))
>  > > #define set_sd_v1_rdev(sdp,v)   ((sdp)->u.sd_rdev = cpu_to_le32(v))
>  >
>  > Ok, just add the proper conversion functions, ie a "to_kdev_t()" and
>  > "kdev_t_to_nr()".
> 
> Actually, result of sd_v1_rdev() is only passed to init_special_inode()
> which takes int rather than kdev_t.
> 
> Isn't this a bit strange, because file system backend has to convert
> kdev_t to u32 on write, but not on read?

As mentioned to viro on IRC, I think init_special_inode should take
major and minor arguments, to nudge the filesystem implementors into
thinking that major and minor should be treated separately, and be given
additional thought as to how they are encoded on-disk.

(I suggested having init_special_inode taking a kdev_t argument as its
third arg, but viro yelled at me :))

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
