Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTKYIhC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 03:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTKYIhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 03:37:02 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:44549 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262109AbTKYIhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 03:37:00 -0500
Date: Tue, 25 Nov 2003 08:36:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com, Paul.McKenney@us.ibm.com
Subject: Re: [BUG]Missing i_sb NULL pointer check in destroy_inode()
Message-ID: <20031125083643.A15777@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mingming Cao <cmm@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com,
	Paul.McKenney@us.ibm.com
References: <1068066524.10726.289.camel@socrates> <20031106033817.GB22081@thunk.org> <1068145132.10735.322.camel@socrates> <20031106123922.Y10197@schatzie.adilger.int> <1068148881.10730.337.camel@socrates> <1068230146.10726.359.camel@socrates> <20031109130826.2b37219d.akpm@osdl.org> <1068419747.687.28.camel@socrates> <20031109152936.3a9ffb69.akpm@osdl.org> <1069700440.16649.19433.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1069700440.16649.19433.camel@localhost.localdomain>; from cmm@us.ibm.com on Mon, Nov 24, 2003 at 11:00:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 11:00:38AM -0800, Mingming Cao wrote:
> Hello, Andrew, Marcelo,
> 
> destroy_inode() dereferences inode->i_sb without checking if it is NULL.
> This is inconsistent with its caller: iput() and clear_inode(),  both of
> which check inode->i_sb before dereferencing it. Since iput() calls
> destroy_inode() after calling file system's .clear_inode method(via
> clear_inode()),  some file systems might choose to clear the i_sb in the
> .clear_inode super block operation. This results in a crash in
> destroy_inode().
> 
> This issue exists in both 2.6, 2.4 and 2.4 kernel.  A simple fix against
> 2.6.0-test9 is included below. 2.4 based fix should be very similar to
> this one.  Please take a look and consider include it.  

inode->i_sb can't be NULL.  We should remove all those checks.

