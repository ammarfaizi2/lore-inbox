Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUCCADt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 19:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUCCADt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 19:03:49 -0500
Received: from terminus.zytor.com ([63.209.29.3]:43927 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261797AbUCCADs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 19:03:48 -0500
Message-ID: <40451FFF.5030308@zytor.com>
Date: Tue, 02 Mar 2004 15:59:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Edgar Toernig <froese@gmx.de>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       cloos@jhcloos.com, root@chaos.analogic.com, nuno@itsari.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
References: <1078254284.2232.385.camel@cube> <20040302234626.1f00e788.froese@gmx.de>
In-Reply-To: <20040302234626.1f00e788.froese@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:
> 
> IMHO more important: what about utmp?  It would become terribly
> large.  Beside that, such huge numbers won't fit into ut_id.
> 
> Ciao, ET.
> 
> --[man utmp extract]--
> ...
>     char ut_id[4];     /* init id or abbrev. ttyname */
> ...
>     xterm(1)  and  other  terminal emulators directly create a
>     USER_PROCESS record and generate the ut_id  by  using  the
>     last  two  letters  of  /dev/ttyp%c  or  by  using p%d for
>     /dev/pts/%d.  If they find a  DEAD_PROCESS  for  this  id,
>     they  recycle  it,  otherwise they create a new entry.
> ...

That's broken for anything more than 1000 ptys, OR if you're using BSD 
and Unix98 ptys at the same time.

In other words, it's totally broken.

	-hpa
