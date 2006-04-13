Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWDMLfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWDMLfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWDMLfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:35:05 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:21697 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S964885AbWDMLfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:35:04 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Dave Dillow <dave@thedillows.org>
Subject: Re: [PATCH] deinline a few large functions in vlan code v2
Date: Thu, 13 Apr 2006 13:32:50 +0200
User-Agent: KMail/1.9.1
Cc: Denis Vlasenko <vda@ilport.com.ua>, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604121155.55561.vda@ilport.com.ua> <1144862325.18319.32.camel@dillow.idleaire.com>
In-Reply-To: <1144862325.18319.32.camel@dillow.idleaire.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131332.51784.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Wednesday, 12. April 2006 19:18, Dave Dillow wrote:
> you've left the spin_locks in, and have more #ifdefs.

Ok, I can refactor your driver to even remove this and reduce it to exaxtly 
two ifdef sections for your driver. Acceptable?
 
> Regardless, I remain opposed to this particular instance of bloat 
> busting. While both patches have improved in style, they remove a useful 
> feature and make the code less clean, for no net gain.

s/useful feature/unreachable code/g

> On SMP FC4, typhoon.ko has a text size of 68330, so you need to cut 2794 
> bytes to see an actual difference in memory usage for a module. Non-SMP 
> it is 67741, so there you only need to cut 2205 bytes to get a win.

   text    data     bss     dec     hex filename
  62079     973       4   63056    f650 no-vlan/drivers/net/typhoon.o
  62654     973       4   63631    f88f vlan/drivers/net/typhoon.o

with allyesconfig (minus CONFIG_INFO) and my patches applied.
So maybe the uninlining is enough. Gain after this is just 575 bytes here.


Regards

Ingo Oeser
