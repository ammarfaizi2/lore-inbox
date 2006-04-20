Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWDTNnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWDTNnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWDTNny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:43:54 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:36749 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750956AbWDTNny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:43:54 -0400
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace
	semaphore
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
In-Reply-To: <20060420132128.GG18604@sergelap.austin.ibm.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com>
	 <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420124647.GD18604@sergelap.austin.ibm.com>
	 <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420132128.GG18604@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 08:48:38 -0400
Message-Id: <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 08:21 -0500, Serge E. Hallyn wrote:
> Tony, do you have any performance measurements?  Both for unconfined and
> confined apps?  Presumably unconfined processes should have 0 performance
> hit, right?

Preferably something that exercises open, mkdir, link... and friends
intensively, not just the old WebStone data that I've seen posted
before.  

But you don't really need the benchmarks - just look at the code, and
think about the implications of allocating a page and calling d_path on
every permission(9) call (on every component) plus from the separate
hooks in the vfs_ helpers and further consider the impact of taking the
dcache lock all the time there.  And look at the iterators being used in
aa_perm_dentry as well as the truly fun ones in aa_link.  All because
they are doing it from LSM hooks that were never intended to be used
this way.

-- 
Stephen Smalley
National Security Agency

