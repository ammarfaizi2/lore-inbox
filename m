Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272553AbTGaQOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 12:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274801AbTGaQOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 12:14:01 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:3721 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S272553AbTGaQN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 12:13:56 -0400
Subject: Re: [Patch 3/6] dm: decimal device num sscanf
From: Christophe Saout <christophe@saout.de>
To: Joe Thornber <thornber@sistina.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@zip.com.au>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030731151326.GZ394@fib011235813.fsnet.co.uk>
References: <20030731104517.GD394@fib011235813.fsnet.co.uk>
	 <20030731104953.GG394@fib011235813.fsnet.co.uk>
	 <20030731160429.A14613@infradead.org>
	 <20030731151326.GZ394@fib011235813.fsnet.co.uk>
Content-Type: text/plain
Message-Id: <1059668031.14800.9.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 31 Jul 2003 18:13:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, 2003-07-31 um 17.13 schrieb Joe Thornber:

> On Thu, Jul 31, 2003 at 04:04:30PM +0100, Christoph Hellwig wrote:
> > On Thu, Jul 31, 2003 at 11:49:53AM +0100, Joe Thornber wrote:
> > > The 2.4 version of Device-Mapper scans for device-numbers in decimal
> > > instead of hex (in dm_get_device()). Update 2.6 so both versions use
> > > the same behavior.  [Kevin Corry]
> > 
> > This code should just go away completly.  There's no excuse for parsing
> > a dev_t in new code instead of a pathname.
> 
> It's in there to match the output from 'dmsetup table'.  I'm not sure
> anyone uses it, but I'd still like to keep it so that 2.4 and 2.6 stay
> in sync.

The output from dmsetup table looks different in 2.6 anyway (at least on
my system?), something like: 0 12582912 linear hda7 384

When you have a target that uses another device-mapper device it says
something like dm-5. dmsetup load doesn't like that one.

(BTW: Before 2.5.69 it looked like ide0(3, 7) or something, I don't
remember exactly. My lilo-devmapper patch tries to parse all three
formats, and also fails on things like dm-5...)

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

