Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWCONbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWCONbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWCONbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:31:42 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19168 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932140AbWCONbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:31:41 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Stefan Seyfried <seife@suse.de>
Subject: Re: /dev/stderr gets unlinked 8]
Date: Wed, 15 Mar 2006 15:30:57 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, christiand59@web.de
References: <200603141213.00077.vda@ilport.com.ua> <200603141535.57978.vda@ilport.com.ua> <20060315110252.GB31317@suse.de>
In-Reply-To: <20060315110252.GB31317@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603151530.57624.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 March 2006 13:02, Stefan Seyfried wrote:
> On Tue, Mar 14, 2006 at 03:35:57PM +0200, Denis Vlasenko wrote:
>  
> > Mysql people are strange. For example, their daemon does not want to die
> > on SIGTERM, this makes it harder to run it under daemontools.
> 
> Well, daemontools are equally strange ;-))

IMHO the most sane way to control zillions of background processes.

> > Also it drops privileges BEFORE it opens logfiles (--log=xxx).
> > I cannot get it to log stuff on stderr:
> > 
> > echo "* Starting mysqld"
> > env - \
> > setuidgid root \
> > mysqld \
> >     --defaults-file="$PWD/my.cnf" \
> >     --user="$user" \
> >     --datadir="$var/data" \
> >     --tmpdir="$var/tmp" \
> >     --socket="$PWD/mysql.socket" \
> >     --pid-file="$PWD/mysql.pid" \
> >     --skip-name-resolve \
> >     --skip-innodb \
> >     --skip-ndbcluster \
> >     --skip-networking \
> >     --log=/proc/self/fd/2 \
> >     --log-slow-queries=/proc/self/fd/2 \
> > 
> > Those last two options don't work:
> > 
> > mysqld: File '/proc/self/fd/2' not found (Errcode: 13)
> 
> any good daemon closes stdout, stderr, stdin and does chdir(/) on startup.
> msqld might do so as well.

No. Good daemon (e.g. apache does it) will open log file first, and _then_
will do setuid($user). Mysql tries to do it in opposite order, and (no wonder)
fails to open the log.
--
vda
