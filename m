Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWFGPzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWFGPzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWFGPzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:55:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932272AbWFGPzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:55:46 -0400
Message-ID: <4486F5C7.60606@redhat.com>
Date: Wed, 07 Jun 2006 11:50:31 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, Neil Brown <neilb@suse.de>,
       NFS List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] NFS server does not update mtime on setattr request
References: <4485C3FE.5070504@redhat.com> <1149658707.27298.10.camel@localhost> <4486E662.5080900@redhat.com> <20060607151754.GB23954@fieldses.org> <4486F020.3030707@redhat.com> <20060607154258.GA22335@fieldses.org>
In-Reply-To: <20060607154258.GA22335@fieldses.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:

>On Wed, Jun 07, 2006 at 11:26:24AM -0400, Peter Staubach wrote:
>  
>
>>J. Bruce Fields wrote:
>>    
>>
>>>What's the basis for that interpretation?  The language seems extremely
>>>clear:
>>>
>>>	"On successful completion, if the file size is changed, these
>>>	functions will mark for update the st_ctime and st_mtime fields
>>>	of the file, and if the file is a regular file, the S_ISUID and
>>>	S_ISGID bits of the file mode may be cleared."
>>>
>>>Why are you concerned about this?  Do you have an actual application
>>>that breaks?
>>>      
>>>
>>Yes, there is a customer who is quite unhappy that the semantics over Linux
>>client NFS are different than those of BSD, Solaris, and local file system
>>access on Linux itself.  The basis for my work is based on a bugzilla from
>>this customer.
>>    
>>
>
>OK; just out of curiosity, what's the url/bug number/whatever?
>
>  
>

The Red Hat BZ number is 193621.  The description is that when zero length
files are copied, even over an existing zero length file, the mtime on the
target file does not change.

       ps

>>My interpretation is based on looking at the local behavior on Linux, which
>>changes mtime/ctime even if the file size does not change, and SunOS, which
>>changes mtime/ctime even if the file size does not change and is very
>>heavily SUSv3 compliant.
>>    
>>
>
>Fair enough.
>
>  
>
>>In this case, "changed" does not mean "made different".  It simply means
>>that the file size is set to the new value.
>>    
>>
>
>That's ridiculous, though; that's just not what "changed" means, and
>that renders the "if" clause redundant.  Better just to say "SUS is
>wrong, and this is what everybody actually does...."
>
