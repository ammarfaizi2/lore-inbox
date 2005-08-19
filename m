Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVHSVZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVHSVZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbVHSVZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:25:17 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:36529 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S965173AbVHSVZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:25:15 -0400
Date: Fri, 19 Aug 2005 23:24:59 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050819212459.GA10414@ens-lyon.fr>
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <200508191145.58835.tomlins@cam.org> <40f323d0050819090473d2c268@mail.gmail.com> <200508191701.05925.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508191701.05925.tomlins@cam.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 05:01:05PM -0400, Ed Tomlinson wrote:
> Hi,
> 
> Adding the include to dmi.h allows the compile to get past this point though I
> wonder if this is the correct place to put it?  (Thanks Benoit)
> 
> I now get:
> 
>   CC [M]  net/ipv4/ipvs/ip_vs_ctl.o
> net/ipv4/ipvs/ip_vs_ctl.c:1601: error: static declaration of 'ipv4_table' follows non-static declaration
> include/net/ip.h:376: error: previous declaration of 'ipv4_table' was here
> make[3]: *** [net/ipv4/ipvs/ip_vs_ctl.o] Error 1
> make[2]: *** [net/ipv4/ipvs] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
> 
> Ideas?
> 

I think the following is patch needed because ipv4_table is local to
ipvs.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- ./net/ipv4/ipvs/ip_vs_lblc.c	2004-12-24 22:35:28.000000000 +0100
+++ ./net/ipv4/ipvs/ip_vs_lblc.c.new	2005-08-19 23:22:09.000000000 +0200
@@ -131,7 +131,7 @@ static ctl_table vs_table[] = {
 	{ .ctl_name = 0 }
 };
 
-static ctl_table ipv4_table[] = {
+static ctl_table ipv4_vs_table[] = {
 	{
 		.ctl_name	= NET_IPV4,
 		.procname	= "ipv4", 
@@ -146,7 +146,7 @@ static ctl_table lblc_root_table[] = {
 		.ctl_name	= CTL_NET,
 		.procname	= "net", 
 		.mode		= 0555, 
-		.child		= ipv4_table
+		.child		= ipv4_vs_table
 	},
 	{ .ctl_name = 0 }
 };
--- ./net/ipv4/ipvs/ip_vs_lblcr.c	2004-12-24 22:35:24.000000000 +0100
+++ ./net/ipv4/ipvs/ip_vs_lblcr.c.new	2005-08-19 23:22:25.000000000 +0200
@@ -320,7 +320,7 @@ static ctl_table vs_table[] = {
 	{ .ctl_name = 0 }
 };
 
-static ctl_table ipv4_table[] = {
+static ctl_table ipv4_vs_table[] = {
 	{
 		.ctl_name	= NET_IPV4,
 		.procname	= "ipv4", 
@@ -335,7 +335,7 @@ static ctl_table lblcr_root_table[] = {
 		.ctl_name	= CTL_NET,
 		.procname	= "net", 
 		.mode		= 0555, 
-		.child		= ipv4_table
+		.child		= ipv4_vs_table
 	},
 	{ .ctl_name = 0 }
 };
