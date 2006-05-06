Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWEFDLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWEFDLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 23:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWEFDLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 23:11:43 -0400
Received: from CPE-144-136-172-108.sa.bigpond.net.au ([144.136.172.108]:54620
	"EHLO grove.modra.org") by vger.kernel.org with ESMTP
	id S1751812AbWEFDLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 23:11:42 -0400
Date: Sat, 6 May 2006 12:41:41 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: binutils@sourceware.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, Gerd Hoffmann <kraxel@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>, binutils@sources.redhat.com
Subject: Re: as bug (was: Re: smp/up alternatives crash when CONFIG_HOTPLUG_CPU)
Message-ID: <20060506031140.GE11597@bubble.grove.modra.org>
Mail-Followup-To: Denis Vlasenko <vda@ilport.com.ua>,
	binutils@sourceware.org, Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@osdl.org>, Gerd Hoffmann <kraxel@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Chuck Ebbert <76306.1226@compuserve.com>, binutils@sources.redhat.com
References: <20060419094630.GA14800@elte.hu> <200605051145.54643.vda@ilport.com.ua> <20060505122029.GB11597@bubble.grove.modra.org> <200605051613.24704.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605051613.24704.vda@ilport.com.ua>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 04:13:24PM +0300, Denis Vlasenko wrote:
> On Friday 05 May 2006 15:20, Alan Modra wrote:
> > the frag base addresses have not yet been set, and zero is used.  ie.
> > gas tries to assemble ".fill -5,1,0x42".

The fact that enabling gas listings fixes this has been nagging at me
since writing the sketchy description of gas frags and relaxation.
I'd forgotten that relaxation keeps iterating over all sections until no
frag changes address.  ie. even though the first .fill is using invalid
addresses, there will be a subsequent pass that uses the correct value.

The reason why gas -al helps with this case is that gas creates a new
frag for each line as somewhere to hang the file/line number info.  So
both "661" and "662" start off at offset zero in their frags and the
initial pass .fill has a zero length rather than a negative one.

So perhaps gas ought to be able to handle this after all..  I'll see if
I can come up with a fix.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
