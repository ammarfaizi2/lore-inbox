Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSI3Ukm>; Mon, 30 Sep 2002 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbSI3Ukm>; Mon, 30 Sep 2002 16:40:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30132 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261377AbSI3Ukk>;
	Mon, 30 Sep 2002 16:40:40 -0400
Date: Mon, 30 Sep 2002 13:39:04 -0700 (PDT)
Message-Id: <20020930.133904.96601483.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: bunk@fs.tum.de, jochen@scram.de, linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 compile errors on Alpha
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033391751.16468.51.camel@irongate.swansea.linux.org.uk>
References: <1033389340.16337.14.camel@irongate.swansea.linux.org.uk>
	<20020930.052555.123500588.davem@redhat.com>
	<1033391751.16468.51.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 30 Sep 2002 14:15:50 +0100
   
   Because I was looking over the gettimeoffset code and forgot that
   gettimeofday itself takes the xtime_lock 8)

It used to be possible to implement this lockless using a $(sizeof
xtime)-bit load.  But once you start adding complications such as
wall_jiffies, it isn't feasible anymore.

The next idea is to have a tick cookie that could later be converted
to/from a full timeval.  This trick doesn't work on things like Alpha
where the guarenteed life of the tick is only 6 seconds or something
like that.

Most of the time the timestamp isn't even used.

If someone can propose other ideas I'm ready and listening :-)
