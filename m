Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269432AbUHZTLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269432AbUHZTLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269416AbUHZTKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:10:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46818 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269374AbUHZTDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:03:44 -0400
Date: Thu, 26 Aug 2004 14:59:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Diego Calleja <diegocg@teleline.es>, <jamie@shareable.org>,
       <christophe@saout.de>, <vda@port.imtp.ilyichevsk.odessa.ua>,
       <christer@weinigel.se>, <spam@tnonline.net>, <akpm@osdl.org>,
       <wichert@wiggy.net>, <jra@samba.org>, <reiser@namesys.com>,
       <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <flx@namesys.com>,
       <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <Pine.LNX.4.58.0408261149510.2304@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0408261457320.27909-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Linus Torvalds wrote:
> On Thu, 26 Aug 2004, Rik van Riel wrote:
> > 
> > So you'd have both a file and a directory that just happen
> > to have the same name ?  How would this work in the dcache?
> 
> There would be only one entry in the dcache. The lookup will select 
> whether it opens the file or the directory based on O_DIRECTORY (and 
> usage, of course - if it's in the middle of a path, it obviously needs to 
> be opened as a directory regardless).

Hmmm, I just straced  "cp /bin/bash /tmp".
One line stood out as a potential problem:

open("/tmp/bash", O_WRONLY|O_CREAT|O_LARGEFILE, 0100755) = 4

What do we do with O_CREAT ?

Do we always allow both a directory and a file to be created with
the same name ?

Does this create a new class of "symlink attack" style security
holes ?


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

