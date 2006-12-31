Return-Path: <linux-kernel-owner+w=401wt.eu-S933178AbWLaNpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933178AbWLaNpn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933180AbWLaNpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:45:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57459 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbWLaNpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:45:42 -0500
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
From: Arjan van de Ven <arjan@infradead.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061231133902.GA13521@vanheusden.com>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	 <200612302149.35752.vda.linux@googlemail.com>
	 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
	 <1167518748.20929.578.camel@laptopd505.fenrus.org>
	 <20061231133902.GA13521@vanheusden.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 31 Dec 2006 14:45:34 +0100
Message-Id: <1167572735.20929.750.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 14:39 +0100, Folkert van Heusden wrote:
> > > i don't see how that can be true, given that most of the definitions
> > > of the clear_page() macro are simply invocations of memset().  see for
> > > yourself:
> > *MOST*. Not all.
> > For example an SSE version will at least assume 16 byte alignment, etc
> > etc.
> 
> What about an if (adress & 15) { memset } else { sse stuff }
> or is that too obvious? :-)


it's only one example. clear_page() working only on a full page is a
nice restriction that allows the implementation to be optimized (again
the x86 hardware that had a hardware page zeroer comes to mind, the hw
is only 4 years old or so... and future hw may have it again)

clear_page() is more restricted than memset(). And that's good, it
allows for a more focused implementation. Otherwise there'd be no reason
to HAVE a clear_page(), if it just was a memset wrapper entirely.



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

