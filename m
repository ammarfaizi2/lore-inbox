Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSJMIOx>; Sun, 13 Oct 2002 04:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSJMIOx>; Sun, 13 Oct 2002 04:14:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7053 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261457AbSJMIOw>;
	Sun, 13 Oct 2002 04:14:52 -0400
Date: Sun, 13 Oct 2002 01:13:44 -0700 (PDT)
Message-Id: <20021013.011344.58438240.davem@redhat.com>
To: wagnerjd@prodigy.net
Cc: robm@fastmail.fm, hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org,
       jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <000e01c27290$dd0b5640$7443f4d1@joe>
References: <20021013.005005.41948345.davem@redhat.com>
	<000e01c27290$dd0b5640$7443f4d1@joe>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
   Date: Sun, 13 Oct 2002 03:16:30 -0500

   "SMP locking primitives"? Tell me what that is again?  Oh yeah!  That's
   when the kernel basically gives SMP a timeout and behaves as if there
   was only one processor.
   
   So in effect, I was right.  File processes really do use one and only
   one processor.
   
Not true.  While a block is being allocated on mounted filesystem X
on one cpu, a TCP packet can be being processed on another processor and
a block can be allocated on mounted filesystem Y on another processor.

Actually, it can even be threaded to the point where block allocations
on the same filesystem can occur in parallel as long as it is being
done for different block groups.

So in effect, you're not so right.
