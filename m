Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268350AbUHLCby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268350AbUHLCby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 22:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUHLCby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 22:31:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:57034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268350AbUHLC3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 22:29:36 -0400
Date: Wed, 11 Aug 2004 19:19:00 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: zippel@linux-m68k.org, arnd@arndb.de, hch@infradead.org,
       wli@holomorphy.com, davem@redhat.com, geert@linux-m68k.org,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040811191900.13d9f511.rddunlap@osdl.org>
In-Reply-To: <20040812001848.GW26174@fs.tum.de>
References: <20040807170122.GM17708@fs.tum.de>
	<20040807181051.A19250@infradead.org>
	<20040807172518.GA25169@fs.tum.de>
	<200408072013.01168.arnd@arndb.de>
	<20040811201725.GJ26174@fs.tum.de>
	<Pine.LNX.4.58.0408112223140.20634@scrub.home>
	<20040812001848.GW26174@fs.tum.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004 02:18:48 +0200 Adrian Bunk wrote:

| On Wed, Aug 11, 2004 at 11:45:21PM +0200, Roman Zippel wrote:
| 
| > Hi,
| 
| Hi Roman,
| 
| > On Wed, 11 Aug 2004, Adrian Bunk wrote:
| > 
| > > Roman, is it intentional that PCMCIA!=n is true if there's no PCMCIA 
| > > option, or is it simply a bug?
| > 
| > Yes, undefined symbols have a (string) value of "" . Maybe it's time to 
| > add a warning for such comparisons...
| 
| is there any strong reason why undefined symbols aren't equivalent to 
| symbols with a value of "n"?

I second that question...

| Many !=n seems to be bogus (especially ones from the automatic 
| transition to the new Kconfig) and I'll audit them. But rewriting valid 
| FOO!=n to (FOO=y || FOO=m) doesn't sound like an improvement.

Hm, I've thought that config selections were either boolean or
tristate.  This makes it sound like they could be quadstate (y/n/m/blank).

And the menu dependency doc in Documentation/kbuild/kconfig-language.txt
makes it sound (to me) like undefined values become 'n':

<quote>
Expressions are listed in decreasing order of precedence. 

(1) Convert the symbol into an expression. Boolean and tristate symbols
    are simply converted into the respective expression values. All
    other symbol types result in 'n'.
...
An expression can have a value of 'n', 'm' or 'y' (or 0, 1, 2
respectively for calculations). A menu entry becomes visible when it's
expression evaluates to 'm' or 'y'.
</quote>


--
~Randy
