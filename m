Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTF0OIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 10:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTF0OIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 10:08:10 -0400
Received: from aneto.able.es ([212.97.163.22]:38309 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264328AbTF0OIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 10:08:07 -0400
Date: Fri, 27 Jun 2003 16:22:20 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix inlining with gcc3
Message-ID: <20030627142220.GC3242@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva> <20030626230824.GM3827@werewolf.able.es> <1056711001.4348.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1056711001.4348.20.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Jun 27, 2003 at 12:50:02 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.27, Alan Cox wrote:
> On Gwe, 2003-06-27 at 00:08, J.A. Magallon wrote:
> > This fixes inlining (really, not-inlining) with gcc3. How about next -pre ?
> 
> Benchmark that before you blindly assume its right. Gcc not inlining large
> stuff actually appears to be _smarter_ than the authors of the code
> 

Let's be clear, I just collect patches that I think are interesting. The
original post by Andrew Morton <akpm@digeo.com> is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104695003008386&w=2

Quoting it:

shrinks my 3.2.1-compiled kernel text by about 64 kbytes:

   text    data     bss     dec     hex filename
3316138  574844  726816 4617798  467646 vmlinux-before
3249255  555436  727204 4531895  4526b7 vmlinux-after

mnm:/tmp> nm vmlinux-before|grep __constant_c_and_count_memset | wc
    233     699    9553
mnm:/tmp> nm vmlinux-after|grep __constant_c_and_count_memset | wc
     13      39     533

And I also remember other posts, by other author of a similar patch, that
claimed some critical functions not being inlined due to size (memcpys..).
Will try to look original info about that...
...here it is:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103632312702693&w=2


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
