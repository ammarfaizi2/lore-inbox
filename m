Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbULAGmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbULAGmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 01:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULAGmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 01:42:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:31479 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261243AbULAGmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 01:42:39 -0500
Message-ID: <41AD67E0.9070207@us.ibm.com>
Date: Wed, 01 Dec 2004 00:42:40 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2-mm4 - cifs.ko needs unknown symbol CIFSSMBSetPosixACL
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks I have just updated fs/Kconfig and fs/cifs/xattr.c in the patch 
(actually in the cifs bk tree) to make the cifs POSIX ACL enablement 
dependent on cifs xattrs and to properly ifdef that function as it was 
in the CIFSSMBGetPosixACL

Today I had also made some minor error mapping changes on errors when 
various types of servers don't support POSIX ACLs (the servers did not 
return consistent error messages).

The CIFS code has had major recent update (most importantly the 
cifs_readdir rewrite which can be enabled in mm by "echo 1 > 
/proc/fs/cifs/NewReaddirEnabled", but also the POSIX ACL support which 
will work to Samba 3.10pre server, and also various misc fixes).
If the testing of the readdir change goes ok, and the misc. Windows and 
Samba testing continues ok over the next few days I would like to push 
this up (although I will remove the /proc/fs/cifs/NewReaddirEnabled and 
the corresponding old cifs_readdir, and the old CIFSSMBFindFirst and 
CIFSSMBFindNext routines when I get additional feedback from the mm tree 
and users running the equivalent cifs only patch).

Let me know if you find any additional problems.

Thanks,
Steve

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench at-sign us dot ibm dot com

Andrew Morton <akpm@osdl.org> wrote on 11/30/2004 05:53:21 PM:

 > Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
 > >
 > > WARNING: /lib/modules/2.6.10-rc2-mm4/kernel/fs/cifs/cifs.ko needs
 > unknown symbol CIFSSMBSetPosixACL
 > >
 > > Either it is really missing or a dependecy is not declared somewhere.
 >
 > It looks like there's a slipup in bk-cifs.patch.  If you enable
 > CONFIG_CIFS_POSIX it'll probably link OK.
