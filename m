Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbTLHQwo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265432AbTLHQvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:51:09 -0500
Received: from zimbo.cs.wm.edu ([128.239.2.64]:44430 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S265092AbTLHQtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:49:45 -0500
Date: Mon, 8 Dec 2003 11:48:54 -0500
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: liangbin01@iscas.cn
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: PROBLEM: A Capability LSM Module serious bug
Message-ID: <20031208164854.GA15146@escher.cs.wm.edu>
References: <20031207121151.22328.qmail@abyss.iscas.cn> <20031208150809.GA14068@escher.cs.wm.edu> <20031208163618.8789.qmail@abyss.iscas.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208163618.8789.qmail@abyss.iscas.cn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think patch to capability.c maybe a better way to fix this bug. Because 
> dummy.c is a simple superuser mechanism, capability should be not visible 
> to it. And capability modules may be extended to file system so as to 

The main question is do we declare cap_effective to belong solely to
capability.c, or do we want capability.c to trust previous LSM's
computations of those values?  So, even with the current case, if we
insmod, rmmod, then re-insmod capability, do we want to revoke all
previous cap_* computations?

It seems reasonable for it "belong" to capability.c (and I've heard of
noone else wanting to use it).  I just don't think we've explicitly
declared this to be the case.
