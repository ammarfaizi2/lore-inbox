Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWIPLr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWIPLr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 07:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWIPLr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 07:47:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932388AbWIPLrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 07:47:55 -0400
Subject: Re: + allow-proc-configgz-to-be-built-as-a-module.patch added to
	-mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mm-commits@vger.kernel.org,
       rossb@google.com, akpm@google.com, sam@ravnborg.org
In-Reply-To: <20060915154752.d7bdb8a0.rdunlap@xenotime.net>
References: <200609152158.k8FLw7ud018089@shell0.pdx.osdl.net>
	 <20060915154752.d7bdb8a0.rdunlap@xenotime.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 16 Sep 2006 13:47:30 +0200
Message-Id: <1158407250.5152.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In some ways this is a bit risky, because the .config which is used for
> > compiling kernel/configs.c isn't necessarily the same as the .config which was
> > used to build vmlinux.
> 
> and that's why a module wasn't allowed.
> It's not worth the risk IMO.
Hi,

I agree with Randy here; this does not make sense. Either you're ok with
a small risk that the config doesn't match the kernel (and you
use /boot/config-<version> as put there by make install and by all
distributions) or you want a 100.00% guarantee and use /proc/config.gz.
Making the later unreliable (even if that is a CHOICE a user of it
cannot find this out, in the config.gz he sees the CONFIG option for
this may say =y even if the actual config has it as module!. So users of
this are now in the cold).

One hack we could do is make an md5sum or similar of the config and
stick that somewhere which is built in and always available (proc or
sysfs or something like that); that can be used to validate any config
basically to be "correct matching". In fact we could even make it
(optionally) part of the VERMAGIC to avoid any kind of mismatch at all.


Greetings,
   Arjan van de Ven

