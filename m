Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267198AbUBSMBI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 07:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267204AbUBSMBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 07:01:08 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:28613 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S267198AbUBSMBG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 07:01:06 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: kjo <kernel-janitors@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: reference_init.pl for Linux 2.6 
In-reply-to: Your message of "Wed, 18 Feb 2004 18:23:13 -0800."
             <20040218182313.7b7b915e.rddunlap@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Feb 2004 23:00:48 +1100
Message-ID: <2263.1077192048@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 18:23:13 -0800, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>I have updated Keith Owens "reference_init.pl" script for
>Linux 2.6.  It searches for code that refers to other code
>sections that they should not reference, such as init code
>calling exit code or v.v.
>script for Linux 2.6 is at:
>http://developer.osdl.org/rddunlap/scripts/reference_init26.pl

You added '$from !~ /\.data/'.  Any references from the .data section
to .init or .exit text should be checked.  It is usually a struct
containing a pointer to code that will be discarded, and is dangerous.

There is also a spurious comment line,
#                   $from !~ $line && $line !~ $from &&

