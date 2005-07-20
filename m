Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVGTTBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVGTTBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 15:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGTTBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 15:01:39 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:24070 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261163AbVGTTBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 15:01:38 -0400
Message-ID: <42DEA00C.7010407@tu-harburg.de>
Date: Wed, 20 Jul 2005 21:03:40 +0200
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       joern@wohnheim.fh-wedel.de
Subject: Re: [PATCH] generic_file_sendpage
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org> <Pine.LNX.4.58.0507150848500.19183@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507150848500.19183@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> "sendfile()" in general I think has been a mistake. It's too specialized,
> and the interface has always sucked.

Ok, you're right. I will have a look at the pipe buffer stuff.

> As Andrew pointed out, it actually
> needs to limit the number of buffers in flight partly because otherwise 
> you have uninterruptible kernel work etc etc.

Hmm, sendfile() uses do_generic_mapping_read() which is calling the 
file_send_actor() per page. The actor calls ->sendpage(). I don't see 
any situation how this could lead to uninterruptible kernel work when 
the sendpage() itself is checking for signals. There are only 2 pages in 
flight in this case.

Jan
