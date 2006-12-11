Return-Path: <linux-kernel-owner+w=401wt.eu-S937327AbWLKQyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937327AbWLKQyP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937330AbWLKQyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:54:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43375 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937327AbWLKQyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:54:14 -0500
Date: Mon, 11 Dec 2006 08:44:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <20061211163333.GA17947@aepfle.de>
Message-ID: <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Olaf Hering wrote:
> 
> Please revert this change.

Well, that "get_kernel_version" is definitely buggered, and should be 
fixed. And we do want the new behaviour for /proc/version.

So I don't think we should revert it, but we should:

 - use separate strings for /proc/version and the static string. Because 
   there just isn't any point to sharing it that much, and the static 
   string might as well be made into __initdata, so you don't even lose 
   the 20-odd bytes of memory at run-time ;)

 - strongly encourage "get_kernel_version" users to just stop using that 
   crap. Ask the build system for the version instead or something, don't 
   expect to dig it out of the binary (if you create an RPM for any other 
   package, you sure as _hell_ don't start doing strings on the binary and 
   try to figure out what the kernel is - you do it as part of the build)

What crud. I'm even slightly inclined to just let SLES9 be broken, just to 
let people know how unacceptable it is to look for strings in kernel 
binaries. But sadly, I don't think the poor users should be penalized for 
some idiotic SLES developers bad taste.

		Linus
