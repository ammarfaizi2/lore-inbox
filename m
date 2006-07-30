Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWG3Rvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWG3Rvc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWG3Rvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:51:32 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:36826 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932383AbWG3Rvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:51:31 -0400
Date: Sun, 30 Jul 2006 19:51:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, agruen@suse.de
Subject: Re: Building external modules against objdirs
Message-ID: <20060730175130.GA23665@mars.ravnborg.org>
References: <200607301846.07797.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301846.07797.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 06:46:07PM +0200, Andi Kleen wrote:
> 
> Hi,
> 
> It looks like building external modules against separate objdirs doesn't work 
> anymore in 2.6.18.
I just tried it out with -linus (from a few hours ago).
$> cd ~/kernel/linux-2.6
$> mkdir ../o
$> make O=../o defconfig
$> make O=../o
...
$> cd ~/kernel/external
$> cat Makefile
obj-m := sam.o
sam-y := sam1.o
EXTRA_CFLAGS := -I$(src)/include

$> make M=`pwd` O=~/kernel/o -C ~/kernel/linux-2.6
make: Entering directory `/home/sam/kernel/linux-2.6'
  LD      /home/sam/kernel/external/built-in.o
  CC [M]  /home/sam/kernel/external/sam1.o
  LD [M]  /home/sam/kernel/external/sam.o
  Building modules, stage 2.
  MODPOST
  CC      /home/sam/kernel/external/sam.mod.o
  LD [M]  /home/sam/kernel/external/sam.ko
make: Leaving directory `/home/sam/kernel/linux-2.6'

So it seems to work out fine here.

Can you check that you really did a 'make prepare' in the relevant
output directory. Previously only the make *config step was needed.

	Sam
