Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbUCBWsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUCBWrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:47:52 -0500
Received: from mail.gmx.de ([213.165.64.20]:54948 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262289AbUCBWql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:46:41 -0500
X-Authenticated: #271361
Date: Tue, 2 Mar 2004 23:46:26 +0100
From: Edgar Toernig <froese@gmx.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
       cloos@jhcloos.com, root@chaos.analogic.com, nuno@itsari.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
Message-Id: <20040302234626.1f00e788.froese@gmx.de>
In-Reply-To: <1078254284.2232.385.camel@cube>
References: <1078254284.2232.385.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>
> > As RBJ said, ptys are now recycled in pid-like fashion,
> > which means numbers won't be reused until wraparound
> > happens.  This is good for security/fault tolerance,
> > at least to some minor degree.
> 
> Ouch. It's bad for display and bad for typing.
> What is easier to type?
> 
> ps -t pts/6
> ps -t pts/1014962

IMHO more important: what about utmp?  It would become terribly
large.  Beside that, such huge numbers won't fit into ut_id.

Ciao, ET.

--[man utmp extract]--
...
    char ut_id[4];     /* init id or abbrev. ttyname */
...
    xterm(1)  and  other  terminal emulators directly create a
    USER_PROCESS record and generate the ut_id  by  using  the
    last  two  letters  of  /dev/ttyp%c  or  by  using p%d for
    /dev/pts/%d.  If they find a  DEAD_PROCESS  for  this  id,
    they  recycle  it,  otherwise they create a new entry.
...
