Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWBJFB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWBJFB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWBJFB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:01:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbWBJFB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:01:56 -0500
Date: Thu, 9 Feb 2006 20:57:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, stable@kernel.org,
       jmforbes@linuxtx.org, zwane@arm.linux.org.uk, tytso@mit.edu,
       rdunlap@xenotime.net, davej@redhat.com, chuckw@quantumlinux.com,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, kaber@trash.net
Subject: Re: [stable] Re: [patch 6/6] [NETFILTER]: Fix another crash in
 ip_nat_pptp (CVE-2006-0037)
Message-Id: <20060209205729.211cf713.akpm@osdl.org>
In-Reply-To: <20060210044754.GC27457@kroah.com>
References: <20060128015840.722214000@press.kroah.org>
	<20060128021835.GG10362@kroah.com>
	<20060208123541.GA6004@kruemel.my-eitzenberger.de>
	<20060210044754.GC27457@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Wed, Feb 08, 2006 at 01:35:41PM +0100, Holger Eitzenberger wrote:
> > On Fri, Jan 27, 2006 at 06:18:35PM -0800, Greg KH wrote:
> > 
> > >  	DEBUGP("altering call id from 0x%04x to 0x%04x\n",
> > > -		ntohs(*cid), ntohs(new_callid));
> > > +		ntohs(*(u_int16_t *)pptpReq + cid_off), ntohs(new_callid));
> > 
> > Note that this fix introduces another bug in the above use DEBUGP
> > statement, as there is (u_int16_t *) ptr arithmetic used, whereas
> > cid_off is a byte offset.
> > 
> > A fix for that was send a few weeks ago on netfilter-devel.
> 
> Great, care to forward it to stable@kernel.org so we can get it in the
> next release?
> 

I have a copy of the patch and I'll cc stable@ on it.  Although afaik this
bug just causes wrong debug info to come out, so I don't think it's
terribly important (?)

