Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWAFRSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWAFRSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWAFRSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:18:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:62123 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932278AbWAFRSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:18:51 -0500
Message-ID: <43BEA672.4010309@pobox.com>
Date: Fri, 06 Jan 2006 12:18:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 2/7]  enable unit-at-a-time optimisations for gcc4
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136543914.2940.11.camel@laptopd505.fenrus.org>
In-Reply-To: <1136543914.2940.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Arjan van de Ven wrote: > Subject: allow gcc4 to
	optimize unit-at-a-time > > > From: Ingo Molnar <mingo@elte.hu> > >
	allow gcc4 compilers to optimize unit-at-a-time. > > This flag enables
	gcc to "see" the entire C file before making optimisation > decisions
	such as inline, which results in gcc making better decisions. One > of
	the immediate effects of this is that static functions that are used
	only > once now get inlined. > > gcc 3.4 has this flag as well, however
	gcc 3.x have a problem with inlining > and stacks and as a result,
	enabling this flag there would cause excessive > and unacceptable stack
	use. This problem is fixed in the gcc 4.x series. > The x86-64
	architecture already enables this feature so it's well tested >
	already. > > Signed-off-by: Ingo Molnar <mingo@elte.hu> >
	Signed-off-by: Arjan van de Ven <arjan@infradead.org> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Subject: allow gcc4 to optimize unit-at-a-time
> 
> 
> From: Ingo Molnar <mingo@elte.hu>
> 
> allow gcc4 compilers to optimize unit-at-a-time. 
> 
> This flag enables gcc to "see" the entire C file before making optimisation
> decisions such as inline, which results in gcc making better decisions. One
> of the immediate effects of this is that static functions that are used only
> once now get inlined.
> 
> gcc 3.4 has this flag as well, however gcc 3.x have a problem with inlining
> and stacks and as a result, enabling this flag there would cause excessive
> and unacceptable stack use. This problem is fixed in the gcc 4.x series. 
> The x86-64 architecture already enables this feature so it's well tested 
> already.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>

ACK, with a note:  gcc also supports limited program-at-a-time -- you 
pass multiple .c files on the same command line, and specify a single 
output on the command line.

It would be nice to update kbuild to do this for single directory 
modules....

	Jeff



