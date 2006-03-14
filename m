Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWCNNgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWCNNgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWCNNgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 08:36:38 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:37775 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932426AbWCNNgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 08:36:37 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Christian <christiand59@web.de>
Subject: Re: /dev/stderr gets unlinked 8]
Date: Tue, 14 Mar 2006 15:35:57 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200603141213.00077.vda@ilport.com.ua> <200603141411.11121.christiand59@web.de>
In-Reply-To: <200603141411.11121.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141535.57978.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 March 2006 15:11, Christian wrote:
> > Hi,
> >
> > In the bad days of devfsd, no user program could remove /dev/stderr
> > (bacause fs didn't allow for that).
> >
> > But I switched to udev sometime ago.
> >
> > Today I discovered that my mysqld was happily unlinking it and
> > recreating as regular file in /dev (I pass --log=/dev/stderr
> > to mysqld).
> >
> > Can I make /dev/stderr non-unlink-able?
> > --
> > vda
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> You could run mysql as non-privileged user or try something like 
> --log=/proc/self/fd/2

Mysql people are strange. For example, their daemon does not want to die
on SIGTERM, this makes it harder to run it under daemontools.

Also it drops privileges BEFORE it opens logfiles (--log=xxx).
I cannot get it to log stuff on stderr:

echo "* Starting mysqld"
env - \
setuidgid root \
mysqld \
    --defaults-file="$PWD/my.cnf" \
    --user="$user" \
    --datadir="$var/data" \
    --tmpdir="$var/tmp" \
    --socket="$PWD/mysql.socket" \
    --pid-file="$PWD/mysql.pid" \
    --skip-name-resolve \
    --skip-innodb \
    --skip-ndbcluster \
    --skip-networking \
    --log=/proc/self/fd/2 \
    --log-slow-queries=/proc/self/fd/2 \

Those last two options don't work:

mysqld: File '/proc/self/fd/2' not found (Errcode: 13)

Oh well....
--
vda
