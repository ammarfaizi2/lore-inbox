Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316957AbSIEFzG>; Thu, 5 Sep 2002 01:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317012AbSIEFzG>; Thu, 5 Sep 2002 01:55:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39653 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316957AbSIEFzF>;
	Thu, 5 Sep 2002 01:55:05 -0400
Date: Wed, 04 Sep 2002 22:52:34 -0700 (PDT)
Message-Id: <20020904.225234.103129147.davem@redhat.com>
To: green@namesys.com
Cc: szepe@pinerecords.com, mason@suse.com, reiser@namesys.com,
       shaggy@austin.ibm.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905095638.B5351@namesys.com>
References: <20020904.223651.79770866.davem@redhat.com>
	<20020905054858.GI24323@louise.pinerecords.com>
	<20020905095638.B5351@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oleg Drokin <green@namesys.com>
   Date: Thu, 5 Sep 2002 09:56:38 +0400
   
   On Thu, Sep 05, 2002 at 07:48:58AM +0200, Tomas Szepe wrote:
   > >    Does the internal reiserfs nlink value translate directly
   > >    to what stat() puts in st_nlink?
   > > It really doesn't matter.  Even if you have some huge value that can't
   > > be represented in st_nlink, you can report to the user that st_nlink
   > > is NLINK_MAX.
   > > This is one possible solution to this whole problem.
   >
   > And a pretty straightforward one, too. Convert the internal reiserfs
   > link stuff to an unsigned short, find NLINK_MAX using the code I posted
   
   Too bad it is 32bit nlink field in on disk format ;)
   
We're only talking about what the user is told is the
nlink value, not what you happen to compute and put/get
from disk.

Your nlink can be legitimately 128-bits if you want, it
still can be made to work :-)

   > last night (or maybe simply grab it from userspace includes) and add
   > a check to your stat() code to return NLINK_MAX if necessary.
   
   Ok, I think I will rework it to something sensible, because current code is
   somewhat a mess and corrupt correct nlink value on overflows. Hm.
   
Ok.

Franks a lot,
David S. Miller
davem@redhat.com
