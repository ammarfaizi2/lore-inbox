Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSKLPuc>; Tue, 12 Nov 2002 10:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266589AbSKLPuc>; Tue, 12 Nov 2002 10:50:32 -0500
Received: from ns.suse.de ([213.95.15.193]:52234 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261855AbSKLPub> convert rfc822-to-8bit;
	Tue, 12 Nov 2002 10:50:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Adam Voigt <adam@cryptocomm.com>
Subject: Re: File Limit in Kernel?
Date: Tue, 12 Nov 2002 16:57:20 +0100
User-Agent: KMail/1.4.3
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
In-Reply-To: <1037115535.1439.5.camel@beowulf.cryptocomm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211121657.20437.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 November 2002 16:38, Adam Voigt wrote:
> I have a directory with 39,000 files in it, and I'm trying to use the cp
> command to copy them into another directory, and neither the cp or the
> mv command will work, they both same "argument list too long" when I
> use:
>
> cp -f * /usr/local/www/images
>
> or
>
> mv -f * /usr/local/www/images

Note that this is not a kernel related question. The * in the command line is 
expanded into a list of all entries in the current directory, which results 
in a command line longer than allowed. Try this instead:

find -maxdepth 1 -print0 | \
	xargs -0 --replace=% cp -f % /usr/local/www/images

--Andreas.

