Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSGUOHv>; Sun, 21 Jul 2002 10:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317550AbSGUOHv>; Sun, 21 Jul 2002 10:07:51 -0400
Received: from ns.suse.de ([213.95.15.193]:13316 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315919AbSGUOHu>;
	Sun, 21 Jul 2002 10:07:50 -0400
Date: Sun, 21 Jul 2002 16:10:50 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020721161050.A10867@wotan.suse.de>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel <1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.ke <p731y9xva8m.fsf@oldwotan.suse.de> <1027258811.17234.90.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027258811.17234.90.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2002 at 02:40:11PM +0100, Alan Cox wrote:
> On Sun, 2002-07-21 at 07:57, Andi Kleen wrote:
> > One disadvantage of the LVM2 concept is that it relies a lot on compatible
> > user space and there is unlikely to be a stable API. While I'm normally
> > all for putting things in user space where it makes sense I think the
> > mounting of your root file system is a bit of exception. 
> 
> LVM2 relies on people doing things right so we shouldnt use it ? 

The problem in my opinion with LVM2 is that the design makes it 
near impossible to get a stable ABI between user and kernel space
(at least if you don't want to freeze it completely). User space
and kernel space are deeply tangled together and there is no
abstraction layer

And after my LVM1 experiences I am not going to give my root filesystem
to anything that is not committed to a stable ABI between all 
stable and development kernels.

To give one example: at one point I had 
/lvmtools1/vgchange -a y || /lvmtools2/vgchange -a y || /lvmtools3/vgchange -a y
in an startup script just to handle booting of different kernel versions
with differnet incompatible LVM ABIs on the same system. 
As far as I can see this problem is not addressed in LVM2 and its design
makes it even harder to address than it was in LVM1

Then of course there are people who only ever use a single kernel
version and for them this is no issue and I guess for them LVM2 will
be fine. But for the others EVMS looks like a better alternative.

But as I said in my earlier mail there is really no reason to chose 
on over another. They do not impact any core code and both can be put in.

-Andi
