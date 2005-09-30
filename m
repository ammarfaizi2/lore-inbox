Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030347AbVI3P6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVI3P6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 11:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVI3P6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 11:58:11 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:49332 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030347AbVI3P6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 11:58:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=J9eHQ06AiUBwKHk7w3bO9anO6JoUAeE3bIr1bXuX2ZjmwQI5VyD4kn+muhoW+pazIL1tCJ4wjfWqdBbkDeV+H/GfxvJUWpTkr4KNYtzL3f8jQy1EzUiNrBIcKdAIML0J+FT7yZEs/+9XvihxKVrddIh/bwzBO1HHM17A8zyQGX8=
Date: Fri, 30 Sep 2005 20:09:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: kernel cross-toolchain (Gentoo)
Message-ID: <20050930160911.GA24810@mipter.zuzino.mipt.ru>
References: <20050905035848.GG5155@ZenIV.linux.org.uk> <20050905155522.GA8057@mipter.zuzino.mipt.ru> <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20050930125645.GJ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930125645.GJ7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 01:56:45PM +0100, Al Viro wrote:
> 	Easy cross-toolchain for kernel
> 
> Requirements:
> 	* should be built from the same source as native toolchain with
> minimal patches
> 	* should produce normal packages
> 	* should be buildable with minimal PITA in reasonable time
> 	* package metadata can (and obviously will) differ, but delta should
> be minimal and easy to maintain
> 
> Recipe for FC4 follows; feel free to contribute equivalents for other
> platforms.

Gentoo:

1) Watch for it to install gcc 3.4.*. Chances of successful build are much
   higher than with 3.3. Use --g switch of crossdev (_especially_ with
   s390).
2) -s1 means "binutils + C compiler and nothing more".
3) re ia64
	I was told that "ia64 is known to not cross compile at all due
	to the unwind code". #101626.
4) re m68k
	binutils only. Haven't investigated.
5) re mips64
	Ditto.
6) re mips
	Builds OK. Naive allyesconfig with CROSS_COMPILE=mips-... barfs
	at me violently mentioning some compiler switches.

The following is the list of cross-compilers I successfully use on -git
snapshots. Again, watch for the script to install 3.4.4[-r1].
Always use "crossdev -p ..." first.

# emerge crossdev
# echo 'PORTDIR_OVERLAY="/usr/local/portage"' >>/etc/make.conf
# crossdev -v -s1 -t alpha-unknown-linux-gnu
# crossdev -v -s1 -t arm-unknown-linux-gnu
# crossdev -v -s1 -t hppa-unknown-linux-gnu
# crossdev -v -s1 -t s390-unknown-linux-gnu
# crossdev -v -s1 -t powerpc-unknown-linux-gnu
# crossdev -v -s1 -t powerpc64-unknown-linux-gnu
# crossdev -v -s1 -t sparc-unknown-linux-gnu
# crossdev -v -s1 -t sparc64-unknown-linux-gnu
# crossdev -v -s1 -t sh-unknown-linux-gnu
# crossdev -v -s1 -t sh64-unknown-linux-gnu
# crossdev -v -s1 -t x86_64-unknown-linux-gnu

