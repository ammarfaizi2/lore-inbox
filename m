Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTJNSlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTJNSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:41:44 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:55466 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262898AbTJNSlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:41:42 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 14 Oct 2003 11:37:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
Message-ID: <Pine.LNX.4.56.0310141136080.2098@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0310141320020.3869-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Chris Lattner wrote:

>
> My compiler is generating accesses off the bottom of the stack (address
> below %esp).  Is there some funny kernel interaction that I should be
> aware of with this?  I'm periodically getting segfaults.
>
> Example:
>
> int main() {
>    int test[4000];
> ...
>    return 0;
> }
>
> Generated code:
>         .intel_syntax
> ...
> main:
>         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
                         ^^^^^^^^^^^^

Yes, this is the problem (even Windows does that IIRC).



- Davide

