Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSIEX5J>; Thu, 5 Sep 2002 19:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318510AbSIEX5H>; Thu, 5 Sep 2002 19:57:07 -0400
Received: from stine.vestdata.no ([195.204.68.10]:10892 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S318302AbSIEX5E>; Thu, 5 Sep 2002 19:57:04 -0400
Date: Fri, 6 Sep 2002 02:01:38 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020906020138.A23940@vestdata.no>
References: <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com> <20020905174902.A32687@namesys.com> <1031234624.1726.224.camel@tiny> <20020905181721.D32687@namesys.com> <1031244334.1684.264.camel@tiny> <20020905212545.A5349@namesys.com> <20020905211849.GA3942@pegasys.ws> <20020906000249.A10844@vestdata.no> <20020905225706.GC3942@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905225706.GC3942@pegasys.ws>; from jw@pegasys.ws on Thu, Sep 05, 2002 at 03:57:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 03:57:06PM -0700, jw schultz wrote:
> > Now, I've just checked the source of GNU find (v4.1.7) and it does _not_
> > recognize nlink=1 as a special value. (It works as long as there are
> > less than 2^32 subdirectories though, because it is looking for -1
> > subdirectories and it wraps)
> 
> So a value of 0 would have the same effect.
> (0 - 2 == -2 vs 1 - 2 == -1) Yes?

Yes, it will. For GNU find.

But the reasoning for using nlink==1 is that that's how "all non-unix
filesystems" behaved, so applications out there could potentially check
for it. 

> I know it is used for reporting purposes such as ls -l.  It
> would also used by archiving tools like cpio, tar and rsync
> to identify files that may be linked so that not every file
> must be checked against every previous file.  A smart
> archiving tool would track the link count and remove entries
> that have all links found so any value that isn't recognized
> as an overflow indicator would tend to break things.  I see
> the value of 0 as indicating "link count unsupported".

Hmm, yes. Values of 1 or NLINK_MAX would definitively confuse such
applications. But then again, so would a value of 0 unless they know
it's meaning.



-- 
Ragnar Kjørstad
