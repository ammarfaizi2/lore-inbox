Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTDGNLS (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 09:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTDGNLS (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 09:11:18 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:44292 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263407AbTDGNLR (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 09:11:17 -0400
Message-ID: <3E917BFA.4020303@aitel.hist.no>
Date: Mon, 07 Apr 2003 15:24:10 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
References: <200304071026.47557.schlicht@uni-mannheim.de> <200304072021.17080.kernel@kolivas.org> <1049712476.3e91575c2e6ae@rumms.uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter wrote:

> What I wanted to say is that if there is free memory it should be filled with
> the pages that were in use before the memory got rare. And these are the pages
> swapped out last. 

Not necessarily.  Memory isn't merely used to hold swappable stuff, it also
caches files.  Consider a small but io-intensive program.  The stuff
you want isn't necessarily the last swap (perhaps there
even isn't anything swapped out) , it might be the last thing
dropped from cache instead.

And we can often predict better than "the last thing swapped/flushed"
A bunch of free memory appearing could usually be better used for
extra read-ahead, wether it is read-ahead of files/directories/bitmaps
being accessed, or executable code faulted in from executables or
swap devices.

> The other swapped out pages are swapped out even longer and so
> will likely not be used in the near future... (That's what the LRU algorithm
> says...)


"What we're going to need soon" is the best.  It isn't always predictable,
but sometimes.  "The block following the last we read from some 
file/fs-structure"
is often a good one though.

Helge Hafting

