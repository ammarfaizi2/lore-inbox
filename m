Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274701AbRJAHiS>; Mon, 1 Oct 2001 03:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJAHh7>; Mon, 1 Oct 2001 03:37:59 -0400
Received: from chiara.elte.hu ([157.181.150.200]:19730 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S274688AbRJAHhr>;
	Mon, 1 Oct 2001 03:37:47 -0400
Date: Mon, 1 Oct 2001 09:35:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Rik van Riel <riel@conectiva.com.br>, Kenneth Johansson <ken@canit.se>,
        "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <200109301225.f8UCPXl16936@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0110010924380.3436-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Sep 2001, Richard Gooch wrote:

> I usually think of "server" as the box that's running all the time,
> providing a service to multiple clients. In this case, the netconsole
> server should always be running, accepting log messages for storage.
> The clients (which are transitory, otherwise netconsole wouldn't be
> needed:-), initiate work for the server to do.
>
> Face it, Ingo's use of "client" and "server" is contrary to accepted
> usage. You can't finesse around it.

'server' is the box that serves content. 'client' is one that requests and
accepts it. in the case of netconsole, it's the netconsole-module box that
produces the messages, and the other one gets them.

it's analogous to a browser <-> http server relationship. The browser gets
messages from multiple servers - often in parallel. That is a 1:N
relationship as well.

the fact that the netconsole-module box did not get any formal 'request'
from the other side does not mean it's not the content generator: right
now the 'request' is implicit, but in the future it might be formalized.
The netconsole patch will soon be extended to do crashdumps - and in this
case it will not only be a log message server, it will also be a crashdump
server.

to further underscore why the netconsole-module box is a 'log message
server', it can produce messages to multiple 'clients'. (this is already
possible by renaming the netconsole module's symbols and inserting it as
eg. netconsole2.o.)

but in the case of logging there is indeed another way to think about it
as well: the netconsole-module box is asking the other side to store logs.
But in internet terms it's usually the content producer that is the
server, and the content sink that is the client. And i've been coding HTTP
and FTP server software lately which influenced my terminology :)

in this sense a browser is a 'server' too => the http server requests the
served page to be stored on the client.

but telling any side to be wrong is stupid - both are correct, and the
correct meaning of 'server' depends alot on context. this is why i defined
the terms.

	Ingo

