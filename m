Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278145AbRJWR6N>; Tue, 23 Oct 2001 13:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278149AbRJWR6E>; Tue, 23 Oct 2001 13:58:04 -0400
Received: from patan.Sun.COM ([192.18.98.43]:62896 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S278145AbRJWR5y>;
	Tue, 23 Oct 2001 13:57:54 -0400
Message-ID: <3BD5AED6.90401C9C@sun.com>
Date: Tue, 23 Oct 2001 10:54:30 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: issue: deleting one IP alias deletes all
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So we've noticed, and taken issue with this behavior.

If you have several IP aliases on an interface (eth0:0, eth0:1, eth0:2) you
get inconsistent behavior when downing them.

* if I 'ifconfig down' eth0:1, I am left with eth0:0 and eth0:2
* if I 'ifconfig down' eth0:0, eth0:1 and eth0:2 go away, too

I assert that this should not happen.  I have a simple patch to fix this
behavior, but I want to know a few things.

* Is this supposed to happen? Why?
* Is it correct that both the real interface and the first alias are marked
as primary (! IFA_F_SECONDARY), while all other aliases are secondary?  It
seems to me that ALL ALIASES should be secondary.  Is this wrong? Why?

Can anyone fill me in?

Thanks
Tim
-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
