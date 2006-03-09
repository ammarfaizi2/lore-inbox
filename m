Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbWCIEiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWCIEiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWCIEiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:38:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46049 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932677AbWCIEiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:38:14 -0500
Date: Wed, 8 Mar 2006 23:38:04 -0500
From: Dave Jones <davej@redhat.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: filldir[64] oddness
Message-ID: <20060309043804.GB23148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060309042744.GA23148@redhat.com> <20060308.203204.115109492.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308.203204.115109492.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 08:32:04PM -0800, David S. Miller wrote:
 > From: Dave Jones <davej@redhat.com>
 > Date: Wed, 8 Mar 2006 23:27:44 -0500
 > 
 > > #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))
 > > #define ROUND_UP(x) (((x)+sizeof(long)-1) & ~(sizeof(long)-1))
 > > 
 > > 140  	static int filldir(void * __buf, const char * name, int namlen, loff_t offset,
 > > 141  			   ino_t ino, unsigned int d_type)
 > > 142  	{
 > > 143  		struct linux_dirent __user * dirent;
 > > 144  		struct getdents_callback * buf = (struct getdents_callback *) __buf
 > > 145  		int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
 > > 
 > > How come that NAME_OFFSET isn't causing an oops when
 > > it dereferences stackjunk->d_name ?
 > 
 > d_name a char[] array, and we're just doing pointer arithmetic
 > here.  It's the same as "offsetof(d_name, struct linux_dirent)"
 > or something like that.

Duh, yes. Of course.

 > I think coverity is being trigger happy in this case :-)

agreed.

		Dave

-- 
http://www.codemonkey.org.uk
