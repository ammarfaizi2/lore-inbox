Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288700AbSADRpz>; Fri, 4 Jan 2002 12:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbSADRpq>; Fri, 4 Jan 2002 12:45:46 -0500
Received: from [212.16.7.124] ([212.16.7.124]:15491 "HELO laputa.namesys.com")
	by vger.kernel.org with SMTP id <S280984AbSADRpb>;
	Fri, 4 Jan 2002 12:45:31 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15413.59311.202564.173759@laputa.namesys.com>
Date: Fri, 4 Jan 2002 20:34:39 +0300
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>, <andries.brouwer@cwi.nl>
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <Pine.LNX.4.33.0201040845130.5360-100000@penguin.transmeta.com>
In-Reply-To: <3C355143.8FAC281D@mandrakesoft.com>
	<Pine.LNX.4.33.0201040845130.5360-100000@penguin.transmeta.com>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
 > 
 > On Fri, 4 Jan 2002, Jeff Garzik wrote:
 > > >
 > > > Now, if somebody actually has the raw "kdev_t" in their on-disk
 > > > structures, that's a real problem, but I don't think anybody does.
 > > > Certainly I didn't see reiserfs do it (but it may well be missing a few
 > > > "kdev_t_to_nr()" calls)
 > >
 > > AFAICS it does:
 > >
 > > include/linux/reiserfs.h:
 > > #define sd_v1_rdev(sdp)         (le32_to_cpu((sdp)->u.sd_rdev))
 > > #define set_sd_v1_rdev(sdp,v)   ((sdp)->u.sd_rdev = cpu_to_le32(v))
 > 
 > Ok, just add the proper conversion functions, ie a "to_kdev_t()" and
 > "kdev_t_to_nr()".

Actually, result of sd_v1_rdev() is only passed to init_special_inode()
which takes int rather than kdev_t.

Isn't this a bit strange, because file system backend has to convert
kdev_t to u32 on write, but not on read?

 > 
 > 		Linus

Nikita.

 > 
