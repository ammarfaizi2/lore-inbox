Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318969AbSICXCb>; Tue, 3 Sep 2002 19:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSICXCa>; Tue, 3 Sep 2002 19:02:30 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:63163 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318969AbSICXCa>; Tue, 3 Sep 2002 19:02:30 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 4 Sep 2002 09:06:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15733.16519.380396.276174@notabene.cse.unsw.edu.au>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@suse.cz>,
       Peter Chubb <peter@chubb.wattle.id.au>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Large block device patch, part 1 of 9
In-Reply-To: message from Linus Torvalds on Tuesday September 3
References: <15732.34929.657481.777572@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.44.0209030900410.1997-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 3, torvalds@transmeta.com wrote:
> 
> On Tue, 3 Sep 2002, Neil Brown wrote:
> > 
> > Effectively, this is a type-safe cast.  You still get the warning, but
> > it looks more like the C that we are used to.
> 
> I wonder if the right answer isn't to just make things like "__u64" be
> "long long" even on 64-bit architectures (at least those on which it is 64
> bit, of course. I _think_ that's true of all of them). And then just use 
> "llu" for it all.

The thing is that the patch in question wants to print a "sector_t",
not a "__u64".
sector_t can be u32 (on 32 bit machines that don't need big devices
and don't want the performance hit) or can be u64 (elsewhere).  

And isn't saying "long long is 64bits" just as bad as all the
pre-alpha code that thought "long" was 32 bits, or the PDP code that
knew that "int" was 16 bits?

NeilBrown
