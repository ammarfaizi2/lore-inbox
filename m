Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUCZSMs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 13:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbUCZSMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 13:12:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:54468 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264108AbUCZSLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 13:11:51 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16484.29281.375363.39808@laputa.namesys.com>
Date: Fri, 26 Mar 2004 21:11:45 +0300
To: Jonathan Briggs <jbriggs@esoft.com>
Cc: Reiserfs mail-list <Reiserfs-List@Namesys.COM>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] new reiser4 snapshot released.
In-Reply-To: <1080321833.19218.7.camel@localhost.localdomain>
References: <16484.24086.167505.94478@laputa.namesys.com>
	<1080321833.19218.7.camel@localhost.localdomain>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Briggs writes:
 > On Fri, 2004-03-26 at 09:45, Nikita Danilov wrote:
 > > Hello,
 > > 
 > > new reiser4 snapshot against 2.6.5-rc2 is available at
 > > 
 > > http://www.namesys.com/snapshots/2004.03.26/
 > > 
 > > It is mainly bug-fixing release. See READ.ME for the list of fixes and
 > > caveats.
 > 
 > A definition of fibration:
 > http://mathworld.wolfram.com/Fibration.html

Reiser4 plugin was named this was due to some (arguably vague)
similarity with mathematical fibrations.

 > 
 > I'm going to have to study math for about a year before I understand all
 > that, I think.
 > 
 > It's a good thing we won't have to understand "fiber bundles",
 > "paracompact topological space" and the "homotopy lifting property" to
 > USE Reiser4.
 > 
 > *grin*

Why, of course one has to understand it. Reiser4 refuses to mount unless
supplied with the homotopy group of the tangent bundle of hard drive,
for sure.

 > 
 > If I missed the discussion or a web page, I am sorry.  But could someone
 > post a quick explanation or pointer to one about this fibration plugin? 
 > What does it do and what effects will it have?

Fibration plugin affects how disk blocks are allocated for the files
within the same directory. Basically, in reiser4 all file system data
and meta-data (except for allocator bitmaps) are stored in a single
balanced tree. Every piece of information in the file system (byte of
file data, on-disk inode, directory entry containing file name, etc.)
has a key that allows to locate this information in the tree. This
imposes natural order on all file system data (because keys are just
large integers, and can be compared).

Block allocator tries to allocate blocks in a parent-first tree
order. This means, that things with close keys have chances to be close
to each other on a disk. This leads to the main high-level mechanism
that reiser4 uses to control disk layout: through key assignment.

In particular fibration plugin is called when new name is inserted into
a directory, and, based on a name, selects some (otherwise unused) 7 bits
in a key of directory entry. This allows to "slice" directory content
into "fibers", hence the name.

For example, one possible implementation is to place .o files in one
fiber and all others in another. This significantly speeds compilations
up, because .o files are created close to each other and don't interfere
with sources. Fibrations, and well as other plugins, can be set
per-object, see http://www.namesys.com/v4/pseudo.html for details.

 > 
 > -- 
 > Jonathan Briggs
 > jbriggs@esoft.com
 > 

Nikita.
