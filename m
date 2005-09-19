Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932692AbVISVKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbVISVKK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVISVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:10:09 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:57576 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932692AbVISVKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:10:07 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17199.10558.939696.765980@gargle.gargle.HOWL>
Date: Tue, 20 Sep 2005 01:10:22 +0400
To: stephen.pollei@gmail.com
Cc: Alexander Zarochentcev <zam@namesys.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
In-Reply-To: <feed8cdd05091912362ac13f3e@mail.gmail.com>
References: <432AFB44.9060707@namesys.com>
	<200509171416.21047.vda@ilport.com.ua>
	<17197.15183.235861.655720@gargle.gargle.HOWL>
	<feed8cdd05091912362ac13f3e@mail.gmail.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Pollei writes:
 > On 9/18/05, Nikita Danilov <nikita@clusterfs.com> wrote:
 > > Denis Vlasenko writes:
 > >  > On Friday 16 September 2005 20:05, Hans Reiser wrote:
 > >  > You can declare functions even if you never use them.
 > >  > Thus here you can avoid using #if/#endif:
 > > It's other way around: declaration is guarded by the preprocessor
 > > conditional so that nobody accidentally use znode_is_loaded() outside of
 > > the debugging mode.
 > Except it doesn't disallow someone from using znode_is_loaded, if you
 > wanted to do that you would have done

I just described why conditionals are used here. You can trust me: I
wrote that code. :-)

 > #if defined(REISER4_DEBUG) || defined(WHATEVER_ELSE)
 > int znode_is_loaded(const znode * node /* znode to query */ );
 > #else
 > #define znode_is_loaded(I_dont_care_you_are_going_to_) \
 >    } )die(]0now[>anyway<}}}}}}*bye*}
 > #endif
 > That way instead of silently(or -Wmissing-prototypes gving a warning)
 > quessing at a prototype and *maybe* geting a link time error, you get
 > a nice compile-time bomb-out.

Maybe, but kernel developers are supposed to watch for compiler
messages. People who use that technique definitely do.

 > 
 > So unless you have -Wmissing-prototypes and -Werror set then your
 > #if/#endif does very little indeed, especially with the size of kernel
 > it's easy to ignore yet another warning even if the missing-prototype
 > warning was set.

It's enough to monitor your own code, rather than the whole kernel.

Nikita.
