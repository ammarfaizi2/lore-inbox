Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266391AbRGBHRa>; Mon, 2 Jul 2001 03:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266392AbRGBHRU>; Mon, 2 Jul 2001 03:17:20 -0400
Received: from imladris.infradead.org ([194.205.184.45]:11027 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S266391AbRGBHRF>;
	Mon, 2 Jul 2001 03:17:05 -0400
Date: Mon, 2 Jul 2001 08:16:50 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Keith Owens <kaos@ocs.com.au>
cc: Russell King <rmk@arm.linux.org.uk>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
In-Reply-To: <21374.994034344@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0107020810340.18977-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith.

 >> Can I suggest you re-read your comment and the points you quoted
 >> and said are correct. As a DIRECT logical consequence of "(1)
 >> and (3) are correct" (as you phrased it), we get the conclusion
 >> that any config lines that depend on "if some arch is set" (as
 >> you phrased it) are in the architecture-specific config files.
 >> This leads DIRECTLY to the conclusion that ANY lines dependant
 >> on a particular architecture that are not in the
 >> architecture-specific config files are a bug in the kernel
 >> config scripts.

 > No.  We want network drivers to be in the network menu, SCSI
 > drivers in the SCSI menu etc.  Some of those drivers are
 > restricted to some architectures but putting them in the arch
 > config splits the logical flow of selection and duplicates text.
 > Look at the repeated SCSI code in some of the arch configs.

That's a direct consequence of the policy quoted in paragraph (3) and
NOT an error in the logic. It's why I'm against the current policy.

 >> 2. dep_arch_tristate CONFIG_var CONFIG_arch [CONFIG_other_var...]

 > dep_arch_tristate ' AM79C961A support' CONFIG_ARM_AM79C961A \
 >	$CONFIG_ARCH_ACORN $CONFIG_NET_ETHERNET

 > fails your code.  $CONFIG_ARCH_ACORN is undefined,
 > $CONFIG_NET_ETHERNET is 'y'.  dep_arch_tristate is invoked with
 > 3 (not 4 parameters), text, CONFIG_ARM_AM79C961A and 'y'.  The
 > intervening undefined variable disappears in shell scripts.

You're not thinking clearly. Try the following simple fix to that:

 Q> dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A \
 Q>	"$CONFIG_ARCH_ACORN" $CONFIG_NET_ETHERNET

That adds only two extra characters, neither conspicuous, and PASSES
my code.

Best wishes from Riley.

