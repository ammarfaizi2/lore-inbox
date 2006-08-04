Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWHDFr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWHDFr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWHDFrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:47:40 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:50097 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161024AbWHDFrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:47:15 -0400
Date: Fri, 04 Aug 2006 14:46:53 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: kmannth@us.ibm.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH] memory hotadd fixes [4/5] avoid check in acpi
Cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net,
       akpm@osdl.org
In-Reply-To: <20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com>
References: <1154661826.5925.92.camel@keithlap> <20060804124847.610791b5.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.063
Message-Id: <20060804141705.D5C4.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 03 Aug 2006 20:23:46 -0700
> keith mannthey <kmannth@us.ibm.com> wrote:
> 
> > On Fri, 2006-08-04 at 12:13 +0900, KAMEZAWA Hiroyuki wrote:
> > > On Thu, 03 Aug 2006 20:00:08 -0700
> > > keith mannthey <kmannth@us.ibm.com> wrote:
> > > 
> > > 
> > > > > >   What protecting is there for calling add_memory on an already present
> > > > > > memory range?  
> > > > > > 
> > > > > For example, considering ia64, which has 1Gbytes section...
> > > > 
> > > > Maybe 1gb sections is too large?  
> > > > 
> > > ia64 machines sometimes to have crazy big memory...so 1gb section is requested.
> > > Configurable section_size for small machines was rejected in old days.
> > 
> > My HW supports about 512gb...... 
> > 
> 
> > What if you add a partial section.  Then online in sysfs and add another
> > section?  messy....
> Once a section is onlined, it cannot be re-onlined. My patch just helps memory holes
> in "a" memory hot add event.
> Our firmware team tells us they may create small memory holes in contiguous memory...

I would like to mention about it more.

We asked not to make memory hole to firmware team before.
But, conclusion became NO. 
Because this hole is made for memory partial broken case. 
Current ACPI doesn't have any spec to tell which memory area is
broken. So, _CRS must return address range of only sane memory area.
In addition, partial broken area should be smaller as much as possible.
This is why he mention about memory hole.

BTW, I prefer that we should fix only bug at this time for 2.6.18.
But, I really confusing that current patches are for only bug fix or
including for small memory hole case.
IIRC, small memory hole need more works. So, it should be 2.6.19
or later. Right?
Kame-san, could you divide between just fix patch and considering
small hole case? Or all of patches are for only bug fix?

Bye.

-- 
Yasunori Goto 


