Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTDOEot (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTDOEos (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:44:48 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:53890 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264259AbTDOEor (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 00:44:47 -0400
Date: Tue, 15 Apr 2003 05:56:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped files question
Message-ID: <20030415045637.GB25139@mail.jlokier.co.uk>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com> <004301c302bd$ed548680$fe64a8c0@webserver> <b7fbhg$sq4$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7fbhg$sq4$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> > Hi, everyone.  Thanks for all your responses.  Our confusion is
> > that in Unix environments, when we modify memory in memory-mapped
> > files the underlying system flusher manages to flush the files for
> > us before the files are munmap'ed or msysnc'ed.
> 
> Bullshit.  It might work on one particular Unix implementation, but
> the definition of Unix, the Single Unix Standard, does explicitly
> *not* require this behavior.

I presume that if you do write(), the Single Unix Standard allows the
data to remain dirty in RAM for an arbitrary duration too.

If I write() a file I expect it to be automatically written to disk
within a few minutes at most, where that is plausible.

Frank van Maarseveen wrote:
> Shared mmaped files are _never_ flushed, at least in 2.4.x. So,
> without an explicit msync() a process (innd comes to mind) may loose
> years of updates upon a system crash or power outage.

It's a quality of implementation issue if data can remain dirty in RAM
forever without ever being flushed.

Can this really happen with normal open/mmap/munmap/close usage, or
does it only occur with long-lived processes like innd which mmap a
file, dirty the pages but never munmap them?

If the former case does happen, I'd say we're failing on quality of
implementation.  If it's only the latter case, though, fair enough: the
application writer will have to use msync().

-- Jamie
