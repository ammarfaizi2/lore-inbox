Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWCCVLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWCCVLU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWCCVLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:11:20 -0500
Received: from smtp103.rog.mail.re2.yahoo.com ([206.190.36.81]:20838 "HELO
	smtp103.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750731AbWCCVLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:11:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=A4nL15v143Rdea34pS2BVQWD5aRBnMZmLGv28R7tS6M4dcAJXCZ3gHrIcugwpqRpZXSzgtw2Zb1x6OpHsjKlP2gfHcg2MTDp3UxtkLH5XuhdFyvZEcfwcdWDDr8Q2iMeg4pWZctqgwBPpGC6FjAdAEVH+fEYO4rZ5hzJv/i0/bg=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060303175542.GT9295@stusta.de>
References: <20060302173840.GB9295@stusta.de>
	 <9a8748490603021228k7ad1fb5gd931d9778307ca58@mail.gmail.com>
	 <20060302203245.GD9295@stusta.de> <1141335521.3582.14.camel@Rainsong.home>
	 <20060302214423.GI9295@stusta.de> <1141361097.3582.40.camel@Rainsong.home>
	 <20060303114642.GO9295@stusta.de> <1141397326.3582.57.camel@Rainsong.home>
	 <20060303151026.GQ9295@stusta.de> <1141408251.11092.4.camel@Rainsong.home>
	 <20060303175542.GT9295@stusta.de>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 16:11:18 -0500
Message-Id: <1141420278.11092.56.camel@Rainsong.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 18:55 +0100, Adrian Bunk wrote:
> On Fri, Mar 03, 2006 at 12:50:51PM -0500, James C. Georgas wrote:
> > On Fri, 2006-03-03 at 16:10 +0100, Adrian Bunk wrote:
> > > On Fri, Mar 03, 2006 at 09:48:46AM -0500, James C. Georgas wrote:
> > > > 
> > > > Ok, if I understand you correctly now, there is a function defined in
> > > > another part of the kernel, which is _called_ by AF_UNIX, and it is for
> > > > this function that the other part of the kernel must export a symbol?
> > > > 
> > > > But you only need to do this so that modules can use the function,
> > > > because if, instead, the driver is built in, then the function is
> > > > directly in scope, and can be called explicitly?
> > > 
> > > Correct.
> > 
> > Ok, I understand.
> > 
> > What are the exported symbols, and where are they defined?
> > 
> > I read the post you linked to earlier, but I got nothing when I grepped
> > for "get_max_files", which was mentioned.
> 
> You must look at the latest -mm.

OK, I see. It's a wrapper function for files_stat.max_files, which was
the current exported symbol in the mainline kernel.

It's used here, basically, to cap the number of sockets in existence, to
prevent rogue processes from chewing up all your memory.

If I understand your position correctly, you believe that it is
inappropriate for this symbol to be publicly visible to a subsystem that
is dynamically linked, but that it is OK for it to be publicly visible
to the same subsystem, when it is statically linked instead.

Did I misunderstand you?

-- 
James C. Georgas <jgeorgas@rogers.com>

