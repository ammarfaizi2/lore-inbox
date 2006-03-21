Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWCUXf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWCUXf3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWCUXf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:35:29 -0500
Received: from elvira.its.uu.se ([130.238.164.5]:43242 "EHLO
	elvira.ekonomikum.uu.se") by vger.kernel.org with ESMTP
	id S965149AbWCUXf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:35:29 -0500
From: "Alfred M. Szmidt" <ams@gnu.org>
To: Olivier Galibert <galibert@pobox.com>
CC: galibert@pobox.com, tytso@mit.edu, sct@redhat.com, adilger@clusterfs.com,
       sho@bsd.tnes.nec.co.jp, cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Laurent.Vivier@bull.net,
       cascardo@minaslivre.org
In-reply-to: <20060321230516.GB45303@dspnet.fr.eu.org> (message from Olivier
	Galibert on Wed, 22 Mar 2006 00:05:16 +0100)
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Reply-to: ams@gnu.org
References: <02bc01c648f2$bd35e830$4168010a@bsd.tnes.nec.co.jp> <20060316183549.GK30801@schatzie.adilger.int> <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org> <20060321230516.GB45303@dspnet.fr.eu.org>
Message-Id: <20060321233517.6211C44031@Psilocybe.Update.UU.SE>
Date: Wed, 22 Mar 2006 00:35:17 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   > Hurd is definitely using the translator field, and I only
   > recently discovered they are using it to point at a disk block
   > where the name of the translator program (I'm not 100% sure, but
   > I think it's a generic, out-of-band, #! sort of functionality).

   Translators on directories are a combo of automount+userland
   filesystem, with the addition on having them saved in the
   mounted-on filesystem.  Rather nice actually.  Replacing /etc/fstab
   with local-to-the-mountpoint information has some charm.  I'm not
   sure if translator-on-files actually exist.

You can set a translator on a file or a directory, it doesn't matter.
Anything that is accessed through the file-system is a translator.
/dev/null is a translator, symbolic links can be[0] translators,
/dev/hd0s1 (/dev/hda1 in GNU/Linux) is a translator, ...

[0]: They are usually implemented directly into the file-system so you
don't end up spawning a new processes for each symlink.  But if the
file-system in question doesn't support symlinks you can always use
the symlink translator to get symlinks.  This will work for all
file-systems as long as you do not wish to have it persitant across
reboots, then you need passive translator support (which is what those
fields in ext2 are for among other things).

Happy hacking.
