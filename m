Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVCNUhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVCNUhv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 15:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVCNUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 15:37:39 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:41670 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261882AbVCNUeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 15:34:12 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [PATCH] buildcheck: reduce DEBUG_INFO noise from reference* scripts 
In-reply-to: Your message of "Mon, 14 Mar 2005 11:02:09 -0800."
             <20050314110209.5ced9d9d.rddunlap@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Mar 2005 07:33:59 +1100
Message-ID: <29073.1110832439@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 11:02:09 -0800, 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
>Reduce noise in 'make buildcheck' that is caused by CONFIG_DEBUG_INFO=y.
>
>Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
>
>diffstat:=
> scripts/reference_discarded.pl |    3 +++
> scripts/reference_init.pl      |    1 +
> 2 files changed, 4 insertions(+)
>
>diff -Naurp ./scripts/reference_discarded.pl~ref_init_debugs ./scripts/reference_discarded.pl
>--- ./scripts/reference_discarded.pl~ref_init_debugs	2005-03-01 23:38:08.000000000 -0800
>+++ ./scripts/reference_discarded.pl	2005-03-14 10:38:47.000000000 -0800
>@@ -82,6 +82,8 @@ foreach $object (keys(%object)) {
> 		}
> 		if (($line =~ /\.text\.exit$/ ||
> 		     $line =~ /\.exit\.text$/ ||
>+		     $line =~ /\.text\.init$/ ||
>+		     $line =~ /\.init\.text$/ ||
> 		     $line =~ /\.data\.exit$/ ||
> 		     $line =~ /\.exit\.data$/ ||
> 		     $line =~ /\.exitcall\.exit$/) &&
>@@ -96,6 +98,7 @@ foreach $object (keys(%object)) {
> 		     $from !~ /\.debug_ranges$/ &&
> 		     $from !~ /\.debug_line$/ &&
> 		     $from !~ /\.debug_frame$/ &&
>+		     $from !~ /\.debug_loc$/ &&
> 		     $from !~ /\.exitcall\.exit$/ &&
> 		     $from !~ /\.eh_frame$/ &&
> 		     $from !~ /\.stab$/)) {
>diff -Naurp ./scripts/reference_init.pl~ref_init_debugs ./scripts/reference_init.pl
>--- ./scripts/reference_init.pl~ref_init_debugs	2005-03-01 23:38:17.000000000 -0800
>+++ ./scripts/reference_init.pl	2005-03-14 10:40:19.000000000 -0800
>@@ -98,6 +98,7 @@ foreach $object (sort(keys(%object))) {
> 		     $from !~ /\.pdr$/ &&
> 		     $from !~ /\__param$/ &&
> 		     $from !~ /\.altinstructions/ &&
>+		     $from !~ /\.eh_frame/ &&
> 		     $from !~ /\.debug_/)) {
> 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
> 		}
>

Adding .debug_loc and .eh_frame to the exclude lists is fine.  But why
add .text.init and .init.text to the selection list in
reference_discarded.pl?  reference_discarded.pl only looks at exit
sections, not init sections.  reference_init.pl already handles the
init sections.

