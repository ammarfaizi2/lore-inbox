Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284181AbRLKXHT>; Tue, 11 Dec 2001 18:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284178AbRLKXHC>; Tue, 11 Dec 2001 18:07:02 -0500
Received: from miami.integratus.com ([192.111.50.240]:21497 "HELO
	mail.integratus.com") by vger.kernel.org with SMTP
	id <S284177AbRLKXGl>; Tue, 11 Dec 2001 18:06:41 -0500
Message-ID: <3C1690E6.914911A2@integratus.com>
Date: Tue, 11 Dec 2001 15:04:06 -0800
From: curtis@integratus.com
Organization: Integratus, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Anton Altaparmakov <aia21@cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributesinterface)
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com>	 <20011207202036.J2274@redhat.com>	 <20011208155841.A56289@wobbly.melbourne.sgi.com>	 <3C127551.90305@namesys.com>	 <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C166920.77F644F@integratus.com> <3C167BF1.6090301@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> What I am saying is that each of the N permutations required to
> transform a file into an extended attribute should be separately
> selectable.  Theory guys would call this orthogonalizing the primitives.
>  (I am a theory guy.;-) ).

Applying such rigor in the architecture design phase is probably a good
idea.  Doing it at application run time is not so clear to me.

If you think of files and EAs as apples and oranges, knowing the minimal
set of orthogonal steps to turn an apple into an orange is good when
designing, but I hesitate to burden an app with having to select the
"skin-color" characteristic separately from the "ascorbic acid content"
characteristic.  IMHO, files and EAs are "package deals" where we have
chosen a different set of characteristics for each, ones that we believe
will be useful to an app.

At bottom, a file holds an uninterpreted data stream.  You have to ask
yourself whether you want that to change or not.  If not, then you
build any additional functionality in selectable layers on top of the
filesystem, not in it.  If you do want it to change, then you are
headed down the path of pulling a database into the filesystem.  Come
to think of it, I believe that someone is already doing that.  :-)


Having an interface such that an app can ask for
	open("pizza-pie", F_OLIVES|F_PEPPERONI|F_ANCHOVIES|F_PINEAPPLE...)
where each of the "F_*" options are orthogonal and ask the filesystem to
layer in a different "filter" between the raw data and the app, or to
change the access characteristics (eg: block alignment, non-buffered,
etc), sounds overly complex.  I believe that this would be better done
by explicitly stacking filesystems in a per-process namespace.

Thanks,

	Curtis

-- 
Curtis Anderson						curtis@integratus.com
