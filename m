Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTHTKWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 06:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbTHTKWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 06:22:12 -0400
Received: from ns.suse.de ([195.135.220.2]:56799 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261861AbTHTKWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 06:22:11 -0400
Message-ID: <3F434BD1.9050704@suse.de>
Date: Wed, 20 Aug 2003 12:22:09 +0200
From: Hannes Reinecke <Hannes.Reinecke@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Dumb question: BKL on reboot ?
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

I've got a dumb question: Why is the BKL held on entering sys_reboot() 
in kernel/sys.c:405 ?
It is getting especially interesting on SMP, when one cpu is entering 
sys_reboot, acquires the BKL and then waits (via machine_restart) for 
all other cpus to shut down. If any of the other cpus is executing a 
task which also needs the BKL, we have a nice deadlock.
We've seen this here on 2-way s390, where the other cpu tried to execute 
kupdated() (what did it try that for? Anyway...), which of course 
resulted in a deadlock.

Any enlightenment welcome.

Cheers,

Hannes
P.S.: Please cc me directly, I'm not subscribed.
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Deutschherrnstr. 15-19			+49 911 74053 688
90429 Nürnberg				http://www.suse.de

