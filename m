Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbTJXSLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbTJXSLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 14:11:03 -0400
Received: from mail-08.iinet.net.au ([203.59.3.40]:6280 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262440AbTJXSLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 14:11:00 -0400
Message-ID: <3F996B10.4080307@cyberone.com.au>
Date: Sat, 25 Oct 2003 04:10:24 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Nick's scheduler v17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
http://www.kerneltrap.org/~npiggin/v17/

Still working on SMP and NUMA. Some (maybe) interesting things I put in are
- Sequential CPU balancing so you don't get a big storm of balances 
every 1/4s.
- Balancing is trying to err more on the side of caution, I have to start
  analysing it more thoroughly though.
- Attacked the NUMA balancing code. There should now be less buslocked ops /
  cache pingpongs in some fastpaths. Volanomark likes it, more realistic 
loads
  won't improve so much http://www.kerneltrap.org/~npiggin/v17/volano.png
  This improvement is NUMA only.

I haven't had time to reproduce Cliff's serious reaim performance 
dropoffs so
they're probably still there. I couldn't reproduce Martin's kernbench 
dropoff,
but the 16-way I'm using only has 512K cache which might not show it up.


