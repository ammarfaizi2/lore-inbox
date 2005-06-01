Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVFAWFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVFAWFB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFAWEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:04:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:39149 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261318AbVFAWCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:02:45 -0400
X-Authenticated: #428038
Date: Thu, 2 Jun 2005 00:02:42 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
Message-ID: <20050601220242.GC31585@merlin.emma.line.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429E062B.60909@tmr.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Jun 2005, Bill Davidsen wrote:

> >It's a matter of enforcing write order. In how far such ordering
> >constraints are propagated by file systems, VFS layer, down to the
> >hardware, is the grand question.
>
> The problem is that in many options required to make that happen in the 
> o/s, hardware, and application are going to kill performance. And even 
> if you can control order of write, unless you can get write to final 
> non-volatile media control you can get a sane database but still lose 
> transactions.
> 
> If there was a way for the o/s to know when a physical write was done 
> other than using flushes to force completion, then overall performance 
> could be higher, but individual transaction might have greater latency. 
> And the app could use fsync to force order of write as needed. In many 
> cases groups of writes can be done in any order as long as they are all 
> done before the next logical step takes place.

I have a déjà-vu, and I do believe that this discussion has taken place
in this list before, perhaps with a slightly different alignment, and
likely in the context of mail transfer agents and perhaps synchronous
directory (data) updates (file creation and such). Exposing a bit of the
queueing to the user space through new syscalls may be an interesting
experiment, although I do not have the resources to provide code.
Something like fsync() that doesn't flush the whole file system (which
appears to be the most common implementation) but tracks what is needed,
and that returns when data for a given file is on disk.

> This would change the meaning of fsync from "force out the data" to 
> "wait for the data to be written" in some implementations.

Naming suggestion: flazysync()

-- 
Matthias Andree
