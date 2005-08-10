Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965146AbVHJPGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVHJPGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 11:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVHJPGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 11:06:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:11966 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965146AbVHJPGC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 11:06:02 -0400
Message-ID: <42FA17CB.1020702@us.ibm.com>
Date: Wed, 10 Aug 2005 11:05:47 -0400
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: serue@us.ibm.com
CC: Florian Weimer <fw@deneb.enyo.de>, viro@parcelfarce.linux.theplanet.co.uk,
       sds@tycho.nsa.gov, linuxram@us.ibm.com, ericvh@gmail.com,
       dwalsh@redhat.com, jmorris@redhat.com, akpm@osdl.org, torvalds@osdl.org,
       gh@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New system call, unshare
References: <Pine.WNT.4.63.0508080923470.3668@IBM-AIP3070F3AM> <878xz9dgv4.fsf@mid.deneb.enyo.de> <20050810141849.GA5639@serge.austin.ibm.com>
In-Reply-To: <20050810141849.GA5639@serge.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

serue@us.ibm.com wrote:
> Quoting Florian Weimer (fw@deneb.enyo.de):
> 
>>* Janak Desai:
>>
>>
>>>With unshare, namespace setup can be done using PAM session
>>>management functions without patching individual commands.
>>
>>I don't think it's a good idea to use security-critical code well
> 
> 
> Note that this patch is not removing the CAP_SYS_ADMIN requirement,
> just allowing the operation to happen outside of clone().  Unlike
> domain transitions in selinux, which should be tied to exec() so
> as to tie them to known code, I don't see what clone() would provide
> in terms of safety which we are losing.
> 
> 
>>without its original specification.  Clearly the current situation
>>sucks, but this is mainly a lack of PAM functionality, IMHO.
> 
> 
> I'm not sure this is to do with PAM functionality, rather than
> just its design.  Is there a way of "fixing" pam so that we don't
> need unshare()?
> 

I have been trying to narrow down the problem since Alan's post
about using clone() instead of unshare. The problem comes down to
parent, on _exit(), clobbering controlling tty. I have tried, from
the child, to close and open the tty stored in PAM but that has
not helped.

-Janak

