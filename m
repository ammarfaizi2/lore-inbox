Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWGBFRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWGBFRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 01:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWGBFRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 01:17:34 -0400
Received: from smtp107.biz.mail.re2.yahoo.com ([206.190.52.176]:62839 "HELO
	smtp107.biz.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932125AbWGBFRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 01:17:34 -0400
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
Date: Sun, 2 Jul 2006 08:18:26 +0300
User-Agent: KMail/1.8.2
Cc: "Kumar Gala" <galak@kernel.crashing.org>,
       "linuxppc-dev list" <linuxppc-dev@ozlabs.org>,
       "Paul Mackerras" <paulus@samba.org>, linux-kernel@vger.kernel.org
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net> <200607011750.05019.pantelis.antoniou@gmail.com> <DCEAAC0833DD314AB0B58112AD99B93B07B36F@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B07B36F@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607020818.27603.pantelis.antoniou@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 July 2006 06:54, Rune Torgersen wrote:
> From: Pantelis Antoniou
> Sent: Sat 7/1/2006 9:50 AM
> >Since genalloc is the blessed linux thing it might be best to use that & remove
> >rheap completely. Oh well...
> 
> Two problems with genalloc that I can see (for CPM programming):
> 1) (minor) Does not have a way to specify alignment (genalloc does it for you)
> 2) (major problerm, at least for me) Does not have a way to allocate a specified address in the pool.
> 
> 2 is needed esp when programming MCC drivers, since a lot of the datastructures must be in DP RAM _and_ be in a specific spot. And if you cannot tell the allocator that I am using a specific address, then the allocator might very well give somebody else that portion of RAM. The only solution without a fixed allocator is to allocate ALL memory in the DP RAM and use your own allocator. 
> 

Yeah, that too.

Too bad there are no main tree drivers like that, but they do exist.

One could conceivably hack genalloc to do that, but will end up with
something complex too.

BTW, there are other uEngine based architectures with similar alignment
requirements.

So in conclusion, for the in-tree drivers genalloc is sufficient as an cpm memory allocator.
For some out of tree drivers, it is not.

Pantelis
