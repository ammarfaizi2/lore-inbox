Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbWFKKYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWFKKYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 06:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWFKKYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 06:24:25 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:31372 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751582AbWFKKYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 06:24:24 -0400
Date: Sun, 11 Jun 2006 12:23:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Mikael Pettersson <mikpe@it.uu.se>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       jgarzik <jgarzik@pobox.com>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during
 modpost
In-Reply-To: <20060610203800.GC9502@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0606111221140.13585@yvahk01.tjqt.qr>
References: <200606101211.k5ACBgtl029545@harpo.it.uu.se>
 <20060610121335.447e19f2.rdunlap@xenotime.net> <20060610203800.GC9502@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Doesn't look serious.  init_module() is not __init, but it calls
>> some __init functions and touches some __initdata.
>
>This is the typical case with inconsistent tagging.
>
Worse yet, I once experienced a double-definition error, that is, I had

  __init int init_module(void)  {
      /* module1 */
  }

and, in another .c file,

  __init int init_module(void) {
      /* module2 */
  }

and making them both CONFIG_...=y gave a typical double-definition link 
time error in vmlinux. The proper way (IMO) is

  static __init int blah_init(void) { ... }
  module_init(blah_init);

Then it does not even matter if blah_init is defined in two different 
modules.

>>  
>> -int init_module(void)
>> +int __init init_module(void)
>>  {
>>  	int this_dev, found = 0;
>
>When you anyway touches the driver I suggest to name the function
><module>_init, <module>_cleanup and use module_init(), module_cleanup().


Jan Engelhardt
-- 
