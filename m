Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263031AbTHaWrG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 18:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTHaWrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 18:47:05 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60868 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263031AbTHaWqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 18:46:09 -0400
Subject: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Zach, Yoav" <yoav.zach@intel.com>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
References: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062369910.12059.1.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Sun, 31 Aug 2003 23:45:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-31 at 22:41, Zach, Yoav wrote:
> The proposed patch solves a problem for interpreters that need to
> execute a non-readable file, which cannot be read in userland. To handle

You've added a security hole.

> + 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
> +		/* if the binary should be opened on behalf of the
> +		 * interpreter than keep it open and assign it a
> descriptor */
> + 		fd = get_unused_fd ();
> + 		if (fd < 0) {

At this point your file table might be shared with another thread (see
binfmt_elf in 2.4 - I dunno if 2.6 has been fixed for this exploit yet).
You need to unshare the file table before you modify it during the exec.

Otherwise it looks fairly sane.

