Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTF1OOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 10:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTF1OOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 10:14:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:59662 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265224AbTF1OOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 10:14:19 -0400
Date: Sat, 28 Jun 2003 16:34:32 +0200
To: Mike Galbraith <efault@gmx.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030628143432.GA7986@hh.idb.hist.no>
References: <5.2.0.9.2.20030627110106.00cf6068@pop.gmx.net> <5.2.0.9.2.20030628064029.00cfa800@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030628064029.00cfa800@pop.gmx.net>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 07:44:26AM +0200, Mike Galbraith wrote:
[...]
> 
> I'm no clean freak, but fiddling with scheduling information all over the 
> place seems like a very bad idea. (before anyone says it, yes, we fiddle 
> with state all over the place;)  I can imagine doing something dirty in 
> driver code for specific cases (kdb/mouse are always interactivity 
> indicators), but not in generic code.
> 
> Besides, the logical bindings for foo | bar | ... | baz do not exist in the 
> kernel.  The kernel knows and cares only that single entities are using 
> open/read/write/close primitives.  

Data is moved from one process to the next, so the logical binding
exists.  It may exist only for the duration of the write & read
calls, but that is enough for this purpose.

Info about the data being transferred (address, amount) must exist somewhere,
or data written to pipes would be lost.  This is updated when
someone writes into a pipe.  The kernel could, during the write call,
transfer some interactvity bonus (if any) and store it along with
the other information about the pipe.  

The pipe read call would simply grab any transferred bonus and
add it to the reader's interactivity bonus.  This should only be
a few integer operations on either end of the pipe. 
The io boost calculated for disk/device operations surely amounts to some
code too. It don't mess with every wakeup imaginable, this is specific to
pipes. 

> This is why I said I could _imagine_ a 
> process struct... as the container for this missing (it lives in userland) 
> information.
> 
> Another besides:  it makes zero difference it you add overhead to wakeup 
> time or go to sleep time.  If it's something you do a lot of, adding 
> overhead to it is going to hurt a lot.
> 
No doubt about that.  Transferring an extra int per pipe read/write
is overhead, I hope the data part of the transfer typically is much
bigger than that.

Helge Hafting
