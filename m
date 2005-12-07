Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbVLGBEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbVLGBEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 20:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVLGBEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 20:04:24 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:23737 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964990AbVLGBEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 20:04:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Wed, 7 Dec 2005 02:05:37 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051205081935.GI22168@hexapodia.org> <20051206121835.GN1770@elf.ucw.cz> <20051206181520.GA21501@hexapodia.org>
In-Reply-To: <20051206181520.GA21501@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512070205.37414.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 6 December 2005 19:15, Andy Isaacson wrote:
}-- snip --{
> 
> I'm suggesting that rather than writing the clean pages out to the
> image, simply make their metadata available to a post-resume userland
> helper.  Something like
> 
> % head -2 /dev/swsusp-helper
> /bin/sh 105-115 192 199-259
> /lib/libc-2.3.2.so 1-250
> 
> where the userland program is expected to use the list of page numbers
> (and getpagesize(2)) to asynchronously page in the working set in an
> ionice'd manner.

The helper is not necessary, I think.

What we can do is to skip blank pages while writing the image and only use
place holders for them in metadata.  Then we can make them blank again
when we load the image into memory.

Still, this would require some considerable changes in the swap-handling
part of swsusp and lots of testing.

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
