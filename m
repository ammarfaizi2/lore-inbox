Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273019AbTGaNNl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273020AbTGaNNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:13:41 -0400
Received: from [213.24.247.63] ([213.24.247.63]:49045 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S273019AbTGaNNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:13:38 -0400
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: Nico Schottelius <nico-kernel@schottelius.org>
Subject: Re: fun or real: proc interface for module handling?
Date: Thu, 31 Jul 2003 17:13:24 +0400
User-Agent: KMail/1.5.2
References: <20030731121248.GQ264@schottelius.org>
In-Reply-To: <20030731121248.GQ264@schottelius.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307311713.24788.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
On Thursday 31 July 2003 16:12, Nico Schottelius wrote:
> Hello!
>
> I was just joking around here, but what do you think about this idea:
>
> A proc interface for module handling:
>    /proc/mods/
>    /proc/mods/<module-name>/<link-to-the-modules-use-us>
>
> So we could try to load a module with
>    mkdir /proc/mods/ipv6
> and remove it and every module which uses us with
>    rm -r /proc/mods/ipv6
>

Well, this idea itsel is quite neat, and could sometimes save lots of time 
(esp. when dealing with serious modules' deps). I would like to propose 
slightly different appropach:
cp /lib/modules/2.6.0-test2/kernel/drivers/somedriver.ko /proc/modtree
is equivalent to insmod somedriver.ko (or modprobe ?). (How one could pass 
module params in the former case ?). 
Then, if no other module depends on it, then this entry (under /proc/modtree) 
is a file, otherwise its a directory, with all depending modules also either 
files or dirs. So, module removal would be as simple as 
[ -f /proc/modtree/somedriver ] && rm /proc/modtree/somedriver || \
[ -d /proc/modtree/somedriver ] && rm -rf /proc/modtree/somedriver/* ; \
rm /proc/modtree/somedriver


-- 
With all the best, yarick at relex dot ru.

