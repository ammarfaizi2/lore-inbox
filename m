Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbUKVWUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbUKVWUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUKVWS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:18:27 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:50876 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S262412AbUKVWQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:16:53 -0500
From: Mike Hearn <mh@codeweavers.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Pouech <pouech-eric@wanadoo.fr>, Jesse Allen <the3dfxdude@gmail.com>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       wine-devel <wine-devel@winehq.com>
In-Reply-To: <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <419E42B3.8070901@wanadoo.fr>
	 <Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
	 <419E4A76.8020909@wanadoo.fr>
	 <Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
	 <419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
Organization: Codeweavers, Inc
Date: Mon, 22 Nov 2004 22:19:13 +0000
Message-Id: <1101161953.13273.7.camel@littlegreen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-SPF-Flag: YES
X-Broken-Reverse-DNS: no host name found for IP address 81.168.44.4
X-SA-Exim-Connect-IP: 81.168.44.4
X-SA-Exim-Mail-From: mh@codeweavers.com
Subject: Re: ptrace single-stepping change breaks Wine
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 13:10 -0800, Linus Torvalds wrote:
> I actually broke down and am downloading the latest source tree of wine,
> let's see if I can find the place you do this.

The Wine source tree is organised in the same way Windows is, which is
bizarre and unintuitive but we don't really have much choice. So here
are the files you'd be looking for.

this is where signals are converted to SEH exceptions (w-exceptions as
Eric called them):

  dlls/ntdll/signal_i386.c 

this is where the wineserver does context related things:

  server/context_i386.c

this is where the server does ptracing:

  server/ptrace.c

There may be one or two other places that are related, I only ever
looked at this code to deal with some other copy protection system that
wasn't happy (not kernels fault though).

thanks -mike

-- 
Mike Hearn <mh@codeweavers.com>
Codeweavers, Inc

