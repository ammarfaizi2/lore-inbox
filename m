Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271390AbTHHO6J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271394AbTHHO6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:58:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30957 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271390AbTHHO6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:58:06 -0400
Date: Fri, 8 Aug 2003 16:57:59 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6: kconfig handling of recursive dependencies could be improved
Message-ID: <20030808145758.GZ16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

I tried to implement a "select at least one of these options" using the 
following Kconfig snippet:

config A
        bool "a"

config B
        bool "b"

config C
        bool
        default y if A=n && B=n
        select A
        select B

"make *config" says
  Warning! Found recursive dependency: A C A
  Warning! Found recursive dependency: C A C B

and handles it a bit strange.

Yes, there is a limited recursion, but it's a finite recursion and I 
don't know of any other way to express this in the current kconfig 
language.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

