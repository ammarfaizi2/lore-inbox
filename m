Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbUGHR4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbUGHR4z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 13:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUGHR4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 13:56:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16858 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262756AbUGHR4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 13:56:53 -0400
Date: Thu, 8 Jul 2004 12:55:45 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linas@austin.ibm.com
Cc: paulus@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] PPC64: log firmware errors during boot.
Message-Id: <20040708125545.41aae667.moilanen@austin.ibm.com>
In-Reply-To: <20040708110337.N21634@forte.austin.ibm.com>
References: <20040629191046.Q21634@forte.austin.ibm.com>
	<16610.39955.554139.858593@cargo.ozlabs.ibm.com>
	<20040706084116.11ab7988.moilanen@austin.ibm.com>
	<20040708110337.N21634@forte.austin.ibm.com>
Organization: LTC
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jul 2004 11:03:37 -0500
linas@austin.ibm.com wrote:

> On Tue, Jul 06, 2004 at 08:41:16AM -0500, Jake Moilanen wrote:
> > 
> > > > Firmware can report errors at any time, and not atypically during boot.
> > > > However, these reports were being discarded until th rtasd comes up,
> > > > which occurs fairly late in the boot cycle.  As a result, firmware
> > > > errors during boot were being silently ignored.
> > 
> > Linas, the main consumer of error-log is events coming in from
> > event-scan.  We don't call event-scan until rtasd is up (eg they are
> > queued in FW until we call event-scan).  
> 
> Actually, they don't seem to be queueed at all; when I turned on 
> logging earlier, a whole pile of messages poped out that weren't 
> visible before.

event-scan is called every 30 seconds.  FW has to queue them.

If you are seeing a different pile of messages, I would imagine the
messages that popped out are not coming from event-scan then.  Might be
last_error, which messages do not come in from event-scan.  I can see
them not being logged in early boot.  

A problem I could see, is if we make an rtas call before the VM
is up.  The kmalloc for last_error won't like that.

Jake
