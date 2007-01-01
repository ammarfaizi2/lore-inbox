Return-Path: <linux-kernel-owner+w=401wt.eu-S1755213AbXAAPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213AbXAAPAr (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbXAAPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:00:47 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:46199 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213AbXAAPAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:00:46 -0500
Date: Mon, 1 Jan 2007 23:59:43 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Using _syscall3 to manipulate files in a driver
Message-ID: <20070101145943.GA11787@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
References: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910612310913v191b519fpa179bfc56f140baf@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 12:13:52PM -0500, Jon Smirl wrote:
> I have the source code for a vendor written driver that is targeted at
> 2.6.9. It includes this and then proceeds to manipulate files from the
> driver.
> 
> asmlinkage _syscall3(int,write,int,fd,const char *,buf,off_t,count)
> asmlinkage _syscall3(int,read,int,fd,char *,buf,off_t,count)
> asmlinkage _syscall3(int,open,const char *,file,int,flag,int,mode)
> asmlinkage _syscall1(int,close,int,fd)
> 
> What is the simplest way to get open/close/read/write working under
> 2.6.20-rc2? I know this is horrible and shouldn't be done, I just want
> to get the driver working long enough to see if it is worth saving.
> I'm on x86.
> 
In-kernel syscalls were removed by f5738ceed46782aea7663d62cb6398eb05fc4ce0.
You can stub them back in if you want a quick and lame fix for the
driver, but you're better off rewriting it to behave sensibly rather than
wasting your time on vendor hacks.
