Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWA0REI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWA0REI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWA0REI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:04:08 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:52163 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S932127AbWA0REG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:04:06 -0500
Date: Fri, 27 Jan 2006 18:04:06 +0100
From: Luca <kronos@kronoz.cjb.net>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060127170406.GA6164@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126213611.GA1668@elf.ucw.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> ha scritto:
> Hi!
> 
> On www.sf.net/projects/suspend , there's s2ram.c program for
> suspending machines. It contains whitelist of known machines, along
> with methods to get their video working (similar to
> Doc*/power/video.txt). Unfortunately, video.txt does not allow me to
> fill in whitelist automatically, so I need your help.
> 
> I do not yet have solution for machines that need vbetool; fortunately
> my machines do not need that :-), and it is pretty complex (includes
> x86 emulator).

What about adding something like:

void s2ram_restore(void) {
        if (needed)
                fork_and_exec(vbetool);
}

machine_table could set a global flag or something. It would be
possibile to us an array to carry the informations about what need to be
done on restore, i.e. something like:

void machine_table() {
        if ((!strcmp(sys_vendor, "ASUS")) {
                if (!strcmp(sys_version, "My notebook")) {
                        machine_known();
                        on_resume[NEED_VBETOOL] = 1;
                        return;
                }
        }
}

void s2ram_restore(void) {
        if (on_resume[NEED_VBETOOL])
                fork_and_exec(vbetool);
        if (on_resume[NEED_RADEON_STUFF])
                radeon_stuff();
        if (on_resume[NEED_FOOBAR])
                black_magic();
}

Ugly? Maybe, but you don't have to fiddle with a x86 emulator.

Luca
-- 
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.
