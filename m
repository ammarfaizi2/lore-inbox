Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVKGOkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVKGOkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVKGOkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:40:09 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:5624 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbVKGOkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:40:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=aYQ+J+/Y1y8BicWzRW6rBH14D1F7leqrcNGuWgZX2r92a9+RgvbUpFS1JAEElxMFiEW+aqqMHwG5HDGXpDsK2wm2RT+RuyOya7PG2CXSWtE1/Htoo4kUCyyBrrDc5fXAs+deK6uczHM/ypPnTE5AZsJdwSVih5UUrwwLPnFKb7U=
Date: Mon, 7 Nov 2005 17:53:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jan Beulich <JBeulich@novell.com>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slightly enhance cross builds
Message-ID: <20051107145324.GB20786@mipter.zuzino.mipt.ru>
References: <436F5D96.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F5D96.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:58:46PM +0100, Jan Beulich wrote:
> This adds functionality to default CROSS_COMPILE to a sensible value
> when cross-building (so one doesn't always have to specify this on the
> make command line)

Put something like this into your ~/bin and forget. Or use Al's kmk
script: ftp://ftp.linux.org.uk/pub/people/viro/

$ cat ~/bin/cross-compile
#!/bin/sh

case "$#" in
0)
	echo "usage: cross-compile ARCH ..." >&2
	exit 1
	;;
esac

ARCH="$1"
shift
case $ARCH in
alpha|arm|m68k|s390|sh|sh64|sparc|sparc64|x86_64)
	CROSS_COMPILE=$ARCH-unknown-linux-gnu-
	;;
parisc)
	CROSS_COMPILE=hppa-unknown-linux-gnu-
	;;
ppc)
	CROSS_COMPILE=powerpc-unknown-linux-gnu-
	;;
ppc64)
	CROSS_COMPILE=powerpc64-unknown-linux-gnu-
	;;
*)
	echo "cross-compile: -ENOCROSSCOMPILER for $ARCH" >&2
	exit 1
	;;
esac
make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE "$@"

