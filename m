Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUIFXEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUIFXEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 19:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUIFXEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 19:04:48 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:14314 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267433AbUIFXEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 19:04:46 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Hans Reiser <reiser@namesys.com>
Date: Tue, 7 Sep 2004 09:04:33 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16700.60673.453455.255327@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Alexander Zarochentcev <zam@namesys.com>,
       vs <vs@thebsh.namesys.com>
Subject: Re: [PATCH - EXPERIMENTAL] files with forks in the VFS
In-Reply-To: message from Hans Reiser on Sunday September 5
References: <16699.44411.361938.856856@cse.unsw.edu.au>
	<413BFCB5.4010608@namesys.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 5, reiser@namesys.com wrote:
> Neil Brown wrote:
> 
> >As a followup to the multi-branching threads about reiser4, I would
> >like to present this patch for discussion and exploration.
> >It implements files with fork (which are quite different to files that
> >provide different views via a subdirectory structure).
> >  
> >
> How are they different?  Having a distinguished file is consistent with 
> the reiser4 approach.
> 

They are different at least in my perception.  It is possible that a
common abstraction and a common implementation could support them
both, though I am slightly sceptical.

On the one hand, you have a name space within a file which provides
access to information that is not part of that file but is only
loosely associated with it:  an icon for a desktop app, documentation
for a program, a collection of fonts that a document uses.

On the other hand, you have a name space within a file which provides
alternate views onto information that already exists within that
file:  "unzip" which presents the file uncompressed, "tar" which
explodes a tar achieve, "tag" which shows tags in a multi-media
file. "elf" which exposes sections of an ELF executable.

In the first case, the subordinate files should clearly be writable,
and should be backed up along with the main file.
In the second case, it is not clear that subordinate files should or
could be writable in general (though there may well be specific
cases), and the data does not need to be backed up.

In the first case, the extra semantic only applies to files, not
directories (allowing a directory to have extra streams is nothing
new).
In the second case, the extra semantic should apply to directories as
well (as there may we be different views you might want on a
directory). 

NeilBrown
