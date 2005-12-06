Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbVLFEnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbVLFEnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbVLFEnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:43:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:58288 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751651AbVLFEnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:43:01 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jean Delvare <khali@linux-fr.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Questions on __initdata 
In-reply-to: Your message of "Sun, 04 Dec 2005 15:15:33 BST."
             <20051204151533.13df37c6.khali@linux-fr.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Dec 2005 15:42:46 +1100
Message-ID: <9121.1133844166@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2005 15:15:33 +0100, 
Jean Delvare <khali@linux-fr.org> wrote:
>Hi all,
>
>I've been reading the heading comment of include/linux/init.h to learn
>when and how __initdata can be used. Some of the help text doesn't seem
>to match my observations, and some of it confused me and could probably
>be made clearer. However, I don't feel completely comfortable with this
>topic yet and would welcome comments.
>
>First, the comment goes:
>
>> /* These macros are used to mark some functions or 
>>  * initialized data (doesn't apply to uninitialized data)
>>  * as `initialization' functions. The kernel can take this
>>  * as hint that the function is used only during the initialization
>>  * phase and free up used memory resources after
>
>My tests (on i386) seem to suggest that "doesn't apply to uninitialized
>data" only holds for non-global variables. Tagging uninitialized global
>variables __initdata works, and moves the variables from .bss to .data.
>Is it correct? Does it work on all archs? If so, the comment above
>needs to be fixed.

gcc version dependent.  Older versions of gcc put all uninitialized
global variables into .bss, even if there was an attribute like
__initdata that tried to use a different section.  So we got into the
habit of '__initdata variables must be explicitly initialized'.  Some
platforms are using old versions of gcc where that restriction may
still apply.

