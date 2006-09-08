Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751978AbWIHCOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWIHCOI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 22:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbWIHCOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 22:14:08 -0400
Received: from smtp-out.google.com ([216.239.45.12]:29226 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751978AbWIHCOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 22:14:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=Wg+ixQBVNvpwpXaOAn3IgWvuHoVegHz7vS/vVoGL4PAQrv+Gi6cgVDar86RX9S1wv
	m1EHfpt1m/I3CVwEhniGg==
Message-ID: <4500D1E6.7020805@google.com>
Date: Thu, 07 Sep 2006 19:13:58 -0700
From: Edward Falk <efalk@google.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Proper /proc/pid/cmdline behavior when command line is corrupt?
References: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com>
In-Reply-To: <mailman.3.1157626801.14788.linux-kernel-daily-digest@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all; there's a few lines of code in fs/proc/base.c:proc_pid_cmdline() 
that I'm unable to make sense of.  There are a few lines that check the 
returned buffer to see if it's properly nul-terminated.  If not, the 
code assumes the user has overwritten and corrupted the command line buffer.

The next step is to search for the first embedded nul, and truncate the 
buffer at that point.

If no embedded nul is found, enough data is copied from the user's 
environment to fill the buffer.  Another search for an embedded nul is 
then made.

Does anybody know what on earth this code is trying to accomplish?  Is 
this the intended behavior?  The best I can guess is that the user is 
assumed to have overwritten the end of the command line buffer and that 
the environment buffer is assumed to immediately follow the command line 
buffer.

I'm currently working on a patch that removes the one page limit on the 
returned command line buffer but I'm not convinced I should retain this 
behavior.  Is it possible that there's any code out there that depends 
on this behavior.  It would help if I knew why it was done this way.

TIA,
	-ed falk, efalk@google.com
