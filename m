Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271386AbTHHOvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271388AbTHHOvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:51:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43245 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271389AbTHHOvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:51:15 -0400
Date: Fri, 8 Aug 2003 16:51:08 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6 bug: kconfig implementation doesn't match the spec
Message-ID: <20030808145107.GY16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

the implementation of the !-operator doesn't match the spec in
Documentation/kbuild/kconfig-language.txt

kconfig-language.txt says:

<--  snip  -->

...
           '!' <expr>                           (5)
...
(5) Returns the result of (2-/expr/).
...
An expression can have a value of 'n', 'm' or 'y' (or 0, 1, 2
respectively for calculations). A menu entry becomes visible when it's
expression evaluates to 'm' or 'y'.
...

<--  snip  -->

The current implementation evaluates !m to 0 instead of 1.

An example:

config FOO
        tristate
        default m

config BAR
        tristate
        default y if !FOO
        default n


According to the kconfig spec BAR should be y, but the implementation in
2.6.0-mm5 sets BAR to n.

BTW:
The semantics of the implemention seems to be a bit less surprising 
than the semantics of the spec.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

