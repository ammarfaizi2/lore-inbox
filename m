Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269602AbUHZVLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269602AbUHZVLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269673AbUHZVLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:11:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:9721 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269602AbUHZVGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:06:33 -0400
Date: Thu, 26 Aug 2004 14:00:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <57730000.1093554054@flay>
In-Reply-To: <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com><Pine.LNX.4.58.0408261101110.2304@ppc970.osdl.org> <45010000.1093553046@flay> <Pine.LNX.4.58.0408261348500.2304@ppc970.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 26 Aug 2004, Martin J. Bligh wrote:
>> 
>> What would "test -d" and "test -f" return on these magic beasties? I can't
>> think of any combinations that wouldn't confuse the crap out of userspace.
> 
> "It's a feature".
> 
> The S_ISDIR/S_ISREG tests show real information: it shows not only user
> intent ("you should consider this a file, even if it has attributes"), but
> also whether it is a directory or a container.
> 
> And there's a real technical difference there: the streams contained
> within a file are bound to that file. The files contained within a
> directory are _independent_ of that directory. Big difference. HUGE
> difference.
> 
> So it's not confusing. If it tests as a file, you think of it as a file.  
> It may have attributes aka named streams associated with it, and you may
> be able to open those attributes by treating the file as a directory, but
> that doesn't really change the fact that it's a file.
> 
> The _big_ difference is that when you can make the compound object _look_ 
> like a directory, that means that you can now manage the attributes with 
> standard tools. They are still attributes, though.

I think what you're saying is that they'd both return positive, right?

Unfortunately I think lots of code in userspace assumes files / directories
are mutually exclusive conditions, and acts accordingly ... eg:

if [ -f file ]
	do file stuff
else
	do directory stuff
fi.

Now I'm not saying they're not broken ... but seems like a dangerous thing 
to change in the midst of a stable kernel series.

M.

