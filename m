Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268838AbUJFRfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268838AbUJFRfS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 13:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUJFRfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 13:35:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268838AbUJFRfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 13:35:06 -0400
Message-ID: <41642CBA.7030709@redhat.com>
Date: Wed, 06 Oct 2004 13:34:50 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Bennee <kernel-hacker@bennee.com>
CC: "LinuxSH (sf)" <linuxsh-dev@lists.sourceforge.net>,
       "Linux-SH (m17n)" <linux-sh@m17n.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RFC. User space backtrace on segv
References: <1097080652.5420.34.camel@cambridge>
In-Reply-To: <1097080652.5420.34.camel@cambridge>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bennee wrote:
> Hi,
> 
> I hacked up this little patch to dump the stack and attempt to generate
> a back-trace for errant user-space tasks.
> 
> What:
> 
> Generates a back-trace of the user application on (in this case) a segv
> caused by an unaligned access. This particular patch is against 2.4.22
> on the SH which is what I'm working with but there no reason it couldn't
> be more generalised.
> 
> How:
> 
> Its not the most intelligent approach as it basically walks up the stack
> reading values and seeing if the address corresponds to one of the
> processes executable VMA's. If it matches it assumes its the return
> address treats that section as a "frame"
> 
> Why:
> 
> I work with embedded systems and for a myriad of reasons doing a full
> core dump of the crashing task is a pain. Often just knowing the
> immediate call stack and local variables is enough to look at what went
> wrong with objdump -S.
> 
> Questions:
> 
> Have I replicated anything that is already hidden in the code base?
> Would this be useful (as a CONFIG_ option) for embedded systems?
> 


IIRC, there is already a backtrace function defined for most arches in 
the c library.  in execinfo.h there is a family of backtrace functions 
that can unwind the stack fairly well for most arches, and store the 
trace in a post SIGSEGV-safe fashion.

Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
