Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285272AbRLNAEo>; Thu, 13 Dec 2001 19:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285269AbRLNAEf>; Thu, 13 Dec 2001 19:04:35 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:6389 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S285265AbRLNAEU>;
	Thu, 13 Dec 2001 19:04:20 -0500
Date: Thu, 13 Dec 2001 17:03:50 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andi Kleen <ak@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: optimize DNAME_INLINE_LEN
Message-ID: <20011213170350.G940@lynx.no>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C192A37.4547D2A7@colorfullife.com> <20011213160706.E940@lynx.no> <20011214002957.A24984@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011214002957.A24984@wotan.suse.de>; from ak@suse.de on Fri, Dec 14, 2001 at 12:29:57AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 14, 2001  00:29 +0100, Andi Kleen wrote:
> On Thu, Dec 13, 2001 at 04:07:06PM -0700, Andreas Dilger wrote:
> > Alternately (also ugly) you could just define struct dentry the as now,
> > but have a fixed size declaration for d_iname, like:
> > 
> > #define DNAME_INLINE_MIN 16
> > 
> > 	unsigned char d_iname[DNAME_INLINE_MIN];
>                    Using [0] here would also work 

Well, not really.  If we wanted to have a minimum size for the d_iname
field, then if we declare it as zero and it just squeaks into a chacheline,
then we may be stuck with 0 bytes of inline names, and _all_ names will
be kmalloced.

> #define d_... has a similar problem => the potential to break previously
> compiling source code.

Again, not really.  The #define d_... scheme would leave all of the fields
in their original locations, just giving them new names within the named
struct, and the defines would be the backwards compatible (and probably
still preferrable) way to access these fields.  I don't _think_ it would
cause any compiler struct alignment issues to just put the same fields
in another struct, but I could be wrong.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

