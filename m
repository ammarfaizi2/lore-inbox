Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbULaMIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbULaMIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 07:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbULaMHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 07:07:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58530 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261872AbULaMGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 07:06:07 -0500
Date: Fri, 31 Dec 2004 07:16:01 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Felipe Erias <charles.swann@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Queues when accessing disks
Message-ID: <20041231091601.GB10834@logos.cnet>
References: <169c13c404123019322a766f64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169c13c404123019322a766f64@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 04:32:59AM +0100, Felipe Erias wrote:
> Hi,

Hi Felipe,

> I'm trying to apply queuing theory to the study of the GNU/Linux kernel.
> Right now, I'm focusing in the queue of processes that appears when they
> try to access an I/O device (specifically, an IDE HD).

Interesting!

> When they want to read data, it behaves as a usual queue: several clients (processes) that
> require attention from a server (disk / driver / ...). The case when they want
> to write data is a bit more tricky, because of the cache buffers used by the OS,
> and maybe could be modelized by a network of queues. 

Well read's also go through the pagecache, so you "suffer" from the same caching 
issue.

> Both cases are
> interesting for my work, but I'll take the reading one first, just
> because it seems
> a bit more simple 'a priori'.
> 
> To modelize the queue, I need to get some information:
>  - what processes claim attention from the disk
>  - when they do it
>  - when they begin to be served
>  - when they finish being served

Its a bit more complicated than that because requests will be often shared, and 
its not always the process who initiates the request who actually perform it.

For example writes are often performed by pdflush (the flushing daemon) and not 
the process(es) which initiated them.

Another thing is that on a real system you will have a _huge_ amount of statistical data.

> To get all this information, maybe I could hack my kernel a bit to write
> a line to a log on every access to the HD, or account the IRQs from
> the IDE channels... I also have the feeling that this queuing problem could
> dissappear o became more hidden if DMA were enabled.
> 
> To be true, I'm a bit lost and that's why I ask for your help.

Linux Trace Toolkit can give you detailed per-process statistics. You should
take a look at it 

http://www.opersys.com/LTT/

Good luck!



