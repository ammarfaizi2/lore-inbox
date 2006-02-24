Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWBXHXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWBXHXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWBXHXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:23:33 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26006 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750789AbWBXHXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:23:33 -0500
Date: Fri, 24 Feb 2006 08:23:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Daniel Barkalow <barkalow@iabervon.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] duplicate #include check for build system
In-Reply-To: <20060221175246.GA9070@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0602240820000.16363@yvahk01.tjqt.qr>
References: <20060221014824.GA19998@MAIL.13thfloor.at>
 <Pine.LNX.4.64.0602210149190.6773@iabervon.org> <20060221175246.GA9070@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think the kernel style is to encourage duplicate includes, rather than 
>> removing them. Removing duplicate includes won't remove any dependancies 
>> (since the includes that they duplicate will remain).
>The style as I have understood it is that each .h file in include/linux/
>are supposed to be self-contained. So it includes what is needs, and the
>'what it needs' are kept small.
>
>Keeping the 'what it needs' part small is a challenge resulting in
>smaller .h files. But also a good way to keep related things together.
>
How far does this go? Consider the following hypothetical case:

---dcache.h---
struct dentry {
   ...
};
---fs.h---
#include "dcache.h"
struct inode {
    struct dentry *de;
};

Since only a pointer to struct dentry is involved, I would compress it to:

---fs.h---
struct dentry;
struct inode {
    struct dentry *de;
};

The fs.h file still "compiles" (gcc -xc fs.h), and there is one file less 
to be read. And since dcache.h in this case here should anyway be included 
in the .c file if *DE is dereferenced, I do not see a problem with this.
Objections?



Jan Engelhardt
-- 
