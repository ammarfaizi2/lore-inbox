Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWJEPou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWJEPou (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWJEPou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:44:50 -0400
Received: from terminus.zytor.com ([192.83.249.54]:41385 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751213AbWJEPot
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:44:49 -0400
Message-ID: <45252853.3050909@zytor.com>
Date: Thu, 05 Oct 2006 08:44:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>	<20061003172511.GL3164@in.ibm.com>	<20061003201340.afa7bfce.akpm@osdl.org>	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>	<20061004214403.e7d9f23b.akpm@osdl.org>	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>	<20061004233137.97451b73.akpm@osdl.org> <m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> In the lazy programmer school of fixes.
> 
> I haven't really tested this in any configuration.
> But reading video.S it does use variable in the bootsector.
> It does seem to initialize the variables before use.
> But obviously something is missed.
> 
> By zeroing the uninteresting parts of the bootsector just after we
> have determined we are loaded ok.  We should ensure we are
> always in a known state the entire time. 
> 
> Andrew if I am right about the cause of your video not working
> when you set an enhanced video mode this should fix your boot
> problem.
> 

I just noticed we're using string instructions in setup.S, without 
forcing DF = 0 anywhere.  There should be a "cld" near the top.

	-hpa
