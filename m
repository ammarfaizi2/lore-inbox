Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbULFN4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbULFN4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULFN4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:56:14 -0500
Received: from v6.netlin.pl ([62.121.136.6]:39432 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261526AbULFN4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:56:12 -0500
Message-ID: <41B464B3.8020807@pointblue.com.pl>
Date: Mon, 06 Dec 2004 14:54:59 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Cc: coreteam@netfilter.org
Subject: ip contrack problem, not strictly followed RFC, DoS very much possible
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list

There is little bug, eversince, no author would agree to correct it 
(dunno why) in ip_conntrack_proto_tcp.c:91:
unsigned long ip_ct_tcp_timeout_established =   5 DAYS;

Making it 5 days, makes linux router vournable to (D)DoS attacks. You 
can fill out conntrack hash tables very quickly, making it virtually 
dead. This computer will only respond to direct action, from keyboard, 
com port. This is insane, it just blocks it self, and does nothing, no 
fallback scenario, nothing.
As far as I remember ( I have to look and find exact place where it's 
writen ), RFC specifies this timeout as max 100s. 5 days is insane, and 
no argumentation will explain it. I would suggest changing it to 100 
SECS and remove line:
#define DAYS * 24 HOURS

as it won't be used anymore.

If someone has argumentation for 5 days timeout, please speak out. In 
everyday life, router, desktop, server usage 100s is enough there, and 
makes my life easier, as many other linux admins.

Thanks.

-- 
GJ
