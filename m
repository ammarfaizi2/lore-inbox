Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263482AbTH3JEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 05:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTH3JEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 05:04:08 -0400
Received: from tmi.comex.ru ([217.10.33.92]:6044 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263482AbTH3JEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 05:04:05 -0400
X-Comment-To: Ed Sweetman
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: Sat, 30 Aug 2003 13:09:32 +0400
In-Reply-To: <3F4FAFA2.4080202@wmich.edu> (Ed Sweetman's message of "Fri, 29
 Aug 2003 15:55:14 -0400")
Message-ID: <m3u17zo6k3.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu>
	<m3vfshrola.fsf@bzzz.home.net> <3F4F7129.1050506@wmich.edu>
	<m3vfsgpj8b.fsf@bzzz.home.net> <3F4F76A5.6020000@wmich.edu>
	<m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
	<m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


yes, you're correct. extents make sense for large files generally speaking.
having extents, it's simpler to implement delayed allocation, imho. delayed
allocation makes sense for all files. especially for temporary files (say,
.S files during make bzImage). this technique allows to avoid block allocation
at all for such files and make file's placement more contigoues.

I agree about system fs (/, /boot, /usr, /var), because most of files are
quite small and change rarely.

>>>>> Ed Sweetman (ES) writes:

 ES> Well, it appears that you need about 10+ blocks per extent to see any
 ES> noticable performance gain.  The problem is most files are not large
 ES> enough to achieve this.  Most range from a few kB to a couple mB. High
 ES> activity directories like /tmp and /usr deal mostly with numerous
 ES> small files.  Now the reason i bring this up is that extents basically
 ES> make your fs incompatible with any kernel not compiled with the patch,
 ES> which means if something bad happened and you needed to use a bootable
 ES> cdrom with some safety kernel, it wouldn't be that useful.  for such
 ES> small improvements, it doesn't seem worth the risk to make / or
 ES> directories like /tmp,/var,/usr,/boot,/lib etc, with extents.  The
 ES> files just dont get large enough to make performance gains worth more
 ES> than backward compatibility.

 ES> Now for media, like music and movies and such, this makes a lot of
 ES> sense. Files get large enough so that the block to extent use is very
 ES> high and the files aren't necessary to use the system.  extents are 5
 ES> seconds faster when md5summing a 622MB file than the same file written
 ES> without extents enabled.


 ES> I would not recommend using the patch for system directories only
 ES> because it leaves you with no way to rescue the system and does very
 ES> little in the way of performance for those directories. Ext3 is
 ES> backwards compatible with ext2, this patch seemingly breaks
 ES> that. Because of that it doesn't seem to be ext3 anymore, rather a one
 ES> way compatibility with ext3 with a purely large media bias.


