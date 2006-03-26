Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWCZQ1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCZQ1s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWCZQ1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:27:48 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:31884 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932090AbWCZQ1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:27:47 -0500
Date: Sun, 26 Mar 2006 09:27:44 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: cascardo@minaslivre.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060326162744.GA13185@schatzie.adilger.int>
Mail-Followup-To: cascardo@minaslivre.org,
	Theodore Ts'o <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
	Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org
References: <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org> <20060325145139.GA5606@cascardo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325145139.GA5606@cascardo.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 25, 2006  11:51 -0300, cascardo@minaslivre.org wrote:
> As AMS has pointed out, the filesystem creator must be set to Hurd for
> these inode fields to be used. Since ext2 seems to be the most
> supported filesystem on Hurd, most of the ext2 fs used have the fs
> creator set to Hurd.

So, if fs creator is Linux then HURD doesn't try to use those fields?
That would allow Linux to start using them, and if such a filesystem
is used on HURD then it could store the translator/author/mode_high
in the xattr space.  Does it even make sense to add translator/author
to existing files, or only at file creation time?

That would mean that Linux would just need to check the fs creator
field before using any of the HURD-reserved fields.

> Regarding compatibility, there are plans to support xattr in Hurd and
> use them for these fields, translator and author. (I can't recall what
> i_mode_high is used for.) With respect to that, I'd appreciate if
> there is a recommendation to every ext2 implementation (not only
> Linux) that supports xattr, to support gnu.translator and gnu.author
> (I'll check about the i_mode_high and post about it asap.).

Not that we will be in a rush to use these fields, but it would be good
to know what i_mode_high is used for in case it ever becomes relevant
for Linux we would want to keep it the same meaning as HURD.

> There is a
> patch by Roland McGrath for Linux that supports those besides the
> reserved fields in case the fs creator is Hurd.

I'm not sure what is required for supporting such EAs?  I don't think
any kernel would remove existing EAs, even if it doesn't understand
them.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

