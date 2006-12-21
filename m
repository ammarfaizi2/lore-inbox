Return-Path: <linux-kernel-owner+w=401wt.eu-S1422729AbWLUF0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWLUF0t (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWLUF0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:26:49 -0500
Received: from 1wt.eu ([62.212.114.60]:1616 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422729AbWLUF0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:26:48 -0500
Date: Thu, 21 Dec 2006 06:26:43 +0100
From: Willy Tarreau <w@1wt.eu>
To: rrcwjpgr <rrcwjpgr@trashmail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) ?
Message-ID: <20061221052643.GK24090@1wt.eu>
References: <20061218103243.97FF9BB1A02B7@smtp.trashmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061218103243.97FF9BB1A02B7@smtp.trashmail.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Dec 18, 2006 at 11:32:43AM +0100, rrcwjpgr wrote:
> Hello,
> 
> first thanks for your great support on the Linux kernel.
> I have a problem with kernel 2.4.28 and maybe somebody has an idea about my problem. When I type dmesg, I get this error messages:
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> VM: killing process python
> 
> For any kind of reason a python script is killed.
> What this kind of error message means?
> Is this the memory killer?

exactly !

> This would mean that maybe I have a memory leak in the python script?

Generally, when you get this on scripts written in such "high level"
languages, this is because you fill variables with a file which does
not fit into memory. I have often seen this in people's perl scripts,
and sometimes even in shell scripts. Eg: 

  count=$(cat file)

Where file is unexpectedly big, or even a link to /dev/zero. This is
an excellent OOM trigger.

You can use ulimit (man bash) to limit the amount of memory your script
can use. At least it will not make the system go ill.

Regards,
Willy

