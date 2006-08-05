Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422714AbWHECYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWHECYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 22:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161511AbWHECYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 22:24:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59358 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161513AbWHECYF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 22:24:05 -0400
Date: Fri, 4 Aug 2006 22:23:56 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060805022356.GC13393@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805021051.GA13393@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 10:10:51PM -0400, Dave Jones wrote:

 > So I added this diff..
 > 
 > diff --git a/kernel/cpu.c b/kernel/cpu.c
 > index f230f9a..31210a0 100644
 > --- a/kernel/cpu.c
 > +++ b/kernel/cpu.c
 > @@ -31,6 +31,14 @@ void lock_cpu_hotplug(void)
 >  {
 >  	struct task_struct *tsk = current;
 >  
 > +	if (jiffies > HZ * 60) {

....
 
 >  void unlock_cpu_hotplug(void)
 >  {
 > +	if (jiffies > HZ * 120) {
                           ^^^
Duh.  Everything becomes clearer the moment you post a diff to lkml.

		Dave

-- 
http://www.codemonkey.org.uk
