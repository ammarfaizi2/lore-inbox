Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267622AbUHJRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267622AbUHJRBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267605AbUHJQ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:57:53 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9625 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267610AbUHJQz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:55:26 -0400
Message-ID: <4118FE9D.2050304@sgi.com>
Date: Tue, 10 Aug 2004 11:58:05 -0500
From: Josh Aas <josha@sgi.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, steiner@sgi.com
Subject: bkl cleanup in do_sysctl
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to hear people's thoughts on replacing the bkl in do_sysctl 
with a localized spin lock that protects the sysctl structures. Instead 
of grabbing the bkl, anyone that needs to mess with those values could 
grab the localized lock (1 to protect all structures). Such a localized 
lock would allow us to get rid of bkl usage in at least one other place 
as well (do_coredump). In order to do this though, we would have to make 
sure all code that grabs the bkl instead of the localized lock while 
using sysctl values switches to the new lock. Might be a big job, but 
perhaps it would be a good one to start after 2.6.8 is out the door.

Thoughts? Comments?

-- 
Josh Aas
Silicon Graphics, Inc. (SGI)
Linux System Software
651-683-3068
