Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZKqi>; Fri, 26 Jan 2001 05:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129172AbRAZKqS>; Fri, 26 Jan 2001 05:46:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:980 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129143AbRAZKqQ>;
	Fri, 26 Jan 2001 05:46:16 -0500
Date: Fri, 26 Jan 2001 10:43:46 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: Jeff Hartmann <jhartmann@valinux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: ioremap_nocache problem?
Message-ID: <20010126104346.D11607@redhat.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> <20010123165117Z131182-221+34@kanga.kvack.org> <20010125155345Z131181-221+38@kanga.kvack.org> <20010125165001Z132264-460+11@vger.kernel.org> <E14LpvQ-0008Pw-00@mail.valinux.com> <3A7066A1.5030608@valinux.com> <20010125175027Z131219-222+40@kanga.kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010125175027Z131219-222+40@kanga.kvack.org>; from ttabi@interactivesi.com on Thu, Jan 25, 2001 at 11:53:01AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 25, 2001 at 11:53:01AM -0600, Timur Tabi wrote:
> 
> > As in an MMIO aperture?  If its MMIO on the bus you should be able to 
> > just call ioremap with the bus address.  By nature of it being outside 
> > of real ram, it should automatically be uncached (unless you've set an 
> > MTRR over that region saying otherwise).
> 
> It's not outside of real RAM.  The device is inside real RAM (it sits on the
> DIMM itself), but I need to poke through the entire 4GB range to see how it
> responds.

kmap() is designed for that, not ioremap().  Is it absolutely
essential that your mapping is uncached?  If so, extending kmap() to
support kmap_nocache() would seem to make a lot more sense than using
ioremap(): kmap is there for temporarily poking around in high memory,
whereas ioremap is really intended to be used for persistent maps.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
