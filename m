Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310402AbSCPTFr>; Sat, 16 Mar 2002 14:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310508AbSCPTFa>; Sat, 16 Mar 2002 14:05:30 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:59406 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S310402AbSCPTFW>; Sat, 16 Mar 2002 14:05:22 -0500
Message-ID: <3C9396F5.7319AB27@linux-m68k.org>
Date: Sat, 16 Mar 2002 20:03:17 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: alternative linux configurator prototype
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At http://www.xs4all.nl/~zippel/lc.tar.gz you can find a prototype for a
new linux configurator (see the included README for build/use
information). It has reached a point, where it's becoming usable and I
need some feedback on how/if to continue.

In the first place I wanted to address the problems which came up in
discussion about cml2. So how does it compare to cml2?
1. It's written in C (except the X interface that is in C++ because it
uses qt), so it's really fast.
2. As I convert the current cml1 configuration, it represents pretty
much the same information (and I don't have to maintain lots of new
rules).
3. It's less complex, but IMO sufficient for basic kernel configuration
and all information for a single configuration symbol is at a single
place.

The last point is the most important one and needs some more
explanation, I could have lived with the other problems, but this this
one motivated me to write this tool. I think Eric tries to solve too
many problems at once and this also caused the opposition in previous
discussions. There are basically two problems:
1. Which information is required to compile a driver into the kernel?
2. Which information is needed from/by the user to compile a kernel?
I only try to solve the first problem, Eric also tries to solve the
second problem, but the mistake he made here is to mix up these two
problems. Autoconfiguration is an important problem, but it must be kept
optional, whereas the first problem must be solved, otherwise the kernel
won't even compile. Keeping the problems separate simplifies also the
needed solutions.

Anyway, everyone can now check himself, which solution he prefers. What
I need to know now is, if and how we join both efforts. It's possible
everyone prefers now Eric's cml2 and thinks that my approach is too
simple.

BTW my configurator has a nice new feature: tristate choices. It solves
some problems IMO more elegant than cml1 or cml2. Save the following as
config.new and try yourself. :)

config MODULES
  boolean "module support"

config SYS
  tristate "SYS"
  help
  some subsystem

choice
  prompt "ABC"
  default A
  depends SYS
  #try also to disable this
  optional
  help
  abc

config A
  tristate "A"
  help
  a

config A1
  boolean "A1"
  depends A
  help
  a1

config B
  tristate "B"
  help
  b

config B1
  boolean "B1"
  depends B
  help
  b1

config C
  boolean "C"
  help
  c

config C1
  boolean "C1"
  depends C
  help
  c1

endchoice

bye, Roman
