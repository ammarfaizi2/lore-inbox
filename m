Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSAITsE>; Wed, 9 Jan 2002 14:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288979AbSAITro>; Wed, 9 Jan 2002 14:47:44 -0500
Received: from [216.151.155.108] ([216.151.155.108]:17419 "EHLO
	varsoon.denali.to") by vger.kernel.org with ESMTP
	id <S288978AbSAITri>; Wed, 9 Jan 2002 14:47:38 -0500
To: Rob Landley <landley@trommello.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: can we make anonymous memory non-EXECUTABLE?
In-Reply-To: <Pine.LNX.4.33L.0201090049390.2985-100000@imladris.surriel.com>
	<3C3BB05D.1040501@zytor.com>
	<200201091919.g09JJtA26375@snark.thyrsus.com>
From: Doug McNaught <doug@wireboard.com>
Date: 09 Jan 2002 14:47:32 -0500
In-Reply-To: Rob Landley's message of "Wed, 9 Jan 2002 06:32:39 -0500"
Message-ID: <m3666b8fxn.fsf@varsoon.denali.to>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> Glibc does mmap instead of brk because theoretically brk can leave wasted 
> memory between fragments, although apparently nobody's ever seen more than 
> 10% waste in a live program, and the speed penality of taking a soft page 
> fault at access time to muck about with the page tables is a LOT bigger than 
> 10%...

The other reason glibc uses mmap() is because your shared libraries
are (usually) mapped smack dab in the middle of your address space.
brk() assumes a contiguous heap, so when it hits your libraries, it
has to stop, even if there is a gig of VM above the libs.  mmap() can
give you an arbitrary chunk of the address space, so glibc uses it for
'large' allocations.

-Doug
-- 
Let us cross over the river, and rest under the shade of the trees.
   --T. J. Jackson, 1863
