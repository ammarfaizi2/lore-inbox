Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUCCPXS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 10:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCCPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 10:23:13 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:19857 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262479AbUCCPUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 10:20:49 -0500
Date: Wed, 3 Mar 2004 16:22:13 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Krzysztof Halasa <khc@pm.waw.pl>, linuxabi@zytor.com
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
Message-ID: <20040303152213.GA2148@mars.ravnborg.org>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	linuxabi@zytor.com, Chris Friesen <cfriesen@nortelnetworks.com>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <200402291942.45392.mmazur@kernel.pl> <200402292130.55743.mmazur@kernel.pl> <c1tk26$c1o$1@terminus.zytor.com> <200402292221.41977.mmazur@kernel.pl> <yw1xn0711sgw.fsf@kth.se> <40434BD7.9060301@nortelnetworks.com> <m37jy4cuaw.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37jy4cuaw.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Also sent to linuxabi@zytor.com]

On Mon, Mar 01, 2004 at 07:10:31PM +0100, Krzysztof Halasa wrote:
> 
> The "non-problem" here is, IMHO, that the cleaning of kernel headers
> is quite trivial, and thus nobody is interested :-)

The problem is that there is no infrastructure for abi only .h files (mainly).
Matthew Wilcox + others IIRC has already posted a few patches, but I do not see
this happening until 2.7 opens up.

When the proper infrastructure is agreed upon on lot's of people will put some effort
in this janitorial type of work. But imagine all the small mistakes, something we do not
want in 2.6.

IIRC the current agreed scheme is something along the lines of this:

abi/abi-linux/* Userspace relevant parts of include/linux
abi/abi-asm/ symlink to abi/abi-$(ARCH)
abi/abi-i386 i386 specific userland abi
abi/abi-ppc  ppc ....


So a header file in include/linux with a counterpart in abi could look like this:

include/linux/wait.h:
#include <abi-linux/wait.h>

#include <linux/config.h>
typedef struct __wait_queue wait_queue_t;
...


abi/abi-linux/wait.h:
#define WNOHANG         0x00000001
#define WUNTRACED       0x00000002



This proposal meets some resistence related to internal issues such as
renaming of internal types etc.
But in the end the gain from a scheme like this outweights the drawbacks - IMHO. 

And the backward compatible stuff can be located in abi where it may belong -
if really needed.

	Sam
