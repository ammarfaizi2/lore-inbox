Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUIORCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUIORCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUIORCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:02:19 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:275 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266643AbUIORBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:01:13 -0400
Message-ID: <414876AD.6060404@techsource.com>
Date: Wed, 15 Sep 2004 13:06:53 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <41352279.7020307@slaphack.com> <41356321.4030307@namesys.com> <Pine.LNX.4.58.0408312259180.2295@ppc970.osdl.org> <413578C9.8020305@namesys.com>
In-Reply-To: <413578C9.8020305@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm probably not the first to suggest this idea, and it's probably not a 
very good idea, but here's my idea anyhow:

You have a file "/usr/bin/emacs"
with a metadata property in the overlaid namespace 
"/usr/bin/emacs/[[..]metas/]icon"

According to some, this could cause some confusion.  Howabout instead:

You have a file "/usr/bin/emacs"
with a metadata property in a slightly separated namespace 
"/metas/usr/bin/emacs/icon"

This has the advantage of still having the metadata in the filesystem 
namespace but without the confusion of having files-as-directories, 
ambiguity of filename, backup issues, etc.  This is the reverse of 
having the namespaces overlaid with a "/nometas" view which is separate.

Furthermore, you can split things further like this:

You have a file "/usr/bin/emacs"
with an automatically-generated metadata property that you don't want to 
back up in "/autometas/usr/bin/emacs/modification_date"
and a manually generated metadata property that you MAY want to backup 
in "/staticmetas/usr/bin/emacs/icon".

This is inelegant, I know.  But if we do this, we can add the extra 
features of reiser4 without confusing existing apps or having to modify 
them to support the new functionality.

Furthermore, you can easily hide the extra features by not mounting the 
meta top-level directories (assuming they're mounted like separate 
filesystems, rather than just magically appearing there, which is okay too).

