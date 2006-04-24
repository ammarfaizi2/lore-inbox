Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWDXNIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWDXNIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWDXNIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:08:06 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:28422 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750743AbWDXNIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:08:05 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.17-rc2
Date: Mon, 24 Apr 2006 14:08:09 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <63bym-4wt-3@gated-at.bofh.it> <64wre-2cg-35@gated-at.bofh.it> <444C5722.6080605@shaw.ca>
In-Reply-To: <444C5722.6080605@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604241408.09677.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 April 2006 05:42, Robert Hancock wrote:
> Alistair John Strachan wrote:
> > On Saturday 22 April 2006 02:07, Andi Kleen wrote:
> > [snip]
> >
> >> They probably forget to set PROT_EXEC in either mprotect or mmap
> >> somewhere. You can check in /proc/*/maps which mapping contains the
> >> address it is faulting on and then try to find where it is allocated or
> >> mprotect'ed.
> >
> > Turned out this was exactly what the problem was. Wine attempts to match
> > Windows as far as read/write/execute mappings go, and war3.exe tried to
> > execute memory in a section with "MEM_EXECUTE" not set.
> >
> > I'm surprised the program works on Windows with DEP/NX enabled, but
> > apparently it does.
>
> Are you sure that it does? NX is not enabled by default on XP except on
> Windows system processes, even on CPUs supporting hardware NX, so it
> might well have failed with it turned on (especially since the problem
> seemed to show up after some no-CD crack was applied).

Linux 2.6.16 worked, 2.6.17-rc does not. As far as I'm concerned, this is a 
regression.

Linux should not be forced to make arguably silly policy decisions like 
disabling NX for 32bit applications not but "system processes", and as Andi 
has mentioned NX _is_ runtime configurable, should one wish to disable it for 
a given binary on an NX-enforcing kernel.

Wine pretends to be Windows. Therefore Wine should enforce the same "default 
policy" as Windows, or make it runtime configurable in the same manner. In 
this case, the workaround is cheap, fixes a real world application, and does 
not interfere with Linux's NX policy.

Ultimately, we'll see if Alexandre Julliard agrees with the change. If not, 
then I guess this particular application will fail to work on 2.6.17, forcing 
me to investigate alternatives.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
