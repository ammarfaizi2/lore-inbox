Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVBJGuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVBJGuP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 01:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVBJGuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 01:50:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7059 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262031AbVBJGuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 01:50:04 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16907.1041.304161.554777@tut.ibm.com>
Date: Thu, 10 Feb 2005 00:49:53 -0600
To: maneesh@in.ibm.com
Cc: Tom Zanussi <zanussi@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 4
In-Reply-To: <20050210063054.GA4216@in.ibm.com>
References: <16906.52160.870346.806462@tut.ibm.com>
	<20050210063054.GA4216@in.ibm.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni writes:
 > On Wed, Feb 09, 2005 at 08:49:36PM -0600, Tom Zanussi wrote:
 > [..]
 > > + */
 > > +struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
 > > +				   int mode, struct rchan *chan)
 > > +{
 > > +	struct dentry *dentry;
 > > +	int error;
 > > +	
 > > +	if (!mode)
 > > +		mode = S_IRUSR;
 > > +	mode = (mode & S_IALLUGO) | S_IFREG;
 > > +
 > > +	error = relayfs_create_entry(name, parent, mode, chan, &dentry);
 > 
 > ^^^^
 > I think you missed GregKH's suggesstion to have relayfs_create_entry()
 > return pointer to struct dentry, and reduce one parameter.

Yes, you're right - somehow I missed that one.

 > > +
 > > +	if (unlikely(relay_buf_full(buf))) {
 > > +		return 0;
 > > +		buf->chan->cb->buf_full(buf);
 > 
 > 		^^^^^^^^
 > 		Typo? statement after return !

Yikes!  Obviously I haven't tested the buffer full condition yet ;-)

Thanks for pointing these out.

Tom

