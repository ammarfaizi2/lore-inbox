Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVAMHg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVAMHg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 02:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAMHg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 02:36:26 -0500
Received: from canuck.infradead.org ([205.233.218.70]:19464 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261181AbVAMHgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 02:36:17 -0500
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
From: Arjan van de Ven <arjan@infradead.org>
To: paulmck@us.ibm.com
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jtk@us.ibm.com, wtaber@us.ibm.com,
       pbadari@us.ibm.com, markv@us.ibm.com, gregkh@us.ibm.com,
       tytso@us.ibm.com, suparna@in.ibm.com
In-Reply-To: <20050113025157.GA2849@us.ibm.com>
References: <20050106190538.GB1618@us.ibm.com>
	 <1105039259.4468.9.camel@laptopd505.fenrus.org>
	 <20050106201531.GJ1292@us.ibm.com>
	 <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	 <20050106210408.GM1292@us.ibm.com>
	 <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050107010119.GS1292@us.ibm.com>  <20050113025157.GA2849@us.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Jan 2005 08:35:58 +0100
Message-Id: <1105601758.6031.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 18:51 -0800, Paul E. McKenney wrote:
> On Thu, Jan 06, 2005 at 05:01:19PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 06, 2005 at 09:24:17PM +0000, Al Viro wrote:
> > > "Use recursive bindings instead of trying to take over the entire mount tree
> > > and mirroring it within your fs code.  And do that explicitly from userland".
> > 
> > Thank you for the pointer!  By this, you mean do mount operations in
> > conjunction with namespaces, right?
> > 
> > I will follow up with more detail as I learn more.  The current issue
> > seems to be with removeable devices.  Their users want to be accessing
> > a particular version, but still see a memory stick that was subsequently
> > mounted outside of the view.  Straightforward use of mounts and namespaces
> > would prevent the memory stick from being visible to users that were
> > already in view.
> 
> OK, after much thrashing, here is what the ClearCase users need.
> Sorry for the length -- the first few paragraphs gives the flavor of
> it and the rest goes into more detail with examples.
> 
> Thoughts?
> 

Interesting; so clearcase mvfs currently extends the linux VFS to do all
this.... It would be very interesting to get these extensions to linux
posted on this mailing list in patch form, since it could well be a nice
generic enhancement of linux. (Assuming Al doesn't go WTF over the code
of course :-)


