Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266374AbRGBFwe>; Mon, 2 Jul 2001 01:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266376AbRGBFwY>; Mon, 2 Jul 2001 01:52:24 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:4333 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266374AbRGBFwK>; Mon, 2 Jul 2001 01:52:10 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 1 Jul 2001 22:52:04 -0700
Message-Id: <200107020552.WAA02457@adam.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, rhw@MemAlpha.CX,
        rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, 1 Jul 2001 21:46:04 -0700, 
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>Can you even write a hypothetical example?

>if [ "$CONFIG_foo" = "n" -a "$CONFIG_bar" = "n" ]; then
>  define_bool "$CONFIG_ALLOW_foo_bar n
>fi
>....
>dep_tristate CONFIG_baz $CONFIG_ALLOW_foo_bar

	In linux-2.4.6-pre8, there are only three configuration variables
that are defined with an indented 'define_bool' statement
(CONFIG_BLK_DEV_IDE{DMA,PCI}, and CONFIG_PCI), and the conditional
code execute by all "if" statements in all of the config.in files
appears to be indented (or at least the first statement in the block
is indented).  None of these three variables has the semantics that
I think you you described above.

	If you want to check, I determined this by the following shell
commands:

% find . -iname config.in | xargs egrep dep_tristate | tr '   ' '\n\n' | egrep '^\$CONFIG_' | sort -u > /tmp/config-dependencies 
% find . -iname config.in | xargs egrep '^[   ].*define_bool' | fgrep -f /tmp/config-dependencies  | awk '{print $(NF-1)}' | sort -u
CONFIG_BLK_DEV_IDEDMA
CONFIG_BLK_DEV_IDEPCI
CONFIG_PCI
% find /usr/src/linux/ -iname config.in | xargs egrep -A 2 ^if | egrep -v -e -- | egrep '^-[^         ]'
%
 

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
