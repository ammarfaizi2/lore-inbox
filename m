Return-Path: <linux-kernel-owner+w=401wt.eu-S932912AbWL0FpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWL0FpQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 00:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932918AbWL0FpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 00:45:16 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34688
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932912AbWL0FpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 00:45:15 -0500
From: Rob Landley <rob@landley.net>
To: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 00:44:11 -0500
User-Agent: KMail/1.9.1
Cc: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <Pine.LNX.4.63.0612261549050.24795@qynat.qvtvafvgr.pbz> <200612270524.36157.vda.linux@googlemail.com>
In-Reply-To: <200612270524.36157.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612270044.12645.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 December 2006 11:24 pm, Denis Vlasenko wrote:
> busybox needs it in order to spawn, for example, gzip/bzip2 helper
> for tar. We know that our own executable has this function.
> How to execute _our own executable_? exec("/proc/self/exe")
> works only if /proc is mounted. I can imagine that some embedded
> people want to be able to not rely on that.

Actually, we added CONFIG_BUSYBOX_EXEC_PATH so you could feed it a different 
path to the busybox executable if you haven't got proc.  It's still a hack, 
and it still breaks when you chroot, but you can use the standalone shell 
without /proc.

Why do people chroot?  To do system recovery using busybox with the standalone 
shell and built-in commands.  They chroot into the damaged root partition to 
run some of the commands in there (shared library paths get a bit twitchy 
without the chroot), but they want to use the built-in busybox commands for 
most of it because PAM and selinux can get screwed up by passing birds, 
brightly colored wallpaper or large flowers, and when they do they interfere 
with everything.

*shrug*  This was a bigger deal a few years ago, before the invention of the 
knoppix CD...

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
