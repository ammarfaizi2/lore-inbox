Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272378AbTGYXVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTGYXVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:21:55 -0400
Received: from quechua.inka.de ([193.197.184.2]:43719 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S272378AbTGYXVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:21:54 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
In-Reply-To: <1059172995.16255.6.camel@sherbert>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19gC7T-0001Sa-00@calista.inka.de>
Date: Sat, 26 Jul 2003 01:37:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1059172995.16255.6.camel@sherbert> you wrote:
> 1. ->cleanup() - unregister IRQ handlers, timers, etc.
...
> surely if nothing is registered and all CPUs do a voluntary schedule()
> then there can be no chance of calling back in to the module.

no, because data structures might contain pointers, especially in handles.
So unregistering will avoid new handlers to jump into the code, but it will
not avoid that existing objets (i.e. open handles) exist. And exactly for
those the refcounting is used.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
