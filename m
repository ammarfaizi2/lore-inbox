Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVCNVk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVCNVk1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVCNVk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:40:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:51123 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261952AbVCNViV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:38:21 -0500
Message-ID: <42360443.8030606@osdl.org>
Date: Mon, 14 Mar 2005 13:38:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       sam@ravnborg.org
Subject: Re: [PATCH] buildcheck: reduce DEBUG_INFO noise from reference* scripts
References: <29073.1110832439@ocs3.ocs.com.au>
In-Reply-To: <29073.1110832439@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Mon, 14 Mar 2005 11:02:09 -0800, 
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> 
>>Reduce noise in 'make buildcheck' that is caused by CONFIG_DEBUG_INFO=y.
>>
>>Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
>>
>>diffstat:=
>>scripts/reference_discarded.pl |    3 +++
>>scripts/reference_init.pl      |    1 +
>>2 files changed, 4 insertions(+)
>>
>>diff -Naurp ./scripts/reference_discarded.pl~ref_init_debugs ./scripts/reference_discarded.pl
>>--- ./scripts/reference_discarded.pl~ref_init_debugs	2005-03-01 23:38:08.000000000 -0800
>>+++ ./scripts/reference_discarded.pl	2005-03-14 10:38:47.000000000 -0800
>>@@ -82,6 +82,8 @@ foreach $object (keys(%object)) {
>>		}
>>		if (($line =~ /\.text\.exit$/ ||
>>		     $line =~ /\.exit\.text$/ ||
>>+		     $line =~ /\.text\.init$/ ||
>>+		     $line =~ /\.init\.text$/ ||
>>		     $line =~ /\.data\.exit$/ ||
>>		     $line =~ /\.exit\.data$/ ||
>>		     $line =~ /\.exitcall\.exit$/) &&
>>@@ -96,6 +98,7 @@ foreach $object (keys(%object)) {
>>		     $from !~ /\.debug_ranges$/ &&
>>		     $from !~ /\.debug_line$/ &&
>>		     $from !~ /\.debug_frame$/ &&
>>+		     $from !~ /\.debug_loc$/ &&
>>		     $from !~ /\.exitcall\.exit$/ &&
>>		     $from !~ /\.eh_frame$/ &&
>>		     $from !~ /\.stab$/)) {
>>diff -Naurp ./scripts/reference_init.pl~ref_init_debugs ./scripts/reference_init.pl
>>--- ./scripts/reference_init.pl~ref_init_debugs	2005-03-01 23:38:17.000000000 -0800
>>+++ ./scripts/reference_init.pl	2005-03-14 10:40:19.000000000 -0800
>>@@ -98,6 +98,7 @@ foreach $object (sort(keys(%object))) {
>>		     $from !~ /\.pdr$/ &&
>>		     $from !~ /\__param$/ &&
>>		     $from !~ /\.altinstructions/ &&
>>+		     $from !~ /\.eh_frame/ &&
>>		     $from !~ /\.debug_/)) {
>>			printf("Error: %s %s refers to %s\n", $object, $from, $line);
>>		}
>>
> 
> 
> Adding .debug_loc and .eh_frame to the exclude lists is fine.  But why
> add .text.init and .init.text to the selection list in
> reference_discarded.pl?  reference_discarded.pl only looks at exit
> sections, not init sections.  reference_init.pl already handles the
> init sections.

Indeed, it's actually much worse with that patch section added.  :(
I don't know how I got there.

Sam, can you drop the very first patch section here, or shall I send
a new patch for this?

-- 
~Randy
