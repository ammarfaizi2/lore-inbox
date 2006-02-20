Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWBTWhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWBTWhK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 17:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWBTWgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 17:36:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59916 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932687AbWBTWgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 17:36:07 -0500
Date: Mon, 20 Feb 2006 23:36:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, dada1@cosmosbay.com,
       davem@davemloft.net, netdev@vger.kernel.org
Subject: [2.6 patch] make UNIX a bool
Message-ID: <20060220223606.GK4661@stusta.de>
References: <20060217154147.GL29846@in.ibm.com> <20060217154337.GM29846@in.ibm.com> <20060217154626.GN29846@in.ibm.com> <20060218010414.1f8d6782.akpm@osdl.org> <20060218092517.GP29846@in.ibm.com> <20060218121402.GB911@infradead.org> <1140265890.4035.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140265890.4035.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 01:31:30PM +0100, Arjan van de Ven wrote:
> On Sat, 2006-02-18 at 12:14 +0000, Christoph Hellwig wrote:
> > > > - Make the get_max_files export use _GPL - only unix.ko uses it.
> > 
> > The real question is, does af_unix really need to allow beeing built
> > modular?  It's quite different from other network protocol and deeply
> > tied to the kernel due to things like descriptor passing or using
> > the filesystem namespace.  I already had to export another symbol that
> > really should be internal just for it, and if one module acquires lots
> > of such hacks it's usually a bad sign..
> 
> in 2.4 the answer would have been simple; modutils back then used
> AF_UNIX stuff before it could load modules, so modular was in practice
> impossible. 
> 
> Anyway I'd agree with making this non-modular... NOBODY will use this as
> a module, or if they do loading it somehow is the very first thing done.
> You just can't live without this, so making it a module is non-sensical.

So let's send a patch.  ;-)

cu
Adrian


<--  snip  -->


CONFIG_UNIX=m doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc4-mm1-full/net/unix/Kconfig.old	2006-02-20 14:40:19.000000000 +0100
+++ linux-2.6.16-rc4-mm1-full/net/unix/Kconfig	2006-02-20 14:40:27.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 config UNIX
-	tristate "Unix domain sockets"
+	bool "Unix domain sockets"
 	---help---
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and

