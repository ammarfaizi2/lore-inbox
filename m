Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271919AbTHDQfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271920AbTHDQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:35:50 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:31683 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271919AbTHDQfs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:35:48 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 18:35:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: herbert@13thfloor.at
Cc: beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804183545.01b7a126.skraw@ithnet.com>
In-Reply-To: <20030804161657.GA6292@www.13thfloor.at>
References: <20030804134415.GA4454@win.tue.nl>
	<200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
	<20030804175609.7301d075.skraw@ithnet.com>
	<20030804161657.GA6292@www.13thfloor.at>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 18:16:57 +0200
Herbert Pötzl <herbert@13thfloor.at> wrote:

> on the other hand, if you want somebody to implement
> this stuff for you, you'll have to provide convincing
> arguments for it, I for example, would be glad if
> hardlinks where removed from unix altogether ...

Huh, hard stuff!

Explain your solution for a very common problem:

You have a _big_ fileserver, say some SAN or the like with Gigs.
Your data on it is organized according to your basic user structure, because it
is very handy to have all data from one user altogether in one directory.
You have lots of hosts that use parts of the users' data for a wide range of
purposes, lets say web, ftp, sql, name one.
If you cannot re-structure and export your data according to the requirements
of your external hosts (web-trees to webserver, sql-trees to sql-server,
ftp-trees to ftp-server, name-it to cool-server) you will have to export the
total user tree to all your (cluster-) nodes. Do you want that? NO! Of course
you don't want that in times of hacked webservers and uncontrollable
sql-servers. If anything blows up you likely loose all data at once. On the
other hand, if you managed to link all web-data together in one directory and
exported that to your webservers and they are hacked, you just blew up all your
web-data but nothing more. This is a remarkable risk reduction.
And now? Name your idea to export only the data needed to the servers that need
it. And keep in mind, we are talking of Gigs and tenthousands of users. You
definitely don't want one mount per user per service.
Can you think of a more elegant way to solve such a problem than hardlinking
all web in one single webtree, all sql in one single sql tree ... and then
export this single tree (with its artificial structure) to the corresponding
server?
I am curiously listening...

Regards,
Stephan


