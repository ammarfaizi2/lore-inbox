Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTAURbL>; Tue, 21 Jan 2003 12:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTAURbL>; Tue, 21 Jan 2003 12:31:11 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:12192 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S267154AbTAURbK>; Tue, 21 Jan 2003 12:31:10 -0500
Date: Tue, 21 Jan 2003 09:40:02 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Dave Jones <davej@codemonkey.org.uk>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       Wim Coekaerts <Wim.Coekaerts@oracle.com>
Subject: Re: [PATCH][2.5] hangcheck-timer
Message-ID: <20030121174001.GV20972@ca-server1.us.oracle.com>
References: <20030121011954.GO20972@ca-server1.us.oracle.com> <20030121125039.GA5997@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030121125039.GA5997@codemonkey.org.uk>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 12:50:39PM +0000, Dave Jones wrote:
>  I'm puzzled. What does this do that softdog.c doesn't ?

	First, softdog.c requires userspace interaction.  Second, softdog.c
relies on jiffies.  If the system goes out to lunch via udelay() or
another hardware call that freezes the CPUs for a bit, jiffies does not
increment.  The system could be frozen for two minutes (qla2x00 used to
do this for 90 seconds) and softdog.c never notices, because jiffies
hasn't counted a single second during this time.

Joel


-- 

"You cannot bring about prosperity by discouraging thrift. You cannot
 strengthen the weak by weakening the strong. You cannot help the wage
 earner by pulling down the wage payer. You cannot further the
 brotherhood of man by encouraging class hatred. You cannot help the
 poor by destroying the rich. You cannot build character and courage by
 taking away a man's initiative and independence. You cannot help men
 permanently by doing for them what they could and should do for themselves."
	- Abraham Lincoln 


Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
