Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWCONAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWCONAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbWCONAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:00:17 -0500
Received: from cantor.suse.de ([195.135.220.2]:56715 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751698AbWCONAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:00:16 -0500
Date: Wed, 15 Mar 2006 12:02:52 +0100
From: Stefan Seyfried <seife@suse.de>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, christiand59@web.de
Subject: Re: /dev/stderr gets unlinked 8]
Message-ID: <20060315110252.GB31317@suse.de>
References: <200603141213.00077.vda@ilport.com.ua> <200603141411.11121.christiand59@web.de> <200603141535.57978.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603141535.57978.vda@ilport.com.ua>
X-Operating-System: Novell Linux Desktop 10 (i586), Kernel 2.6.16-rc5-git9-2-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 03:35:57PM +0200, Denis Vlasenko wrote:
 
> Mysql people are strange. For example, their daemon does not want to die
> on SIGTERM, this makes it harder to run it under daemontools.

Well, daemontools are equally strange ;-))

> Also it drops privileges BEFORE it opens logfiles (--log=xxx).
> I cannot get it to log stuff on stderr:
> 
> echo "* Starting mysqld"
> env - \
> setuidgid root \
> mysqld \
>     --defaults-file="$PWD/my.cnf" \
>     --user="$user" \
>     --datadir="$var/data" \
>     --tmpdir="$var/tmp" \
>     --socket="$PWD/mysql.socket" \
>     --pid-file="$PWD/mysql.pid" \
>     --skip-name-resolve \
>     --skip-innodb \
>     --skip-ndbcluster \
>     --skip-networking \
>     --log=/proc/self/fd/2 \
>     --log-slow-queries=/proc/self/fd/2 \
> 
> Those last two options don't work:
> 
> mysqld: File '/proc/self/fd/2' not found (Errcode: 13)

any good daemon closes stdout, stderr, stdin and does chdir(/) on startup.
msqld might do so as well.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
