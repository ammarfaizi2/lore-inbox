Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbVJ1U2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbVJ1U2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbVJ1U2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:28:07 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:26146 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750719AbVJ1U2F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:28:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XrVsiZd6cSFgdXEv34oiGZfkYt/juU/qu+NrgvDm3Yhua5QlBIBp9LLkU1YvvDyLu+tYB+jczuBSrZgjndvW6cZKDUu7xxz7IFUlNnMhFUq321Nb3ygUSqSR71xMd4JmAzRr7yi0hUw1Y6zgkQ2sYkTMh0RrW7igHK2tDfk9GWg=
Message-ID: <89e9feae0510281328hac26b2ct22bb466ee5a51d36@mail.gmail.com>
Date: Fri, 28 Oct 2005 15:28:05 -0500
From: Dannie Stanley <dannie.stanley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: autofs timeout and large map
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may have discovered a bug.  But perhaps I overlooked
something -- looking for advice.

I have generated a DIRECT map file and defined it in /etc/auto.master.
 My direct mappings look like this (located in /etc/auto.virtual):

   /virtual/USERNAME \
      /public --bind 127.0.0.1:/usr/local/files/public \
      /private --bind 127.0.0.1:/usr/local/files/USERNAME

My /etc/auto.virtual file has 1345 entries very similar to the example
provided  (not wrapped like the example above).  Everything works like
expected for the first mount.  When the mount timeout expires,  the
mount will not auto remount.  When I try to `ls`, it gives the error:

   "No such file or directory"

When --ghost is enabled most directories look like this when autofs
first starts:

   drwxrwxr-x    2 virtual  virtual      4096 Oct 28 14:45 private

However after the timeout they look like this:

   dr-xr-xr-x    2 root root      0 Oct 28 14:45 private

Once I restart autofs it mounts again fine the first time.  For now I
have set my timeout to 24 hours which functions as a work-around but
clutters up my mounted filesystems.

My system is in production and I can't recreate the problem right now
lest I interrupt users.  I have done my best to recreate the actual
directory listings and error messages that I saw but they may not 100%
accurate as they are from memory.


Thanks for any advice,
Dannie

--
Dannie M. Stanley

"The Feynman Problem-Solving Algorithm: (1) write down the problem;
(2) think very hard; (3) write down the answer." - Murray Gell-Mann
