Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbRDFRDe>; Fri, 6 Apr 2001 13:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132118AbRDFRDY>; Fri, 6 Apr 2001 13:03:24 -0400
Received: from ns.suse.de ([213.95.15.193]:47114 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132054AbRDFRDP>;
	Fri, 6 Apr 2001 13:03:15 -0400
Date: Fri, 6 Apr 2001 19:02:32 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2 times faster rawio and several fixes (2.4.3aa3)
Message-ID: <20010406190232.A20258@gruyere.muc.suse.de>
In-Reply-To: <20010406183440.B28118@athlon.random> <20010406190701.H28118@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010406190701.H28118@athlon.random>; from andrea@suse.de on Fri, Apr 06, 2001 at 07:07:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2001 at 07:07:01PM +0200, Andrea Arcangeli wrote:
> However we can probably stay with the 512k atomic I/O otherwise the iobuf
> structure will grow again of an order of 2. With 512k of atomic I/O the kiovec
> structure is just 8756 in size (infact probably I should allocate some of the
> structures dynamically instead of statics inside the kiobuf.. as it is now
> with my patch it's not very reliable as it needs an allocation of order 2).

8756bytes wastes most of an order 2 allocation. Wouldn't it make more sense to 
round it up to 16k to use the four pages fully ?  (if the increased atomic
size doesn't have other bad effects -- i guess it's no problem anymore to 
lock down that much memory?) 

-Andi

