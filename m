Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269701AbUHZVXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269701AbUHZVXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269555AbUHZVTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:19:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:53166 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269675AbUHZVPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:15:11 -0400
Date: Thu, 26 Aug 2004 14:13:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <57730000.1093554054@flay>
Message-ID: <Pine.LNX.4.58.0408261402400.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com><Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org>
 <45010000.1093553046@flay> <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>
 <57730000.1093554054@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Martin J. Bligh wrote:
> 
> I think what you're saying is that they'd both return positive, right?

No. I'd say that a file would look like a file, even if it has attributes.

It wouldn't show as a directory at all - unless you start looking at 
attributes. Because it really _is_ a file, and it's "directory aspect" is 
really nothing but a way to make its named streams visible.

So you really should consider it a perfectly regular file, and so only 
S_ISREG() will return true, and S_ISDIR() will return false.

Think of it this way: when you add a named attribute to current files 
using the xattr interfaces, do you start thinking of the file as a 
directory? No. Even though it actually now is a starting point for finding 
more information.

It's just that thanks to it's directory aspect, people and apps that 
_care_ about the attributes suddenly can trivially access them. You can 
access them in shell scripts, you can access them in programs, you can 
access them in perl. With no special knowledge necessary.

Remember: in the file-as-directory model, we're always talking about just 
_one_ object. That one object just happens to have namd streams or 
attributes or whatever you want to call them associated with it, and you 
can _see_ them through the normal directory interfaces. But that doesn't 
really make the object a "directory". It's still a file.

In other words, the "directory" part is just a _view_ into the file. A
view that potentially exposes a lot _more_ of the file, but we're still
talking about the same file.

In contrast, a S_IFDIR-like _directory_ is something else entirely. When 
you view the things in that, you aren't looking at data "inside" the 
directory. You're looking at somethign totally independent.

		Linus
