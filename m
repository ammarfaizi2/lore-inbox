Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293692AbSCESdQ>; Tue, 5 Mar 2002 13:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293701AbSCESdH>; Tue, 5 Mar 2002 13:33:07 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:21161 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S293692AbSCEScx>;
	Tue, 5 Mar 2002 13:32:53 -0500
Date: Tue, 5 Mar 2002 18:30:53 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305183053.A27064@fenrus.demon.nl>
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva> <20020305192604.J20606@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020305192604.J20606@dualathlon.random>; from andrea@suse.de on Tue, Mar 05, 2002 at 07:26:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 07:26:04PM +0100, Andrea Arcangeli wrote:

> Another approch would be to add the pages backing the bh into the lru
> too, but then we'd need to mess with the slab and new bitflags, new
> methods and so I don't think it's the best solution. The only good
> reason for putting new kind of entries in the lru would be to age them
> too the same way as the other pages, but we don't need that with the bh
> (they're just in, and we mostly care only about the page age, not the bh
> age).

For 2.5 I kind of like this idea. There is one issue though: to make
this work really well we'd probably need a ->prepareforfreepage()
or similar page op (which for page cache pages can be equal to writepage()
) which the vm can use to prepare this page for freeing.
