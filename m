Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVIHP1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVIHP1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbVIHP1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:27:23 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43393 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932694AbVIHP1W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:27:22 -0400
Date: Thu, 8 Sep 2005 17:28:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Budde, Marco" <budde@telos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: libraries and subdirectories
Message-ID: <20050908152819.GA7749@mars.ravnborg.org>
References: <809C13DD6142E74ABE20C65B11A2439809C4C2@www.telos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4C2@www.telos.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 03:40:59PM +0200, Budde, Marco wrote:
> I have a large number of sources files, which I have to
> compile into one kernel module. Let's assume I have the
> following source organisation:
> 
>   main/
>     main_code.c
>   lib1/
>     part1/
>       file_1_1_1.c
>     part2/
>       file_1_2_1.c
>   lib2/
>     part1/
>       file_2_1_1.c
>     part2/
>       file_2_2_1.c
> 
> I would like to build all source files in lib1 into one
> lib.a library and all files in lib2 into a second lib.a
> library.

kbuild is optimised for kernel usage.
And within the kernel only xfs and oprofile (+a few others)
have files spread over more than one directory like in your
example. This is not considered good practice and therefore
kbuild does not document this usage - neither encourage it.

Also kbuild does not support building .a file in the way you
want it to do.

You can do the following:
obj-$(CONFIG_foo) += main/main_code.o
obj-$(CONFIG_foo) += lib1/part1/file_1_1_1.c
obj-$(CONFIG_foo) += lib1/part2/file1_2_1.o

etc.

> 
> At the end I would like to compile the code in main and
> link every together (result should be one kernel module).
> 
> How can I archieve this with kbuild? Its documentation is not
> really deep.
Please point out in what section you miss information and I will try to
update it.
I for one consider the kbuild syntax well documented, but I may be a bit
biased in this respect.

	Sam
