Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbQJaP0B>; Tue, 31 Oct 2000 10:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129242AbQJaPZw>; Tue, 31 Oct 2000 10:25:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18958 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129166AbQJaPZd>; Tue, 31 Oct 2000 10:25:33 -0500
Date: Tue, 31 Oct 2000 16:25:12 +0100
From: Jan Kara <jack@suse.cz>
To: Nathan Scott <nathans@wobbly.melbourne.sgi.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Jan Kara <jack@suse.cz>,
        jank@redhat.com, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: Quota mods needed for journaled quota
Message-ID: <20001031162512.E14635@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20001025184239.U6085@redhat.com> <sct@redhat.com> <10010261253.ZM84523@wobbly.melbourne.sgi.com> <20001026110029.K20050@redhat.com> <sct@redhat.com> <10010271003.ZM95697@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <10010271003.ZM95697@wobbly.melbourne.sgi.com>; from nathans@wobbly.melbourne.sgi.com on Fri, Oct 27, 2000 at 10:03:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

> On Oct 26, 11:00am, Stephen C. Tweedie wrote:
> > Subject: Re: Quota mods needed for journaled quota
> > ...
> > > This would allow ext3 to do that which it needs to do differently
> > > at Q_QUOTAON and would also allow Jan's changes to work in such
> > > a way that both the current form of dquot structure and his new
> > > version of dquots could be used together
> > 
> > Adding the init_quota hook would do that, as the filesystem will be
> > able to install its own dq_ops methods during the init so we get the
> > flexibility you are asking for anyway.
> > 
> 
> Hmmm ... I'm not so sure.  In order to have the flexibility
> of filesystem-specific dquot formats, the struct dquot would
> need to become more like struct inode/super_block, i.e. not
> hardcoding the ondisk structure into the incore structure
> (using a union and a generic pointer, as inode/super_block do).
> 
> The DQUOT_SYNC mechanism would need to be able to be overridden
> per-filesystem also.  It isn't really as cut-and-dried as "per-
> filesystem" either, because an ext2/3 filesystem might make use
> of either the original dquot format or Jan's newer format, either
> at mount time or even after doing a quota_off & quota_on with a
> new quota file format (that would be quite clean).
  Hmm. Probably I wouldn't allow to override quotactl() but make it like
other callbacks - operations like quota_on() quota_off() and so
could be overridden (or better filesystem could specify callback to be called
after some generic work), quotactl() will call foo_quotactl() if it won't
recognize the operation number.
  But I don't feel urgent need of this redesign so I would wait for some
time so current fixes can settle down...

								Honza

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
