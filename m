Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWFIVaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWFIVaS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 17:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWFIVaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 17:30:18 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:3059 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030338AbWFIVaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 17:30:16 -0400
Date: Fri, 9 Jun 2006 14:29:05 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609212905.GK3574@ca-server1.us.oracle.com>
Mail-Followup-To: Alex Tomas <alex@clusterfs.com>,
	Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Chase Venters <chase.venters@clientec.com>,
	Andreas Dilger <adilger@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, cmm@us.ibm.com,
	linux-fsdevel@vger.kernel.org
References: <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org> <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <1149880865.22124.70.camel@localhost.localdomain> <m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org> <m3wtbq5dgw.fsf@bzzz.home.net> <20060609204418.GG3574@ca-server1.us.oracle.com> <m3fyie5a19.fsf@bzzz.home.net> <20060609211123.GI3574@ca-server1.us.oracle.com> <m364ja58m8.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m364ja58m8.fsf@bzzz.home.net>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 01:20:31AM +0400, Alex Tomas wrote:
> two point here:
> a) warnings should be made visible at mount time,
>    something like printk(KERN_CRIT ...)

	Too late, they're already broken!

> b) I don't think you're going to fight all crazy people in the world,
>    they'll definitely find a way to break something:
>    data or something else.

	Certainly not the crazy people.  But the random person who's
just humming along?  We should be nice to them.
 
> PS. in the end, "extents" option affects *new* files only. and one
>     can boot extents-enabled kernel and convert fs back.

	I just mentioned to Ted in another mail, since this is a
"permanent" change to the on-disk structure, why is this a mount option?
Shouldn't it rather be a tunefs(8)/mkfs(8) option?
	In general, anything you pass to "mount -o" is optional.  You
can mount with option X, then unmount and mount without option X.  Most
people "expect" this to work (Principle of Least Surprise).  So, when
you do:

    # mount -o extents /fs1
    # create_file /fs1/newfile
    # umount /fs1
    # mount /fs1

it breaks.  Lease Surprise expects it to work.
	However, tunefs(8) and mkfs(8) is generally understood to make
physical changes.  Why not "tunefs -extents" to turn them on?  It's
completely analogous to "tunefs -J", will fit everyone's expectation,
and won't surprise people.  "mkfs -extents" does the same thing.

Joel

-- 

Life's Little Instruction Book #232

	"Keep your promises."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
