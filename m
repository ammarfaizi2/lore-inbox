Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbVHVWz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbVHVWz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbVHVWz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:55:27 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:63885 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751403AbVHVWz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:55:26 -0400
To: Greg KH <greg@kroah.com>
Cc: Daniel Phillips <phillips@istop.com>, Joel Becker <Joel.Becker@oracle.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permissions don't stick on ConfigFS attributes
References: <200508201050.51982.phillips@istop.com>
	<20050820030117.GA775@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 21 Aug 2005 22:49:20 -0600
In-Reply-To: <20050820030117.GA775@kroah.com> (Greg KH's message of "Fri, 19
 Aug 2005 20:01:17 -0700")
Message-ID: <m18xyuvanj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am confused.  I am beginning to see shades of the devfs problems coming up
again.  sysfs is built to be world readable by everyone who has it
mounted in their namespace.  Writable files in sysfs I have never
understood.

Given that we now have files which do not conform to one uniform
policy for everyone is there any reason why we do not want to allocate
a character device major number for all config values and dynamically
allocate a minor number for each config value?  Giving each config
value its own unique entry under /dev.  

Device nodes for each writable config value trivially handles
persistence and user policy and should be easy to implement in the
kernel.  We already have a policy engine in userspace, udev to handle
all of the chaos. 

Why do we need another mechanism?

Are device nodes out of fashion these days?

Eric
