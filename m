Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSIFCYs>; Thu, 5 Sep 2002 22:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSIFCYr>; Thu, 5 Sep 2002 22:24:47 -0400
Received: from stine.vestdata.no ([195.204.68.10]:56206 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S318234AbSIFCYr>; Thu, 5 Sep 2002 22:24:47 -0400
Date: Fri, 6 Sep 2002 04:29:21 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020906042921.B23940@vestdata.no>
References: <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny> <20020905212545.A5349@namesys.com> <20020905211849.GA3942@pegasys.ws> <20020906000249.A10844@vestdata.no> <20020905225706.GC3942@pegasys.ws> <20020906020138.A23940@vestdata.no> <20020906014122.GE3942@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020906014122.GE3942@pegasys.ws>; from jw@pegasys.ws on Thu, Sep 05, 2002 at 06:41:22PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 06:41:22PM -0700, jw schultz wrote:
> > > So a value of 0 would have the same effect.
> > > (0 - 2 == -2 vs 1 - 2 == -1) Yes?
> > 
> > Yes, it will. For GNU find.
> > 
> > But the reasoning for using nlink==1 is that that's how "all non-unix
> > filesystems" behaved, so applications out there could potentially check
> > for it. 
> 
> But we aren't talking about filesystems with different ideas
> about directory linking.  We are talking about directories
> with an overflowed link-count.

No, but from an application's point of view they're the same. They're
both directories unable to report the number of subdirectories they
have. So, they should be handled the same. Either with nlink==1, or
nlink==0, but I think it will be difficult to migrate to the later if a
lot of existing software implement the first one.

> The value of 1 can't be used for regular files because it
> would mean the file doesn't need checking for other links.
> Coding for NLINK_MAX would mean the apps would have to
> adjust every time NLINK_MAX changed.  Yes, it could be done
> through #define in stat.h.  It is a corner case right now
> but these apps could know that
> 
> 	1 == no other links
> 	>1 == known number of other links
> 	0 == unknown number of other links

I agree.



-- 
Ragnar Kjørstad
