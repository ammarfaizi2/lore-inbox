Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWBYC5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWBYC5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWBYC5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:57:52 -0500
Received: from xenotime.net ([66.160.160.81]:49546 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932522AbWBYC5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:57:52 -0500
Date: Fri, 24 Feb 2006 18:59:02 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: sam@ravnborg.org, barkalow@iabervon.org, herbert@13thfloor.at,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] duplicate #include check for build system
Message-Id: <20060224185902.fd2a43f5.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0602240820000.16363@yvahk01.tjqt.qr>
References: <20060221014824.GA19998@MAIL.13thfloor.at>
	<Pine.LNX.4.64.0602210149190.6773@iabervon.org>
	<20060221175246.GA9070@mars.ravnborg.org>
	<Pine.LNX.4.61.0602240820000.16363@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006 08:23:23 +0100 (MET) Jan Engelhardt wrote:

> >> I think the kernel style is to encourage duplicate includes, rather than 
> >> removing them. Removing duplicate includes won't remove any dependancies 
> >> (since the includes that they duplicate will remain).
> >The style as I have understood it is that each .h file in include/linux/
> >are supposed to be self-contained. So it includes what is needs, and the
> >'what it needs' are kept small.
> >
> >Keeping the 'what it needs' part small is a challenge resulting in
> >smaller .h files. But also a good way to keep related things together.
> >
> How far does this go? Consider the following hypothetical case:
> 
> ---dcache.h---
> struct dentry {
>    ...
> };
> ---fs.h---
> #include "dcache.h"
> struct inode {
>     struct dentry *de;
> };
> 
> Since only a pointer to struct dentry is involved, I would compress it to:
> 
> ---fs.h---
> struct dentry;
> struct inode {
>     struct dentry *de;
> };
> 
> The fs.h file still "compiles" (gcc -xc fs.h), and there is one file less 
> to be read. And since dcache.h in this case here should anyway be included 
> in the .c file if *DE is dereferenced, I do not see a problem with this.
> Objections?

Nope, your method is good & correct AFAIAC.

---
~Randy
