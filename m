Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbUK0Bcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbUK0Bcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUK0Bcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:32:36 -0500
Received: from neopsis.com ([213.239.204.14]:52884 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S262385AbUK0B0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 20:26:10 -0500
Message-ID: <41A7D814.6060900@dbservice.com>
Date: Sat, 27 Nov 2004 02:27:48 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       matthew@wil.cx, dwmw2@infradead.org, aoliva@redhat.com,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com> <Pine.LNX.4.60.0411270049520.29718@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.60.0411270049520.29718@alpha.polcom.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> On Thu, 25 Nov 2004, David Howells wrote:
> 
>>     (b) Make kernel file #include the user file.
> 
> 
> Does kernel really need to include user headers? When it is definition
 > of some const then it should be defined in one file (to be sure it has
 > only one definition).

You have do define a interface between the kernel and the userspace..
you either include kernel headers from userspace (with a lot of 
__KERNEL__ in them) or you make separate headers with the definitions 
and include them in both kernel and userspace (better).
BTW, these are not userspace headers like the ones in /usr/include, 
those are just special headers preparated so that they can be included 
both from the kernel and userspace.

> But user headers may have some compatibility hacks
> that kernel do not need (and even maybe does not want) to have.

About the compatibility hacks.. now it's time to remove them, together 
with this change. I don't think this will happen before 2.7/2.8 and 
until then all should have changed their code.
If you announce these changes soon enough and the developers have enough 
time to change their code, I don't see any problems.
Maybe you also could wrap these definitions in some #ifdef's and mark 
them as deprecated and write somewhere that they'll be removed in the 
next stable tree (2.8). So you could check if a library compiles with 
the new headers or if it still uses some old definitions.

tom
