Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbVKYPn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbVKYPn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 10:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVKYPn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 10:43:28 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:16432 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161115AbVKYPn2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 10:43:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tRQU3SoJy8BGwhO3/s9STEv99oQAPMmhqNPF1PoSX7LTHSUuFQsVDZCZ+YkCGOsjgcEeSRWbDkClZoL7xcYu/x7J0slQxlMWQK7Pp359FIAhqLYqOu6EHXctnfmwyNpEZoN9xgmVTdInjuFtKgCwyko5hBJEzAi6MdGdNy6+Qw0=
Date: Fri, 25 Nov 2005 16:43:17 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 00/19] Adaptive read-ahead V8
Message-Id: <20051125164317.c42c0639.diegocg@gmail.com>
In-Reply-To: <20051125151210.993109000@localhost.localdomain>
References: <20051125151210.993109000@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 25 Nov 2005 23:12:10 +0800,
Wu Fengguang <wfg@mail.ustc.edu.cn> escribió:

> Overview
> ========
> 
> The current read-ahead logic uses an inflexible algorithm with 128KB
> VM_MAX_READAHEAD. Less memory leads to thrashing, more memory helps no
> throughput. The new logic is simply safer and faster. It makes sure
> every single read-ahead request is safe for the current load. Memory
> tight systems are expected to benefit a lot: no thrashing any more.
> It can also help boost I/O throughput for large memory systems, for
> VM_MAX_READAHEAD now defaults to 1MB. The value is no longer tightly
> coupled with the thrashing problem, and therefore constrainted by it.


Recently, a openoffice hacker wrote in his blog that the kernel was
culprit of applications not starting as fast as in other systems.
Most of the reasons he gave were wrong, but there was a interesting
one: When you start your system, you've lots of free memory. Since
you have lots of memory, he said it was reasonable to expect that
kernel would readahead *heavily* everything it can to fill that
memory as soon as possible (hoping that what you readahead'ed was
part of the kde/gnome/openoffice libraries etc) and go back to the
normal behaviour when your free memory is used by caches etc.
"Teorically" it looks like a nice heuristic for desktops. Does
adaptative readahead does something like this?
