Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266108AbTGLPn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbTGLPn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:43:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266108AbTGLPnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:43:55 -0400
Message-ID: <3F103018.6020008@pobox.com>
Date: Sat, 12 Jul 2003 11:58:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
References: <20030711140219.GB16433@suse.de> <20030712152406.GA9521@mail.jlokier.co.uk>
In-Reply-To: <20030712152406.GA9521@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Dave Jones wrote:
> 
>>- Some people seem to have trouble running rpm, most notably Red Hat 9 users.
>>  This is a known bug of rpm.
>>  Workaround: run "export LD_ASSUME_KERNEL=2.2.5", before running rpm.
> 
> 
> Ah, _thank you_.
> 
> It's not an rpm bug, as such; it's a problem/bug with DB4, the
> Berkeley DB library.
> 
> I just spent 2 hours trying to figure out why rpm was failing.
> write() returning EINVAL for no reason?  Finally spotted that O_DIRECT
> was the significant bit.

You got it.  db4+O_DIRECT == blah.  (I just had a conversation yesterday 
with rpm's maintainer about what the problems are)

One problem is O_DIRECT should return an error on open(2) or fcntl(2), 
not write(2).

Another problem appears to be that db does not know about the alignment 
requirements of O_DIRECT.


> End result: I copied an rpm database from another machine.  It's wrong
> for this machine, but nearly right.  Ah well.
> 
> If I'd only known about the LD_ASSUME_KERNEL fix sooner.

Unfortunately, LD_ASSUME_KERNEL is a lucky hack, not a fix.  rpm dlopens 
a pam .so.  LD_ASSUME_KERNEL doesn't work for that .so, only for rpm 
itself...  fun ensues.

	Jeff



