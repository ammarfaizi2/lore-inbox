Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbTHZRAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbTHZRAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:00:21 -0400
Received: from aneto.able.es ([212.97.163.22]:64406 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262752AbTHZRAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:00:15 -0400
Date: Tue, 26 Aug 2003 19:00:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: always_inline for gcc3
Message-ID: <20030826170013.GA1974@werewolf.able.es>
References: <Pine.LNX.4.44.0308260850170.3191@logos.cnet> <20030826162454.GE2023@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030826162454.GE2023@werewolf.able.es>; from jamagallon@able.es on Tue, Aug 26, 2003 at 18:24:54 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.26, J.A. Magallon wrote:
> 
> On 08.26, Marcelo Tosatti wrote:
> > 
> > Can you please explain me what are the differences when using "__inline__
> > __attribute__((always_inline))" and why you chose to use that?
> > 
> 
> gcc3 did not inline big functions, even if they were marked as inline
> Thread:
> http://marc.theaimsgroup.com/?t=103632325600005&r=1&w=2
> Things like memcpy and copy_to/from_user were affected.
> They were not inlined and you got tons of instances in vmlinux.
> 
> An initial patch was proposed by Denis Vlasenko, and refined by
> akpm I think.
> 

A comparison
run 

cat System.map | cut -d' ' -f 3 | sort | uniq -c | sort -nr | head -n 10

for my custom kernel and for a mandrake's standard one (not the late...)

System.map:
     16 __constant_c_and_count_memset
      8 .text.lock.inode
      7 parse_options
      6 __constant_memcpy
      5 devfs_handle
      4 init_once
      3 p.0
      3 debug
      2 want_value
      2 want_numeric

System.map-2.4.21-6mdksmp:
    150 __constant_c_and_count_memset
     81 __constant_memcpy
     45 __constant_copy_to_user
     45 __constant_copy_from_user
     18 level_save.1
     18 layer_save.0
     14 driver
     13 buf.0
      9 config_chipset_for_dma
      6 config_chipset_for_pio


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
