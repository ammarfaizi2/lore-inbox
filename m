Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTFYXBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265166AbTFYXBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:01:07 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:51209 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S265176AbTFYXAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:00:54 -0400
Message-ID: <3EFA2D63.1010500@techsource.com>
Date: Wed, 25 Jun 2003 19:16:51 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: John Bradford <john@grabjohn.com>, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
References: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk> <20030623163234.GA1184@hh.idb.hist.no> <3EF8D3A9.4040109@techsource.com> <20030625214248.GB2753@hh.idb.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Helge Hafting wrote:
> On Tue, Jun 24, 2003 at 06:41:45PM -0400, Timothy Miller wrote:
> 
>>>
>>>That could be an interesting hack to a window manager - 
>>>don't start the move in opaque mode when the load is high.
>>
>>This isn't really an issue if the graphics engine is doing the work and 
>>the X server doesn't busy-wait on the bitblt to finish (ie. does DMA or 
>>calls ioctl to sleep until command-fifo-has-free-space interrupt).
> 
> 
> The problem isn't window movement, but all the stuff you uncover
> forcing repainting all over the place.

Quite true.  But once again, a well-written DDX will attempt to minimize 
any busy-waiting it does.  I can't remember if I'm thinking of the 
Matrox or Radeon drivers in XFree86, but they have code to do DMA, so 
all they do is fill up a buffer and go to sleep waiting on an ioctl. 
(I'm making an inference here, but isn't this what the DRM drivers are 
all about?)  The only time this doesn't work is when the drawing engine 
doesn't support the particular operation being done (or the DDX doesn't 
support it), and it's counter-productive to try to have mi reduce it to 
spans, or the drawing engine doesn't support DMA or interrupts.



