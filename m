Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWDRIDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWDRIDu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 04:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWDRIDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 04:03:50 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:15553 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751129AbWDRIDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 04:03:49 -0400
Date: Tue, 18 Apr 2006 17:05:17 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, hugh@veritas.com, linux-kernel@vger.kernel.org,
       lee.schermerhorn@hp.com, linux-mm@kvack.org, taka@valinux.co.jp,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060418170517.b46736d8.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0604172353570.4352@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
	<20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604140945320.18453@schroedinger.engr.sgi.com>
	<20060415090639.dde469e8.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604151040450.25886@schroedinger.engr.sgi.com>
	<20060417091830.bca60006.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604170958100.29732@schroedinger.engr.sgi.com>
	<20060418090439.3e2f0df4.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604171724070.2752@schroedinger.engr.sgi.com>
	<20060418094212.3ece222f.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604171856290.2986@schroedinger.engr.sgi.com>
	<20060418120016.14419e02.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604172011490.3624@schroedinger.engr.sgi.com>
	<20060418123256.41eb56af.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604172353570.4352@schroedinger.engr.sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006 23:58:41 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> Hmmm... Good ideas. I think it could be much simpler like the following 
> patch.
> 
> However, the problem here is how to know that we really took the anon_vma 
> lock and what to do about a page being unmmapped while migrating. This 
> could cause the anon_vma not to be unlocked.
> 
lock dependency here is page_lock(page) -> page's anon_vma->lock.
So, I guess  anon_vma->lock cannot be unlocked by other threads 
if we have page_lock(page).


> I guess we would need to have try_to_unmap return some state information.
What kind of information ?

> I also toyed around with writing an "install_migration_ptes" function 
> which would be called only for anonymous pages and would reduce the 
> changes to try_to_unmap(). However, that also got too complicated.
> 

-Kame


