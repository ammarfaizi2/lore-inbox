Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUIITMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUIITMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUIITK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:10:57 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:53423 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266753AbUIITFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:05:21 -0400
Date: Thu, 9 Sep 2004 15:05:11 -0400
From: "Serge E. Hallyn" <hallyn@CS.WM.EDU>
To: Chris Wright <chrisw@osdl.org>
Cc: Makan Pourzandi <Makan.Pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication of binaries
Message-ID: <20040909190511.GB28807@escher.cs.wm.edu>
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com> <20040909105520.U1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909105520.U1924@build.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
...
> > We realized that when a shared library is opened by a binary it can 
> > still be modified. To solve the problem, we block the write access to 
> > the shared binary while it is loaded.
> 
> AFAICT, this means anybody with read access to a file can block all
> writes.  This doesn't sound great.

True.

This could be fixed by adding a check at the top of dsi_file_mmap for
file->f_dentry->d_inode->i_mode & MAY_EXEC.  Of course then shared
libraries which are installed without execute permissions will cause
apps to break.  On my quick test, I couldn't run xterm or vi  :)

Note that blocking writes requires that the file be a valid ELF file,
as this is all that digsig mediates.  So I'm not sure which we worry
about more - the fact that all shared libraries have to be installed
with execute permissions (under the proposed solution), or that write
to an ELF file can be prevented by mmap(PROT_EXEC).  Presumably, if
you are replacing an ELF file, you will always want to do 
"mv foo.so foo.so.del; cp new/foo.so foo.so" anyway.

Thoughts?

thanks,
-serge
