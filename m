Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265611AbUAHVCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 16:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbUAHVCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 16:02:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46597 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265611AbUAHVCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 16:02:09 -0500
Message-ID: <3FFDC51B.8070108@zytor.com>
Date: Thu, 08 Jan 2004 13:01:15 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jim Carter <jimc@math.ucla.edu>
CC: Mike Waychison <Michael.Waychison@sun.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <3FFB12AD.6010000@sun.com>	<Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>	<3FFC8E5B.40203@sun.com> <Pine.LNX.4.53.0401080911390.27090@simba.math.ucla.edu>
In-Reply-To: <Pine.LNX.4.53.0401080911390.27090@simba.math.ucla.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Carter wrote:
> 
>>For justification to it's worth, some institutions have file servers
>>that export hundreds or even thousands of shares over NFS.   As /net is
>>really just a kind of executable indirect map that returns multimounts
>>for each hostname used as a key,  just doing 'cd /net/hostname' may
>>potentially mount hundreds of filesystems.  This is not cool!
> 
> Definitely not cool.  But some users (yours truly among them) do "alias ls
> 'ls -F'", which requires "ls" to stat (and thus mount) every exported
> filesystem.  More uncool, and I don't see any non-disgusting way around it.
> 

No, it doesn't... this has been covered several times already.  It
requires ls to *lstat* the point; it only does a stat() if the resulting
entry is S_IFLNK.  The same is true for GUI tools.  There is a fairly
easy way to distinguish lstat() from virtually all other filesystem
calls -- it doesn't invoke follow_link.  So the answer is simply to
create an inode which is S_IFDIR but has a follow_link method.  The
follow_link method triggers a mount.  This is called a "pseudo-symlink
directory" or sometimes "ghost directory".

	-hpa

