Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264150AbTDOXFj (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTDOXFj 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:05:39 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:20559 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S264150AbTDOXFi convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 19:05:38 -0400
Date: Wed, 16 Apr 2003 01:17:28 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030416011728.196d66ca.philippe.gramoulle@mmania.com>
In-Reply-To: <20030415160530.2520c61c.akpm@digeo.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 15 Apr 2003 16:05:30 -0700
Andrew Morton <akpm@digeo.com> wrote:

  | Philippe Gramoullé  <philippe.gramoulle@mmania.com> wrote:
  | >
  | > 
  | > http://www.philou.org/2.5.67-mm3/2.5.67-mm3.log
  | 
  | This is a great bug report.  Thanks.

Well, i finally managed to get some output when i learned about the
nmi_watchdog boot option ( reading another thread about debugging hard hangs)
so i'm pleased if this report helped :)
  | 
  | The 1394 warnings are known about and I think Ben is working on it.

Ok, great. I think this is one of the latest thing that prevents me to
use 2.5.x almost full time.

  | 
  | The NMI watchdog hit is nasty:
  | 
[snip]
  | 
  | What has happened here is that you were in the middle of a kobject_get(),
  | holding spin_lock(&kobj_lock) when an interrupt came in.  The USB interrupt
  | handler comes in and ends up calling kobject_get() again.  This CPU already
  | holds the lock and blamyouredead.
  | 
  | Turning kobj_lock into an IRQ-safe lock would appear to be a sufficient fix.

I'll wait for the fix and will happily try it once it's available.

Thanks,

Philippe
