Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269647AbUHZVCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269647AbUHZVCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269657AbUHZVBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:01:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269661AbUHZU5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:57:17 -0400
Date: Thu, 26 Aug 2004 13:54:46 -0700 (PDT)
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
In-Reply-To: <45010000.1093553046@flay>
Message-ID: <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org> <45010000.1093553046@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004, Martin J. Bligh wrote:
> 
> What would "test -d" and "test -f" return on these magic beasties? I can't
> think of any combinations that wouldn't confuse the crap out of userspace.

"It's a feature".

The S_ISDIR/S_ISREG tests show real information: it shows not only user
intent ("you should consider this a file, even if it has attributes"), but
also whether it is a directory or a container.

And there's a real technical difference there: the streams contained
within a file are bound to that file. The files contained within a
directory are _independent_ of that directory. Big difference. HUGE
difference.

So it's not confusing. If it tests as a file, you think of it as a file.  
It may have attributes aka named streams associated with it, and you may
be able to open those attributes by treating the file as a directory, but
that doesn't really change the fact that it's a file.

The _big_ difference is that when you can make the compound object _look_ 
like a directory, that means that you can now manage the attributes with 
standard tools. They are still attributes, though.

		Linus
