Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWBMIMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWBMIMD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWBMIMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:12:03 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57809 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751228AbWBMIMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:12:01 -0500
Date: Mon, 13 Feb 2006 08:11:51 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Willy Tarreau <willy@w.ods.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Linda Walsh <lkml@tlinx.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
Message-ID: <20060213081151.GZ27946@ftp.linux.org.uk>
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org> <20060213000803.GY27946@ftp.linux.org.uk> <43EFD8BF.1040205@tlinx.org> <20060213073746.GG11380@w.ods.org> <1139816896.2997.19.camel@laptopd505.fenrus.org> <20060213080331.GH11380@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213080331.GH11380@w.ods.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 09:03:31AM +0100, Willy Tarreau wrote:
> Hi Arjan,
> 
> On Mon, Feb 13, 2006 at 08:48:15AM +0100, Arjan van de Ven wrote:
> > 
> > > I don't know exactly why recursion is used to follow symlinks,
> > > which at first thought seems like it could be iterated, but
> > > I've not checked the code, there certainly are specific reasons
> > > for this.
> > 
> > the problem is not following symlinks. the problem is symlinks to
> > symlink to symlink to ...
> 
> That's how I understood it, but I only thought about easy cases. Now,
> I can imagine cross-FS links and I don't see an easy way to resolve
> them :-/

The real problem is that there is no promise that resolution of a symlink
consists of following some path.  It's a very common case, all right,
but not the only one.  And trying to take that into account makes iterative
schemes very ugly.
