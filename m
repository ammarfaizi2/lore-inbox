Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316445AbSEWJQ1>; Thu, 23 May 2002 05:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316433AbSEWJQ0>; Thu, 23 May 2002 05:16:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57869 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316431AbSEWJQZ>; Thu, 23 May 2002 05:16:25 -0400
Date: Thu, 23 May 2002 11:16:26 +0200
From: Jan Kara <jack@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nathan Scott <nathans@sgi.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Quota patches
Message-ID: <20020523091626.GA8683@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020523105947.A186660@wobbly.melbourne.sgi.com> <E17AhqN-0003Kj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Thu, May 23, 2002 at 09:30:10AM +1000, Nathan Scott wrote:
> > > ... but that should just about do the trick I think.
> > 
> > How does the patch below look Jan?
> 
> Doesn't let me select both ?
  Yes. Only one of compatible interfaces is allowed. The reason is
mainly due to QUOTAON. Both V1 and V2 interfaces used Q_QUOTAON
to turn quotas on (looking back I admit it was stupid but it happened).
So now we would have to recognize which quota file was actually given
to us and turn on proper quota format - and I dislike such magic in
kernel.. especially when it's not needed. When user has really old
quota tools (<=2.00) he will turn on V1 interface. If he has newer tools
(<3.05) he has to decide depending on format he wants to use... 3.05
and newer don't use this interface. Actually the easiest is always to
upgrade quota tools :) and this compatible interface mess is there
mainly due to possibility of backport into 2.4 kernels...
  
> > +if [ "$CONFIG_QUOTA" = "y" ]; then
> > +   define_bool CONFIG_QUOTACTL y
> > +   if [ "$CONFIG_QIFACE_COMPAT" = "y" ]; then
> > +       choice '    Compatible quota interfaces' \
> > +		"Original	CONFIG_QIFACE_V1 \
> > +		 VFSv0		CONFIG_QIFACE_V2" Original
> > +   fi
> >  fi

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
