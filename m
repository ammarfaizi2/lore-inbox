Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268683AbTCCSEJ>; Mon, 3 Mar 2003 13:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268680AbTCCSEI>; Mon, 3 Mar 2003 13:04:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:37035 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268670AbTCCSED>;
	Mon, 3 Mar 2003 13:04:03 -0500
Date: Mon, 03 Mar 2003 09:56:41 -0800 (PST)
Message-Id: <20030303.095641.87696857.davem@redhat.com>
To: cfriesen@nortelnetworks.com
Cc: terje.eggestad@scali.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3E6399F1.10303@nortelnetworks.com>
References: <3E638C51.2000904@nortelnetworks.com>
	<20030303.085504.105424448.davem@redhat.com>
	<3E6399F1.10303@nortelnetworks.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Friesen <cfriesen@nortelnetworks.com>
   Date: Mon, 03 Mar 2003 13:07:45 -0500
   
   Suppose I have a process that waits on UDP packets, the unified local 
   IPC that we're discussing, other unix sockets, and stdin.  It's awfully 
   nice if the local IPC can be handled using the same select/poll 
   mechanism as all the other messaging.

So use UDP, you still haven't backed up your performance
claims.  Experiment, set the SO_NO_CHECK socket option to
"1" and see if that makes a difference performance wise
for local clients.

But if performance is "so important", then you shouldn't really be
shying away from the shared memory suggestion and nothing is going to
top that (it eliminates all the copies, using flat out AF_UNIX over
UDP only truly eliminates some header processing, nothing more, the
copies are still there with AF_UNIX).
