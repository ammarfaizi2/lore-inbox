Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTLDAbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLDAbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:31:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50190 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262569AbTLDAb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:31:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: pivot_root off an initramfs broken
Date: 3 Dec 2003 16:30:58 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bqlv82$nms$1@cesium.transmeta.com>
References: <1070496272.8280.443.camel@plato.i.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1070496272.8280.443.camel@plato.i.bork.org>
By author:    Martin Hicks <mort@wildopensource.com>
In newsgroup: linux.dev.kernel
> 
> If I boot a 2.6 kernel that first execs /sbin/kinit on the initramfs,
> does some setup (mostly to find the real root filesystem), then
> pivot_roots over to the real root filesystem and execs /sbin/init the
> kernel spins inside check_mnt() while mounting /proc in the initscripts.
> 

The initramfs is the "real root" -- you shouldn't pivot_root from it,
instead you should mount the new root on top of it.

This makes cleaning up a bit of an issue -- the proposed rootfs
mount_single patch takes care of that -- but it can also be done by
leaving a cleanup process with cwd inside the initramfs with would use
relative paths to clean up.

Something like this:

	  mount / /dev/real_root_whatever
	  ( rm -rf . ) &
	  exec /sbin/init "$@"

	  -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
