Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFJRoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFJRoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVFJRon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 13:44:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261154AbVFJRoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 13:44:23 -0400
Date: Fri, 10 Jun 2005 10:44:14 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Alastair Poole <alastair@unixtrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Major TCP connect() errors, don't release as stable.
Message-ID: <20050610104414.40fea891@router.routing.pdx.osdl.net>
In-Reply-To: <42A9A0C0.5030802@unixtrix.com>
References: <42A9A0C0.5030802@unixtrix.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005 14:16:32 +0000
Alastair Poole <alastair@unixtrix.com> wrote:

> I have tested various kernels including 2.6.11.10 2.6.11.11 and
> 2.6.12-rc6 and am having unusual results regarding connect().  Earlier
> kernels do not return the same strange results.
> 
> I have tested numerous basic port scanners, including my own, and
> strangely ports which are NOT open are being reported as open.  I have
> checked these ports by various means -- to be certain they are NOT open
> -- and in various runlevels; the results are the same.  There are no TCP 
> daemons running, nor RPC services.  This is definately kerenl related.
> 
> The number of ports listed changes in size and they appear to be
> random.  For example, on one scan ports 22, 3455, 4532 and 6236 will
> appear open; on another scan it might be 22, 3567, 3879, 3889, 6589 and
> 7374.
> 
> However, ports which ARE open do also appear as open alongside these
> "rogue" ports.  I have also tested this on another system with the same
> results.  It is also interesting to note that a basic TCP nmap scan of 
> all ports does not return these unusual results.
> 
> I was initially told that the problem was not kernel related.  However, 
> I have now reconfirmed with three seperate sources.  This is, indeed, 
> quite a serious kernel related bug.  Please take this seriously.
> 
> Enclosed is example code that produces these results on the named
> kernels and systems.
> 
> sincerely
> 
> Alastair Poole

Looks like a simple interaction of "connect to self" allowed by RFC 793
to handle simultaneous connection and the TCP port randomization of ephemeral ports.
