Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287023AbRL1Unu>; Fri, 28 Dec 2001 15:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287026AbRL1Unb>; Fri, 28 Dec 2001 15:43:31 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:9661 "EHLO gin")
	by vger.kernel.org with ESMTP id <S287008AbRL1UnO>;
	Fri, 28 Dec 2001 15:43:14 -0500
Date: Fri, 28 Dec 2001 21:43:06 +0100
To: Jan Niehusmann <list064@gondor.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: [lvm-devel] Re: lvm in 2.5.1
Message-ID: <20011228204306.GG20899@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <3C2B75B3.4DEF90D3@zip.com.au> <20011227193711.GB20501@h55p111.delphi.afb.lu.se> <3C2B7A3E.E5C05404@zip.com.au> <20011227202451.GC20501@h55p111.delphi.afb.lu.se> <20011228164510.GA9129@gondor.com> <20011228131757.W12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011228131757.W12868@lynx.no>
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 01:17:57PM -0700, Andreas Dilger wrote:
> On Dec 28, 2001  17:45 +0100, Jan Niehusmann wrote:
> > On Thu, Dec 27, 2001 at 09:24:51PM +0100, andersg@0x63.nu wrote:
> > > hmm, enlarging the dummy[200] in the userspace version of lv_t seems to be a
> > > nice quickndirty solution.
> > 
> > Please do not change the kernel / userspace interface easily. Past
> > experience has shown that this leads to significant update problems,
> > because kernel and userspace tools need to be updated at the same time.
> 
> But since this is a 2.5 kernel, now is the time to change it, but you must
> _also_ change the IOP version in lvm.h to 12 (not 11!) if you change the
> struct sizes.
> 
> Sadly, I think the work that was done in the past to support user tools
> for multiple IOP versions was dropped from (or never added to) the LVM
> build process, so it will not just be a matter of "install the latest
> user tools and all will be well", sigh.  We had this problem with the
> change from IOP6 to IOP10, and had fixed it all up, but we are doomed
> to repeat the same problem over again.

but there is no need to change the kernel-userspace interface. it is just
the __KERNEL__ part that has grown, having different kernel and userspace
lv_t and just converting between them should be enough. this will hopefully
make the interface more stable too. anyhow its broken as it is in 2.5 right
now, with (sizeof(lv_t) in kernel != sizeof(lv_t) in userspace) when the
tools expects it to be. 

it would be nice to be able to use the same tools in 2.4 and 2.5 and i don't
see any reason it shouldn't be possible.

i'm thinking about something like this:

userspace uses lv_t which is about 240 bytes, kern space uses its own _huge_
klv_t and the ioctls converts between them. then we can go adding stuff into
the klv_t without worry.. klv_t could begin with the lv_t so converting it
for sending it to user is simply a cast. getting it from user involves
validating it the convertion almost be in place already.

good that we have uml in 2.5 again so i don't have to be afraid to trash my
laptop disk.

-- 

//anders/g

