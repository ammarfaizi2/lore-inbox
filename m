Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUEAVUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUEAVUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUEAVUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 17:20:52 -0400
Received: from colin2.muc.de ([193.149.48.15]:56590 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261405AbUEAVUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 17:20:50 -0400
Date: 1 May 2004 23:20:49 +0200
Date: Sat, 1 May 2004 23:20:49 +0200
From: Andi Kleen <ak@muc.de>
To: Lev Makhlis <mlev@despammed.com>
Cc: Andi Kleen <ak@muc.de>, Michael Brown <mebrown@michaels-house.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATED
Message-ID: <20040501212049.GA78089@colin2.muc.de>
References: <200405011700.44518.mlev@despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405011700.44518.mlev@despammed.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 04:00:44PM -0500, Lev Makhlis wrote:
> > > -- This information is, in the very near future, _not_ going to be
> > > static anymore. There will be systems that update the information in
> > > dynamically during SMIs.
> >
> > That's fine - /dev/mem can handle that too. An user will have to
> > poll for changes anyways, so having it it /proc does not have
> > any advantages.
> 
> One problem is that /dev/mem access isn't atomic.  You need to read
> a pointer, then follow the pointer to read data.  If the pointer changes
> in the middle, you lose.  That said, I don't see any mechanism that
> helps avoid that in kernel, either.
> 

Exactly. The kernel code doesn't help with that.

You could always read everything twice and compare and do that until
it stops changing. I personally think it is overkill, because SMBIOS
information is normally only used for diagnosis, where a rare race
is not that bad.

Also hopefully the SMI handlers will change the thing in a atomic way,
so this may never happen.

-Andi
