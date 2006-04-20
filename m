Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDTRhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDTRhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWDTRhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:37:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63645 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbWDTRhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:37:36 -0400
Date: Thu, 20 Apr 2006 18:37:17 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
Message-ID: <20060420173717.GI24520@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 12:53:35PM +0300, Pekka J Enberg wrote:
> The problem is that lvremove program hangs in 'D' state forever with the 
> above commit for snapshots. I have included little more detail below.

The program might hang, but the system shouldn't now: run 'dmsetup
info -c', look for devices with names ending in '-cow' that are in the
suspended state and run 'dmsetup resume' on them.

> lvm2  2.01.04-5
> device-mapper 1.01.00-4

Upgrade!

Without the set of patches that included the one you identified,
whenever you ran 'lvcreate -s' the kernel was unable to give you any
guarantee the operation would succeed.  In the worst failure mode the
system would hang or oops, and the fix required this subtle interface
change.

Alasdair
-- 
agk@redhat.com
