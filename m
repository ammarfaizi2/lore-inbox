Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbQJZXG7>; Thu, 26 Oct 2000 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129633AbQJZXGu>; Thu, 26 Oct 2000 19:06:50 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:19721 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129453AbQJZXGh>; Thu, 26 Oct 2000 19:06:37 -0400
From: "Nathan Scott" <nathans@wobbly.melbourne.sgi.com>
Message-Id: <10010271003.ZM95697@wobbly.melbourne.sgi.com>
Date: Fri, 27 Oct 2000 10:03:19 -0400
In-Reply-To: "Stephen C. Tweedie" <sct@redhat.com>
        "Re: Quota mods needed for journaled quota" (Oct 26, 11:00am)
In-Reply-To: <20001025184239.U6085@redhat.com>  <sct@redhat.com> 
	<10010261253.ZM84523@wobbly.melbourne.sgi.com> 
	<20001026110029.K20050@redhat.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Quota mods needed for journaled quota
Cc: Jan Kara <jack@suse.cz>, jank@redhat.com,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Stephen,

On Oct 26, 11:00am, Stephen C. Tweedie wrote:
> Subject: Re: Quota mods needed for journaled quota
> ...
> > This would allow ext3 to do that which it needs to do differently
> > at Q_QUOTAON and would also allow Jan's changes to work in such
> > a way that both the current form of dquot structure and his new
> > version of dquots could be used together
> 
> Adding the init_quota hook would do that, as the filesystem will be
> able to install its own dq_ops methods during the init so we get the
> flexibility you are asking for anyway.
> 

Hmmm ... I'm not so sure.  In order to have the flexibility
of filesystem-specific dquot formats, the struct dquot would
need to become more like struct inode/super_block, i.e. not
hardcoding the ondisk structure into the incore structure
(using a union and a generic pointer, as inode/super_block do).

The DQUOT_SYNC mechanism would need to be able to be overridden
per-filesystem also.  It isn't really as cut-and-dried as "per-
filesystem" either, because an ext2/3 filesystem might make use
of either the original dquot format or Jan's newer format, either
at mount time or even after doing a quota_off & quota_on with a
new quota file format (that would be quite clean).

But I've sidetracked completely from what you were originally
talking about now, which had nothing to do with a different
ondisk format at all.

cheers.

-- 
Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
