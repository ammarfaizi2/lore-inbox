Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131639AbRCODFa>; Wed, 14 Mar 2001 22:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131637AbRCODFV>; Wed, 14 Mar 2001 22:05:21 -0500
Received: from crusoe.degler.net ([160.79.55.71]:3008 "EHLO degler.net")
	by vger.kernel.org with ESMTP id <S131635AbRCODFO>;
	Wed, 14 Mar 2001 22:05:14 -0500
Date: Wed, 14 Mar 2001 22:04:23 -0500
From: Stephen Degler <sdegler@degler.net>
To: John Jasen <jjasen1@umbc.edu>
Cc: unlisted-recipients: no To-header on input <;@pop.zip.com.au>,
        linux-kernel@vger.kernel.org, AmNet Computers <amnet@amnet-comp.com>
Subject: Re: magic device renumbering was -- Re: Linux 2.4.2ac20
Message-ID: <20010314220423.B23058@crusoe.degler.net>
In-Reply-To: <3AAF8A71.1C71D517@faceprint.com> <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.31L.02.0103141026460.532128-100000@irix2.gl.umbc.edu>; from jjasen1@umbc.edu on Wed, Mar 14, 2001 at 10:36:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The solution is not to go down the path2inst road, that is full of 
its own traps.  You want volume labels via a volume manager (do lvm and raid
already do this?) and/or filesystem labels (see e2fslabel).  This won't solve
all of the ills associated with device instance changes, but it will certainly
address the biggest one.

skd

On Wed, Mar 14, 2001 at 10:36:40AM -0500, John Jasen wrote:
> 
> The problem:
> 
> drivers change their detection schemes; and changes in the kernel can
> change the order in which devices are assigned names.
> 
> For example, the DAC960(?) drivers changed their order of
> detecting controllers, and I did _not_ have fun, given that the machine in
> question had about 40 disks to deal with, spread across two controllers.
> 
> This can create a lot of problems for people upgrading large, production
> quality systems -- as, in the worst case, the system won't complete the
> boot cycle; or in middle cases, the user/sysadmin is stuck rewriting X
> amount of files and trying again; or in small cases, you find out that
> your SMC and Intel ethernet cards are reversed, and have to go fix things
> ...
> 
> Possible solutions(?):
> 
> Solaris uses an /etc/path_to_inst file, to keep track of device ordering,
> et al.
> 
> Maybe we should consider something similar, where a physical device to
> logical device map is kept and used to keep things consistent on
> kernel/driver changes; device addition/removal, and so forth ...
> 
> I am, of course, open to better solutions.
> 
> --
> -- John E. Jasen (jjasen1@umbc.edu)
> -- In theory, theory and practise are the same. In practise, they aren't.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
