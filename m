Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVLPNW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVLPNW1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbVLPNW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:22:27 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:35563 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932259AbVLPNW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:22:26 -0500
Date: Fri, 16 Dec 2005 06:22:24 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Neil Brown <neilb@suse.de>, Steven Rostedt <rostedt@goodmis.org>,
       linas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks]
Message-ID: <20051216132224.GD2361@parisc-linux.org>
References: <20051103235918.GA25616@mail.gnucash.org> <1131412273.14381.142.camel@localhost.localdomain> <17263.64754.79733.651186@cse.unsw.edu.au> <200512161509.01580.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161509.01580.vda@ilport.com.ua>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:09:01PM +0200, Denis Vlasenko wrote:
> 
> Forward decl for typedef works too:
> 
> typedef struct foo foo_t;
> 
> is ok even before struct foo is defined. Not sure that standards
> allow thing, but gcc does.

Forward declarations of typedefs don't work in at least one case that
do for struct definitions:

$ cat foo.c
typedef struct foo foo_t;
typedef struct foo foo_t;
$ gcc -Wall -o foo.o -c foo.c
foo.c:2: error: redefinition of typedef 'foo_t'
foo.c:1: error: previous declaration of 'foo_t' was here

and if you don't believe we do that, take another look at our headers
sometime.
