Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271892AbTGYDLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 23:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271893AbTGYDLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 23:11:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:3802 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S271892AbTGYDLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 23:11:08 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Net device byte statistics
In-Reply-To: <200307250437.50928.fredrik@dolda2000.cjb.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19ftDj-00016j-00@calista.inka.de>
Date: Fri, 25 Jul 2003 05:26:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200307250437.50928.fredrik@dolda2000.cjb.net> you wrote:
> I almost thought that would be it. I do understand that that code needs to be 
> really clean, but, correct me if I'm wrong, but isn't GCC's long long 
> implementation efficient enough to only add minimal overhead to that?

I think there is mainly an issue with atomic incremets. I am not sure if the
counter can be incremeted concurrently, or if the code path would be
serialized, but there is always the reading side, which may need to retry an
read. Besides that, the counter is in the fast path, so it will add some
delay to packet handling.

I guess a 64bit implementation will need to be a per-cpu solution.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
