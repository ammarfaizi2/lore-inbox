Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWJKAuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWJKAuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 20:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWJKAuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 20:50:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:9099 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964976AbWJKAuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 20:50:03 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Matt Helsley <matthltc@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Paul Menage <menage@google.com>, linux-kernel@vger.kernel.org,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20061010215808.GK7911@ca-server1.us.oracle.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 10 Oct 2006 17:49:59 -0700
Message-Id: <1160527799.1674.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 14:58 -0700, Joel Becker wrote:
> On Tue, Oct 10, 2006 at 02:31:43PM -0700, Paul Menage wrote:
> > >        NAK.  This forces a complex and inappropriate interface on the
> > >majority of users, and doesn't honor configfs' simplicity-first design.
> > 
> > How is the seq_file interface complex and inappropriate? For the
> > configfs clients it's basically a drop-in replacement for sprintf(),
> > as Chandra's patches show.
> 
> 	Well, they now have to learn seq_file.  They now get to assume
> that "spewing large amounts of junk" is the default rather than "single
> attribute", which is correct.  None of it is relevant for the majority
> of correct users.

	We want to be able to export a sequence of small (<< 1 page),
homogenous, unstructured (scalar), attributes through configfs using the
same file. While this is rather specific, I'd guess it would be a common
occurrence.

	Yes, keeping track of writing to these sequences (add, remove, replace)
is a problem. But that's what the file position is for. configfs could
support exporting sequences of common (scalar) types that need to be
exported from the kernel. Types like u32, u64, pid_t, etc. Then seek can
be used to index into the sequence to indicate append or replace. seek
and truncate would have to be translated into bytes so configfs can
manage the buffers behind the scenes while passing sequence position to
the code that uses configfs.

	Does this seem reasonable?

Cheers,
	-Matt Helsley

