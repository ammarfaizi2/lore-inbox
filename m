Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316310AbSEODU1>; Tue, 14 May 2002 23:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316312AbSEODU0>; Tue, 14 May 2002 23:20:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47341 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316310AbSEODUY>;
	Tue, 14 May 2002 23:20:24 -0400
Date: Tue, 14 May 2002 20:07:32 -0700 (PDT)
Message-Id: <20020514.200732.118765024.davem@redhat.com>
To: Dale.Farnsworth@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip autoconfig skips ipv6 dev initialization
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020514223230.GL15751@cuzco.az.mvista.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Dale Farnsworth" <Dale.Farnsworth@mvista.com>
   Date: Tue, 14 May 2002 15:32:30 -0700
   
   A fix is to do the ipv6 initialization before ipv4 initialization.
   The included patch resolved it for me.  Please apply or suggest an
   alternative.

Ordering of object files does not guarentee ordering of initcalls.
The linker can legitimately move things around in the final object
which will change the initcall ordering, the linker will in fact
do this on many platforms for performance purposes.

This bug can only be fixed correctly in 2.5.x which has a
prioritization scheme for initcalls.
