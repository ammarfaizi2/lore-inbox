Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUIJVCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUIJVCF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267876AbUIJVCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:02:05 -0400
Received: from imr2.ericy.com ([198.24.6.3]:2234 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S267872AbUIJVBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:01:52 -0400
Message-ID: <41421433.8090804@ericsson.com>
Date: Fri, 10 Sep 2004 16:53:07 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: "Serge E. Hallyn" <hallyn@CS.WM.EDU>, linux-kernel@vger.kernel.org,
       Axelle Apvrille <axelle.apvrille@trusted-logic.fr>, serue@us.ibm.com,
       david.gordon@ericsson.com, gaspoucho@yahoo.com
Subject: Re: [ANNOUNCE] Release Digsig 1.3.1: kernel module for run-time authentication
 of binaries
References: <41407CF6.2020808@ericsson.com> <20040909092457.L1973@build.pdx.osdl.net> <41409378.5060908@ericsson.com> <20040909105520.U1924@build.pdx.osdl.net> <20040909190511.GB28807@escher.cs.wm.edu> <4140BFCE.8010701@ericsson.com> <20040909140349.C1924@build.pdx.osdl.net>
In-Reply-To: <20040909140349.C1924@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

see below:

Chris Wright wrote:
> * Makan Pourzandi (Makan.Pourzandi@ericsson.com) wrote:
> 
>>Serge E. Hallyn wrote:
>>
>>>Quoting Chris Wright (chrisw@osdl.org):
>>>
>>>>AFAICT, this means anybody with read access to a file can block all
>>>>writes.  This doesn't sound great.
>>>
>>>True.
>>
>>>This could be fixed by adding a check at the top of dsi_file_mmap for
>>>file->f_dentry->d_inode->i_mode & MAY_EXEC.  Of course then shared
>>>libraries which are installed without execute permissions will cause
>>>apps to break.  On my quick test, I couldn't run xterm or vi  :)
>>>
>>>Note that blocking writes requires that the file be a valid ELF file,
>>>as this is all that digsig mediates.  So I'm not sure which we worry
>>>about more - the fact that all shared libraries have to be installed
>>>with execute permissions (under the proposed solution), or that write
>>
>>
>>My 2 cents, a quick browsing on my machine (fedora core 1) shows that 
>>almost all my shared libraries are installed with both execution and 
>>read permissions.  IMHO, I don't believe then that this should be 
>>considered as a major issue.
> 
> 
> This has nothing to do with file permissions aside of read.  All you need
> is read permission, then you can mmap(PROT_EXEC) which will kick off the
> check, and do deny_write_access.  It's a freeform way to lock writers
> out of any readable file in the system.  This is why MAP_EXECUTABLE and
> MAP_DENYWRITE are masked off at syscall entry.

Chris, my understanding is that Serge's patch even though it restricts a 
little the system admin, is the best solution we have for time being. Am 
I right?
If this is the case I'll include Serge's patch in the cvs source code 
and send out a new release soon.

regards,
Makan
> 
> thanks,
> -chris

-- 

Makan Pourzandi, Open Systems Lab
Ericsson Research, Montreal, Canada
*This email does not represent or express the opinions of Ericsson Inc.*

