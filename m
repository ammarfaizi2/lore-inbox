Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUIPISd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUIPISd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUIPISd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:18:33 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:47885 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S267839AbUIPIS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:18:26 -0400
Message-ID: <41494D6D.2090704@hist.no>
Date: Thu, 16 Sep 2004 10:23:09 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <41356321.4030307@namesys.com> <Pine.LNX.4.58.0408312259180.2295@ppc970.osdl.org> <413578C9.8020305@namesys.com> <414876AD.6060404@techsource.com>
In-Reply-To: <414876AD.6060404@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> I'm probably not the first to suggest this idea, and it's probably not 
> a very good idea, but here's my idea anyhow:
>
> You have a file "/usr/bin/emacs"
> with a metadata property in the overlaid namespace 
> "/usr/bin/emacs/[[..]metas/]icon"
>
> According to some, this could cause some confusion.  Howabout instead:
>
> You have a file "/usr/bin/emacs"
> with a metadata property in a slightly separated namespace 
> "/metas/usr/bin/emacs/icon"
>
And the problem with such a "solution" is
mv /usr/bin/emacs /usr/bin/old-emacs
Do this with an ordinary fs, and the /metas/usr/bin/emacs/icon
won't move with it.  Now metas might might not be an ordinary fs,
so perhaps the move happens automatically there, but if so
it will be unexpected. 

> This has the advantage of still having the metadata in the filesystem 
> namespace but without the confusion of having files-as-directories, 
> ambiguity of filename, backup issues, etc.  This is the reverse of 
> having the namespaces overlaid with a "/nometas" view which is separate.
>
> Furthermore, you can split things further like this:
>
> You have a file "/usr/bin/emacs"
> with an automatically-generated metadata property that you don't want 
> to back up in "/autometas/usr/bin/emacs/modification_date"
> and a manually generated metadata property that you MAY want to backup 
> in "/staticmetas/usr/bin/emacs/icon".
>
> This is inelegant, I know.  But if we do this, we can add the extra 
> features of reiser4 without confusing existing apps or having to 
> modify them to support the new functionality.
>
> Furthermore, you can easily hide the extra features by not mounting 
> the meta top-level directories (assuming they're mounted like separate 
> filesystems, rather than just magically appearing there, which is okay 
> too).

Having to go up to root and then down a similar but different path to 
reach a
file's metadata seems very counterintuitive to me.  And you have to 
update all
tools to do this automatically, or it'll be hopeless to actually use.

Helge Hafting

