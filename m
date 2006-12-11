Return-Path: <linux-kernel-owner+w=401wt.eu-S937119AbWLKQd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937119AbWLKQd2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937135AbWLKQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:33:28 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45803 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937119AbWLKQd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:33:27 -0500
Date: Mon, 11 Dec 2006 17:33:34 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211163333.GA17947@aepfle.de>
References: <457D750C.9060807@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <457D750C.9060807@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Andy Whitcroft wrote:

> 	# get_kernel_version /boot/vmlinuz-autobench
> 	%s

It expects the content from `cat /proc/version`:

...
      for (i = 0; i < in; i++)
        if (buffer[i] == 'L' && buffer[i+1] == 'i' &&
            buffer[i+2] == 'n' && buffer[i+3] == 'u' &&
            buffer[i+4] == 'x' && buffer[i+5] == ' ' &&
            buffer[i+6] == 'v' && buffer[i+7] == 'e' &&
            buffer[i+8] == 'r' && buffer[i+9] == 's' &&
            buffer[i+10] == 'i' && buffer[i+11] == 'o' &&
            buffer[i+12] == 'n' && buffer[i+13] == ' ')
          { 
            found = 1;
            break;
          } 
...

The change breaks the assumption:
 const char linux_banner[] =
-       "Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-       LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+       "Linux version %s (" LINUX_COMPILE_BY "@"
+       LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") %s\n";

Please revert this change.
