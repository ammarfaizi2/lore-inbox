Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932670AbWCIEcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbWCIEcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWCIEcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:32:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10974
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932670AbWCIEcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:32:05 -0500
Date: Wed, 08 Mar 2006 20:32:04 -0800 (PST)
Message-Id: <20060308.203204.115109492.davem@davemloft.net>
To: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060309042744.GA23148@redhat.com>
References: <20060309042744.GA23148@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 8 Mar 2006 23:27:44 -0500

> #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
> #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
> 
> 140  	static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
> 141  			   ino_t ino, unsigned int d_type)
> 142  	{
> 143  		struct linux_dirent __user * dirent;
> 144  		struct getdents_callback * buf = (struct getdents_callback *) __buf
> 145  		int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
> 
> How come that NAME_OFFSET isn't causing an oops when
> it dereferences stackjunk->d_name ?

d_name a char[] array, and we're just doing pointer arithmetic
here.  It's the same as "offsetof(d_name, struct linux_dirent)"
or something like that.

I think coverity is being trigger happy in this case :-)
